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
  new BFS().findPath(maze.getNodes());
}
void draw(){ //<>//
  if( exist ){ 
    for( Node n : visitedNodes ){
    maze.setPath(n.x,n.y,0,0,0);
    delay(2);
    if( n.x == size-1 && n.y == size-1 ) noLoop();    
  }  
  }else{ 
    delay(10);
    init();
    maze.converMazeToMap();
    new BFS().findPath(maze.getNodes());
  }
    
  
}
void init(){
  maze = new Maze(size,new Node[size][size]);
  maze.initMap(2);
  maze.setSrcDest(0,0,size-1,size-1);
}
