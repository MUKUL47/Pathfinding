class Node{
int x, y;
boolean path;
int R, G, B, fCost, gCost, hCost;
Node parent;
ArrayList<Node> neighbour;
  public Node(int x, int y){
    this.path     = false;
    this.x        = x;
    this.y        = y;
    this.neighbour= new ArrayList<Node>();
    this.R        = 0;
    this.G        = 255;
    this.B        = 255;
    this.hCost    = 0;
    this.gCost    = 0;
    this.fCost    = 0;
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
    public void setParent(Node parent){ 
      this.parent = parent;
    }
    public void setHcost(int hCost) {
        this.hCost = hCost;
    }

    public void setGcost(int gCost) {
        this.gCost = gCost;
    }   

    public int getFcost() {
        return fCost;
    }

    public int getHcost() {
        return hCost;
    }

    public int getGcost() {
        return gCost;
    }
    
    void setFCost(){
        this.fCost = this.gCost + this.hCost;
    }
    
}
