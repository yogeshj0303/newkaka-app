import 'package:kake_autoparts/Utils/auth_utils.dart';
import '../../Constants/exports.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<UserData> {

  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final signupKey = GlobalKey<FormState>();
  final c = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: signupKey,
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Image.asset(
                loginbottom,
                color: primaryColor,
                height: 200,
              ),
              Container(
                padding: const EdgeInsets.all(defaultPadding * 2),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(mediumappLogo),
                    opacity: 0.2,
                  ),
                ),
                height: size.height,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(height: defaultPadding * 12),
                      Text(
                        "Let's Know you better",
                        style: xLargeText,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: defaultPadding * 5),
                      CustomTextField(
                          controller: nameController,
                          hintText: 'Your name',
                          iconData: Icons.person),
                      const SizedBox(height: defaultPadding),

                      CustomTextField(
                          controller: cityController,
                          hintText: 'Your city',
                          iconData: Icons.location_city),
                      const SizedBox(height: defaultPadding * 5),
                      ElevatedButton(
                        onPressed: () {
                          final isValid = signupKey.currentState!.validate();
                          if (isValid) {
                            print('This is user data ${c.name.value}, ${c.authPhone.value}, ${cityController.text}');
                            AuthUtils.getRegistered(
                                name: c.name.value,
                                phone: c.phone.value,
                                city: cityController.text
                            );
                          }
                        },
                        child: Text(
                          "Next".toUpperCase(),
                          style: mediumText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
