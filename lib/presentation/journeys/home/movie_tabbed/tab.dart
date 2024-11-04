class Tab {
  final int index;
  final String title;

  Tab({required this.index, required this.title})
      : assert(index >= 0, 'index must be greater than or equal to 0'),
        assert(title.isNotEmpty, 'title cannot be empty');
}
