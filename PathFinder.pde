import java.util.*;
Maze maze;
final int size = 10;
ArrayList<Node> visitedNodes = new ArrayList<Node>();
boolean exist = false;

void setup(){
  size(500,500);
  init();
  //initButtons();
  maze.converMazeToMap();
  maze.renderMap(); 
  maze.converMazeToMap();
  new BFS().findPath(maze.getNodes());
}
void draw(){ //<>//
  if( exist ){ 
    delay(1000);
    for( Node n : visitedNodes ){
    //if( !(n.x == 0 && n.x == 0 || n.x == size-1 && n.y == size-1) ){ 
    maze.setPath(n.x,n.y,0,0,0);
    //}//dont change source/destination color
    if( n.x == size-1 && n.y == size-1 )  noLoop();
  }
  loop();
  new AStarSearch().solve(visitedNodes);
  noLoop();
  
  }else{ 
    init();
    maze.converMazeToMap();
    new BFS().findPath(maze.getNodes());
  }
    maze.renderMap();
  
}
void init(){
  maze = new Maze(size,new Node[size][size]);
  maze.initMap(1); //obstacleProbability more => Less obstacles
  Node[][] n = maze.getNodes();
  n[0][0].path           = true;
  n[size-1][size-1].path = true;
  maze.setPath(0,0,255,255,255);          //source
  maze.setPath(size-1,size-1,255,255,255);//destination
  visitedNodes = new ArrayList<Node>();
}
