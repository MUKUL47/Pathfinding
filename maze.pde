import java.util.*;
Maze maze;
final int size = 10;
ArrayList<Node> visitedNodes = new ArrayList<Node>();
boolean exist = false;

void setup(){
  frameRate(10);
  size(520,520);
  init();
  maze.converMazeToMap();
  maze.renderMap();
  BFS(maze.getNodes());
}
void draw(){ //<>//
  if( exist ){ 
    for( Node n : visitedNodes ){
    maze.setPath(n.x,n.y,0,0,0);
    delay(60);
    if( n.x == size-1 && n.y == size-1 ) noLoop();
    
  }
  }
  
}

void init(){
  maze = new Maze(size,new Node[size][size]);
  maze.initMap(2);
  maze.setSrcDest(0,0,size-1,size-1);
}

public void BFS(Node[][] node){
  Stack<Node> vertices = new Stack<Node>();  
  vertices.add(node[0][0]);
  ArrayList<Node> finalPath = new ArrayList<Node>();
  while(!vertices.isEmpty()){
    Node currentNode = vertices.pop();
    visitedNodes.add(currentNode);
    for( Node n : currentNode.neighbour){
      if( n.path && !visitedNodes.contains(n)){        
        vertices.push(n);
      }
    }
  }
  for( Node n : visitedNodes ){    
    if( n.x == size-1 && n.y == size-1 ) { exist = true; break; }
  }   
}

class Node{
int x, y;
boolean path;
int R, G, B;
ArrayList<Node> neighbour;
  public Node(int x, int y){
    this.path     = false;
    this.x        = x;
    this.y        = y;
    this.neighbour= new ArrayList<Node>();
    this.R        = 0;
    this.G        = 255;
    this.B        = 255;
  }
  public void setPath(){
    this.path = true;
  }
  public void setRGB(int r, int g, int b){
    this.R        = r;
    this.G        = g;
    this.B        = b;
  }
  public void addNeighbour(Node nextNode, Node currentNode){
    if( !neighbour.contains(nextNode) && !nextNode.neighbour.contains(currentNode)){
      this.neighbour.add(nextNode);
      nextNode.neighbour.add(currentNode);
    }
  }  
}

class Maze{
int size;
Node[][] nodes;

  public Maze(int size, Node[][] nodes){
   this.size = size;
   this.nodes = nodes;
   this.nodes = new Node[this.size][this.size];
  }
  
  void initMap(int obstacleProbabilty){
    for(int i = 0; i < this.size; i++){
      for(int j = 0; j < this.size; j++ ){    
        this.nodes[i][j] = new Node(i,j);
        if( round(random(obstacleProbabilty)) == 1 ){           
          this.nodes[i][j].path = true;
          this.nodes[i][j].setRGB(255,0,0);
        }
      }
      println();
    }
  }
 public Node[][] getNodes(){
   return this.nodes;
 }
  
  void renderMap(){
  for(int i = 0; i < this.size; i++){
    for(int j = 0; j < this.size; j++ ){  
      fill(this.nodes[i][j].R,this.nodes[i][j].G,this.nodes[i][j].B);
      rect(j*53,i*53,53,53);
    }
  }
}
  void setSrcDest(int sX, int sY, int dX, int dY){
    this.nodes[sX][sY].setRGB(0,0,0);    
    this.nodes[sX][sY].setPath();
    this.nodes[dX][dY].setRGB(0,0,0);    
    this.nodes[dX][dY].setPath();
}
public void setPath(int x, int y , int r, int g, int b){
  this.nodes[x][y].setRGB(r,g,b);
}
  void converMazeToMap(){
  for(int i = 0; i < this.size-1; i++){
    for(int j = 0; j < this.size-1; j++){
        this.nodes[i][j].addNeighbour(this.nodes[i+1][j+1],this.nodes[i][j]);
    }
  }
  for(int i = 0; i < this.size-1; i++){
    for(int j = 1; j < this.size; j++){
        this.nodes[i][j].addNeighbour(this.nodes[i+1][j-1],this.nodes[i][j]);
    }
  }
  for(int i = 0; i < this.size; i++){
    for(int j = 0; j < this.size-1; j++){
        this.nodes[i][j].addNeighbour(this.nodes[i][j+1],this.nodes[i][j]);
    }
  }
  for(int i = 0; i < this.size-1; i++){
    for(int j = 0; j < this.size; j++){
        this.nodes[i][j].addNeighbour(this.nodes[i+1][j],this.nodes[i][j]);
    }
  }
  
}}
