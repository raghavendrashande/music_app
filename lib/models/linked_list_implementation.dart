class Node {
  String songName;
  String artistName;
  String imageUrl;
  String songId;
  Node? next;
  Node? prev;

  Node(this.songName, this.artistName, this.imageUrl, this.songId, {this.next, this.prev});
}

class DoublyLinkedList {
  Node? head;
  Node? tail;
  Node? currentNode;

  // Method to add a new node to the end of the list
  void addNode(String songName, String artistName, String imageUrl, String songId) {
    Node newNode = Node(songName, artistName, imageUrl, songId);

    if (tail == null) {
      // If the list is empty, set the new node as both head and tail
      head = newNode;
      tail = newNode;
    } else {
      // Otherwise, add the new node to the end and update pointers
      tail!.next = newNode;
      newNode.prev = tail;
      tail = newNode;
    }
  }

  // Method to display the elements of the list


  // Method to move to the next node
  void goToNextNode() {
    if (head == null) {
      print("List is empty");
      return;
    }

    if (currentNode == null || currentNode!.next == null) {
      print("Already at the end of the list");
      return;
    }

    currentNode = currentNode!.next;
    print("Moved to the next node - Song: ${currentNode!.songName}, Artist: ${currentNode!.artistName}");
  }

  // Method to move to the previous node
  void goToPrevNode() {
    if (head == null) {
      print("List is empty");
      return;
    }

    if (currentNode == null || currentNode!.prev == null) {
      print("Already at the beginning of the list");
      return;
    }

    currentNode = currentNode!.prev;
    print("Moved to the previous node - Song: ${currentNode!.songName}, Artist: ${currentNode!.artistName}");
  }

  // Method to delete a node
  void deleteNode(Node nodeToDelete) {
    if (head == null) {
      print("List is empty");
      return;
    }

    if (nodeToDelete.prev != null) {
      // Update the next pointer of the previous node
      nodeToDelete.prev!.next = nodeToDelete.next;
    } else {
      // If the node to delete is the head, update the head
      head = nodeToDelete.next;
    }

    if (nodeToDelete.next != null) {
      // Update the previous pointer of the next node
      nodeToDelete.next!.prev = nodeToDelete.prev;
    } else {
      // If the node to delete is the tail, update the tail
      tail = nodeToDelete.prev;
    }

  }
}
