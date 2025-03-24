class OrbNode extends Orb {

  OrbNode next;
  OrbNode previous; 

  OrbNode() {
    next = previous = null;
  }//default constructor

  OrbNode(float x, float y, float s, float m) {
    super(x, y, s, m);
    next = previous = null;
  }//constructor

  void display() {
    super.display(); // draw "orb"
    if (next != null) {
      float dnext = this.center.dist(next.center);
      if (dnext < SPRING_LENGTH) { stroke(0, 255, 0); } // add green
      else if (dnext > SPRING_LENGTH) { stroke(255, 0, 0); } // add other color
      else { stroke(0); } // call black
      line(this.center.x, this.center.y, next.center.x, next.center.y); // call draw spring next 
    }
    if (previous != null) {
      float dprev = this.center.dist(previous.center);
      if (dprev < SPRING_LENGTH) { stroke(0, 255, 0); } // add green
      else if (dprev > SPRING_LENGTH) { stroke(255, 0, 0); } // add other color
      else { stroke(0); } // color black
      line(this.center.x, this.center.y, previous.center.x, previous.center.y); // draw to prev node
    }
  }//display

  void applySprings(int springLength, float springK) {
    if (next != null) {
      PVector sforce = getSpring(next, springLength, springK); // calculate the spring force
      applyForce(sforce); // apply force to current 
    }
    if (previous != null) {
      PVector sforce = getSpring(previous, springLength, springK); // calculate for prev nde
      applyForce(sforce); // apply force to current 
    }
  }//applySprings

}//OrbNode
