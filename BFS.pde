class BFS{
  Stack<Node> vertices = new Stack<Node>(); 
  public void findPath(Node[][] node){
    vertices.add(node[0][0]);
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
    if( n.x == size-1 && n.y == size-1 ) { exist = true; break; }  }
  } 
}
