class ListTileModel {
  final String label;
  final String image;
  final void Function() onTap;

  ListTileModel(
      {required this.label, required this.image, required this.onTap});
}
