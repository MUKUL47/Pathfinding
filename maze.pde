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
