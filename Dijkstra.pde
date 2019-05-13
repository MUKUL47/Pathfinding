import java.util.*;

class Dijkstra{   
  public void solve(){    
    ArrayList<Node> nonDuplicates = new ArrayList<Node>();
    for( Node n : visitedNodes ){
      if( !nonDuplicates.contains(n) ){
        nonDuplicates.add(n);
      }
    }
    for( Node n : nonDuplicates ){
     // print(n.x+","+n.y+"=> ");
      for( Node nn : n.neighbour ){
        if( nn.path ) { 
        //print(nn.x+","+nn.y+"  "); 
      }
      }
      //println();
    }
    
    shortestPath(nonDuplicates);
    
    }
    
    public void shortestPath(ArrayList<Node> nonDuplicates){
    //ignore same node again
    ArrayList<Node> ignoreSameNode = new ArrayList<Node>();
    //Map heap
    HashMap<Node,Integer> mapHeap         = new HashMap<Node,Integer>();
    //Nearest dist
    ArrayList<HashMap<Node,Integer>> nearestDistance = new ArrayList<HashMap<Node,Integer>>();
    //parent
    ArrayList<HashMap<Node,Node>> paths      = new ArrayList<HashMap<Node,Node>>();
    Node currentNode = nonDuplicates.get(0);
    ignoreSameNode.add(currentNode);
    HashMap<Node,Integer> tempCurrent = new HashMap<Node,Integer>();    
    tempCurrent.put(currentNode,0);
    nearestDistance.add(tempCurrent);  
    
   while( !ifDestinationFound(mapHeap) ){         
    // print(currentNode.x+","+currentNode.y+"  ");println();
       for( Node i : currentNode.neighbour ){
         if( i.path && !isDuplicate(nearestDistance,i)){
             int existingWeight = getExistingWeight(nearestDistance,currentNode);
             if( Math.abs(i.x- currentNode.x) == 1 && Math.abs(i.y- currentNode.y) == 1){ 
               mapHeap.put(i,1+existingWeight);
               //print(i.x+","+i.y+"("+(1+existingWeight)+") ");
             }
             else {
               //print(i.x+","+i.y+"("+(2+existingWeight)+") ");
               mapHeap.put(i,1+existingWeight);
             }
           }
         }println();
         paths = updatePath(currentNode,mapHeap,paths);
          for( HashMap<Node,Node> n : paths ){ 
          for(Map.Entry<Node, Node> i : n.entrySet()) { 
            //println("->>"+i.getKey().x+","+i.getKey().y+" "+i.getValue().x+","+i.getValue().y);
          } 
        }
    HashMap<Node,Integer> getMinNeighbour = getMinNeighbour(mapHeap, ignoreSameNode);
    tempCurrent = new HashMap<Node,Integer>(); 
    currentNode = getKey(getMinNeighbour);
    tempCurrent.put(currentNode,getMinNeighbour.get(currentNode));
    ignoreSameNode.add(currentNode);
    nearestDistance.add(tempCurrent);        
   }for( HashMap<Node,Node> n : paths ){ 
          for(Map.Entry<Node, Node> i : n.entrySet()) { 
            println("->>"+i.getKey().x+","+i.getKey().y+" "+i.getValue().x+","+i.getValue().y);
          } 
        }
     backtrackFromDestinationToSource(paths);
  }  


public HashMap<Node,Integer> getMinNeighbour(HashMap<Node,Integer> heap, ArrayList<Node> ignoreSameNode){
      int min = Integer.MAX_VALUE;
      HashMap<Node,Integer> forNoReason = new HashMap<Node,Integer>();
      Node minNode = null;      
        for(Map.Entry<Node, Integer> i : heap.entrySet()) {
          boolean yesItIs = false;
          thisOne : for( Node j : ignoreSameNode ){ if( j.x == i.getKey().x && j.y == i.getKey().y ) { yesItIs = true; break thisOne; }}
          if( !yesItIs ){ 
          int v = i.getValue();
           if( v < min ){ 
             minNode = i.getKey();
             min = v;
           }
          }        
      }
      forNoReason.put(minNode,min);
       
      return forNoReason;
}
public boolean isDuplicate(ArrayList<HashMap<Node,Integer>> node, Node n){
  for( HashMap<Node,Integer> cNode : node ){ 
    for(Map.Entry<Node, Integer> i : cNode.entrySet()) { 
      if( i.getKey().x == n.x && i.getKey().y == n.y ) return true;
    }
  }
  return false;
}
public int getExistingWeight(ArrayList<HashMap<Node,Integer>> node, Node n){ 
  for( HashMap<Node,Integer> cNode : node ){ 
    for(Map.Entry<Node, Integer> i : cNode.entrySet()) { 
      if( i.getKey() == n ) return i.getValue();
    }
  }
  return 0;
}
public Node getKey(HashMap<Node,Integer> cNode){ 
    for(Map.Entry<Node, Integer> i : cNode.entrySet()) { 
      return i.getKey();
    }
    return null;
}

public boolean ifDestinationFound(HashMap<Node,Integer> heap){
 for(Map.Entry<Node, Integer> i : heap.entrySet()) { 
      if( i.getKey().x == size-1 && i.getKey().y == size-1 ) return true;
    } 
  return false;
}
public ArrayList<HashMap<Node,Node>> updatePath(Node currentNode, HashMap<Node,Integer> mapHeap, ArrayList<HashMap<Node,Node>> path){   
    ArrayList<HashMap<Node,Node>> newPath = path;
      for(Map.Entry<Node, Integer> i : mapHeap.entrySet()) {  
          HashMap<Node,Node> nodeNeighbour = new HashMap<Node,Node>();        
          nodeNeighbour.put(i.getKey(),currentNode);
          newPath.add(nodeNeighbour);        
      }     
    return newPath;
}

public void backtrackFromDestinationToSource(ArrayList<HashMap<Node,Node>> finalPath ){
  ArrayList<Node> path = new ArrayList<Node>();
  Node temp = null;
  HashMap<Node,Node> finalNodes = new HashMap<Node,Node>();
  ArrayList<HashMap<Node,Node>> f = new ArrayList<HashMap<Node,Node>>();
  for( HashMap<Node,Node> n : finalPath ){ 
    for(Map.Entry<Node, Node> i : n.entrySet()) { 
      if( i.getKey().x == size-1 && i.getKey().y == size-1 ){ temp = i.getValue();  }
      if( !(i.getKey().x == i.getValue().x && i.getKey().y == i.getValue().y) ) {   
      //println(i.getKey().x+""+i.getKey().y+"--"+i.getValue().x+""+i.getValue().y);
      finalNodes.put(i.getKey(),i.getValue());
      f.add(finalNodes);
      finalNodes = new HashMap<Node,Node>();
  }
    }
  }
  //while( !(temp.x == 0 && temp.y == 0) ){ 
  // for( HashMap<Node,Node> fN : f  ) {
  //  for(Map.Entry<Node, Node> i : fN.entrySet()) { 
  //    println(i.getKey().x+""+i.getKey().y+"--"+i.getValue().x+""+i.getValue().y);
  //    if( i.getKey().x == temp.x && i.getKey().y == temp.y ){         
  //     temp = i.getValue(); path.add(i.getKey());     
  //  }
  //  }}
    //if( temp.x == 0 && temp.y == 0) { break; } 


  
  
}}
