import 'package:kake_autoparts/Constants/exports.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({super.key});

  final c = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
        elevation: 1,
      ),
    );
  }
}
