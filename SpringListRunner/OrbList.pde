/*========================== 
  
  OrbList (ALL WORK GOES HERE)

  Class to represent a Linked List of OrbNodes.

  Instance Variables:
    OrbNode front:
      The first element of the list.
      Initially, this will be null.

  Methods to work on:
    0. addFront
    1. populate
    2. display
    3. applySprings
    4. applyGravity
    5. run
    6. removeFront
    7. getSelected
    8. removeNode

  When working on these methods, make sure to
  account for null values appropriately. When the program
  is run, no NullPointerExceptions should occur.
  =========================*/

class OrbList {

  OrbNode front;

  /*===========================
    Constructor
    Initializes the list as empty.
    You do not need to modify this method.
    =========================*/
  OrbList() {
    front = null; // Set front to null initially
  }

  /*===========================
    addFront(OrbNode o)

    Insert o at the start of the list.
    =========================*/
  void addFront(OrbNode o) {
    if (o != null) {
      o.next = front; // Point new node to the current front
      front = o;      // Update front to new node
    }
  }

  /*===========================
    populate(int n, boolean ordered)

    Clears the list.
    Adds n randomly generated orbs to the list,
    using addFront.
    If ordered is true, the orbs should all
    have the same y coordinate and be spaced
    SPRING_LENGTH apart horizontally.
    =========================*/
  void populate(int n, boolean ordered) {
    front = null;

    for (int i = 0; i < n; i++) { // Loop to create and insert nodes
      OrbNode newNode;

      if (ordered) {
        float x = (width / 2) - (n * SPRING_LENGTH / 2) + i * SPRING_LENGTH; // Set X position
        float y = height / 2; // Set Y position
        newNode = new OrbNode(x, y, random(MIN_SIZE, MAX_SIZE), random(MIN_MASS, MAX_MASS));
      } else {
        newNode = new OrbNode(); // Generate node with random values
      }

      addFront(newNode); // Add node to front
    }
  }

  /*===========================
    display()

    Display all nodes using their display method.
    =========================*/
  void display() {
    OrbNode current = front; // Start from front
    while (current != null) { // Traverse through the list
      current.display(); // Display the current node
      current = current.next; // Move to next node
    }
  }

  /*===========================
    applySprings(int springLength, float springK)

    Use the applySprings method in OrbNode on each
    element in the list.
    =========================*/
  void applySprings(int springLength, float springK) {
    OrbNode current = front;
    while (current != null) {
      current.applySprings(springLength, springK); // Apply spring effect
      current = current.next;
    }
  }

  /*===========================
    applyGravity(Orb other, float gConstant)

    Use getGravity and applyForce methods to apply gravity correctly.
    =========================*/
  void applyGravity(Orb other, float gConstant) {
    OrbNode current = front;
    while (current != null) {
      PVector gravityForce = current.getGravity(other, gConstant); // Get gravity force
      current.applyForce(gravityForce); // Apply force to node
      current = current.next;
    }
  }

  /*===========================
    run(boolean bounce)

    Calls run on each node in the list.
    =========================*/
  void run(boolean bounce) {
    OrbNode current = front;
    while (current != null) {
      current.move(bounce); // Move the node
      current = current.next;
    }
  }

  /*===========================
    removeFront()

    Removes the front node from the list.
    =========================*/
  void removeFront() {
    if (front != null) {
      front = front.next; // Set front to next node
    }
  }

  /*===========================
    getSelected(float x, float y)

    Returns a reference to the node at (x, y), or null if none exists.
    =========================*/
  OrbNode getSelected(int x, int y) {
    OrbNode current = front;
    while (current != null) {
      if (current.isSelected(x, y)) {
        return current;
      }
      current = current.next;
    }
    return null; // No node found at given coordinates
  }

  /*===========================
    removeNode(OrbNode o)

    Removes the specified node from the list.
    Assumes o is an OrbNode within the list.
    =========================*/
  void removeNode(OrbNode o) {
    if (o == null || front == null) {
      return; // Do nothing if node is null or list is empty
    }

    if (front == o) {
      front = front.next; // If node is at front, update front
      return;
    }

    OrbNode current = front;
    while (current != null && current.next != o) {
      current = current.next;
    }

    if (current != null) {
      current.next = o.next; // Remove node by updating next reference
    }
  }
}
