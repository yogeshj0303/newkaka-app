import '../Constants/exports.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword,
    this.isEmail,
    this.isPhone,
    required this.iconData,
  });
  final TextEditingController controller;
  final IconData iconData;
  final String hintText;
  final bool? isPassword;
  final bool? isEmail;
  final bool? isPhone;
  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          keyboardType:
              isPhone ?? false ? TextInputType.number : TextInputType.name,
          obscureText: isPassword ?? false ? c.showPassword.value : false,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: isPassword ?? false
                ? Obx(
                    () => IconButton(
                      onPressed: () {
                        c.showPassword.value = !c.showPassword.value;
                        c.isPasswordVisible.value = !c.isPasswordVisible.value;
                      },
                      icon: c.showPassword.value
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                  )
                : null,
            hintText: hintText,
            hintStyle: smallLightText,
            fillColor: Colors.black12,
            filled: true,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Icon(iconData),
            ),
          ),
          validator: (value) {
            const pattern =
                r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
            final regExp = RegExp(pattern);
            if (isPassword ?? false) {
              if (value!.isEmpty) {
                return 'Enter password';
              } else if (value.length < 6) {
                return 'Enter atleast 6 letter password';
              }
            } else if (isEmail ?? false) {
              if (value!.isEmpty) {
                return 'Enter an E-mail';
              } else if (!regExp.hasMatch(value.trim())) {
                return 'Enter an valid E-mail address';
              }
            } else if (isPhone ?? false) {
              if (value!.isEmpty) {
                return 'Enter your Mobile number';
              } else if (value.length != 10) {
                return 'Enter an valid 10 digit Mobile number';
              }
            } else {
              if (value!.isEmpty) {
                return 'This is required';
              }
            }
            return null;
          },
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
