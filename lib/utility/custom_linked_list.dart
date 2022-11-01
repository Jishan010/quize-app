class CustomLinkedList<T> {
  CustomLinkedListNode<T>? _head;
  CustomLinkedListNode<T>? _tail;
  int _length = 0;

  CustomLinkedListNode<T>? get head => _head;

  CustomLinkedListNode<T>? get tail => _tail;

  int get length => _length;

  void add(T value) {
    final node = CustomLinkedListNode<T>(value);
    if (_head == null) {
      _head = node;
      _tail = node;
    } else {
      _tail?.next = node;
      node.previous = _tail;
      _tail = node;
    }
    _length++;
  }

  void remove(CustomLinkedListNode<T> node) {
    if (node == _head) {
      _head = _head?.next!;
      if (_head != null) {
        _head?.previous = null;
      }
    } else if (node == _tail) {
      _tail = _tail?.previous!;
      if (_tail != null) {
        _tail?.next = null;
      }
    } else {
      node.previous?.next = node.next;
      node.next?.previous = node.previous;
    }
    _length--;
  }
}

class CustomLinkedListNode<T> {
  CustomLinkedListNode<T>? next;
  CustomLinkedListNode<T>? previous;
  final T value;

  CustomLinkedListNode(this.value) {
    next = null;
    previous = null;
  }
}
