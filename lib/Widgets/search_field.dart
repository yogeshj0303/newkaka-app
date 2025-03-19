import '../Constants/exports.dart';

class CustomSearchField extends StatelessWidget {
  CustomSearchField({
    super.key,
    required this.controller,
    required this.hintText,
  });
  final TextEditingController controller;
  final String hintText;
  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultRadius)),
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }
}
