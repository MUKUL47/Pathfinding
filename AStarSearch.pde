/*
https://brilliant.org/wiki/a-star-search/

fCost = total estimated cost of path through node n (g+h)
gCost = cost so far to reach node n
hCost = estimated cost from n to goal. This is the heuristic part of the cost function, so it is like a guess. 

make an openlist containing only the starting node
   make an empty closed list
   while (the destination node has not been reached):
       consider the node with the lowest f score in the open list
       if (this node is our destination node) :
           we are finished 
       if not:
           put the current node in the closed list and look at all of its neighbors
           for (each neighbor of the current node):
               if (neighbor has lower g value than current and is in the closed list) :
                   replace the neighbor with the new, lower, g value 
                   current node is now the neighbor's parent            
               else if (current g value is lower and this neighbor is in the open list ) :
                   replace the neighbor with the new, lower, g value 
                   change the neighbor's parent to our current node

               else if this neighbor is not in both lists:
                   add it to the open list and set its g
*/
class AStarSearch{
  ArrayList<Node> openList   = new ArrayList<Node>();
  ArrayList<Node> closedList = new ArrayList<Node>();
  public void solve(ArrayList<Node> allPath){ 
    int min = Integer.MAX_VALUE;
    Node tempNode = null;
    ArrayList<Node> nonDuplicates = new ArrayList<Node>();
    for( Node n : visitedNodes ){
      if( !nonDuplicates.contains(n) ){
        nonDuplicates.add(n);
      }
    }
    openList.add(nonDuplicates.get(0));
    Node currentNode = null ;
    Node parent = null;   
    
   ////////////////////////////////////////////////////////////////////////////////////////////////////////
   while(true){
   for( Node openNode : openList ){ 
     updateGFHCost(openNode,size-1,size-1,0,0);
     if( openNode.getFcost() < min ) { 
          min = openNode.getFcost();
          currentNode = openNode;
        }     
   }
    min = Integer.MAX_VALUE;
    openList.remove(currentNode);
    closedList.add(currentNode);
    
    //checkIfTargetFound
    if( currentNode.x == size-1 && currentNode.y == size-1 ){ break;  }
    
   for( Node i : currentNode.neighbour ){   
      if( !closedList.contains(i) && i.path ){         
        updateGFHCost(i,size-1,size-1,0,0);        
        if( i.getFcost() < min ) { 
          min = i.getFcost();
          tempNode = i;
        }
      }      
    }
    if( tempNode != null ){ tempNode.setParent(currentNode); }
    if( !openList.contains(tempNode) ){ 
      openList.add(tempNode);
    } 
    tempNode = null;
    min = Integer.MAX_VALUE;
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
   }
   parent = currentNode;
   maze.setPath(parent.x,parent.y,255,255,255);
   while( true ){          
    parent = parent.parent;
    maze.setPath(parent.x,parent.y,255,255,255);
    if(parent.x == 0 && parent.y == 0) break;
   }
  }
  public void updateGFHCost( Node N, int dI, int dJ, int startI, int startJ){
       int sI = N.x, sJ = N.y, c = 0;
       while(true){
           if( sI == dI && sJ == dJ ) break;
           if( sI < dI && sJ < dJ ){ sI += 1; sJ += 1; c += 14; }
           if( sI > dI && sJ > dJ ){ sI -= 1; sJ -= 1; c += 14; }
           if( sI < dI && sJ > dJ ){ sI += 1; sJ -= 1; c += 14; }
           if( sI > dI && sJ < dJ ){ sI -= 1; sJ += 1; c += 14; }
           //
           if( sI == dI && sJ < dJ ){ sJ += 1; c += 10; }
           if( sI == dI && sJ > dJ ){ sJ -= 1; c += 10; }
           if( sI < dI && sJ == dJ ){ sI += 1; c += 10; }
           if( sI > dI && sJ == dJ ){ sI -= 1; c += 10; }        
       }
       int k = 0;
       sI = N.x; sJ = N.y;
       while(true){
           if( startI == sI && startJ == sJ ) break;
           if( startI < sI  && startJ < sJ ){ startI += 1; startJ += 1; k += 14; }
           if( startI > sI  && startJ > sJ ){ startI -= 1; startJ -= 1; k += 14; }
           if( startI < sI  && startJ > sJ ){ startI += 1; startJ -= 1; k += 14; }
           if( startI > sI  && startJ < sJ ){ startI -= 1; startJ += 1; k += 14; }
           //
           if( startI == sI && startJ < sJ ){ startJ += 1; k += 10; }
           if( startI == sI && startJ > sJ ){ startJ -= 1; k += 10; }
           if( startI < sI  && startJ == sJ ){ startI += 1; k += 10; }
           if( startI > sI  && startJ == sJ ){ startI -= 1; k += 10; }        
       }
       N.setGcost(k);
       N.setHcost(c);
       N.setFCost();
   }
   public boolean foundDestination(ArrayList<Node> n){ 
     for( Node i : n ){ 
       if( i.x == size-1 && i.y == size-1 ) return true;
     }
     return false;
   }
   public void showList(ArrayList<Node> n){ 
     for( Node i : n ){ 
       println(i.x+","+i.y+" parent "+i.x+","+i.y);
     }
   }
   public void showSingleNode(Node i){ println(i.x+","+i.y); }
}
