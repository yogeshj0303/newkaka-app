import 'package:kake_autoparts/Constants/exports.dart';
import 'package:kake_autoparts/Screens/AuthScreen/tagline.dart';
import 'package:kake_autoparts/Utils/auth_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      bool isLoggedIn = await SharedPrefs.autoLogin();
      if (isLoggedIn==true) {
        AuthUtils.authCheck(c.phone.value);
      } else {
        Get.offAll(() => const LoginScreen());
      }
    });
  }
  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.2),
          image: const DecorationImage(
            image: AssetImage(appLogo),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Spacer(flex: 3),
              const Tagline(),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(appLogo, height: 65),
                  const SizedBox(width: 15),
                  Text('Quality Products\nAffordable Prices',
                      style: mediumColorText),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
