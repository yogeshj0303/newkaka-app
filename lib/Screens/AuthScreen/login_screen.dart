import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kake_autoparts/Screens/AuthScreen/tagline.dart';
import 'package:kake_autoparts/Screens/Orders/Home/home_screen.dart';
import 'package:kake_autoparts/Screens/Orders/Home/main_screen.dart';
import 'package:kake_autoparts/Utils/auth_utils.dart';
import '../../Constants/exports.dart';
import '../../Models/user_model.dart';
import '../../Widgets/termofuse.dart';
import 'admin_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //
  // Future<void> checkLoginStatus(String phoneNumber) async {
  //   var request = http.MultipartRequest('POST', Uri.parse('https://newkakaautoparts.com/api/send_otp'));
  //   request.fields.addAll({
  //     'phone': phoneNumber,  // Add the phone number from the TextField
  //   });
  //
  //   // Add other fields (user_id, service_id, etc.) as needed
  //   // ...
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     String responseBody = await response.stream.bytesToString();
  //
  //     try {
  //       final jsonData = jsonDecode(responseBody);
  //       UserModel userModel = UserModel.fromJson(jsonData);
  //
  //       // Check login status
  //       if (userModel.data != null && userModel.data!.loginStatus == 1) {
  //         Get.to(() => MainScreen());
  //       } else {
  //         Fluttertoast.showToast(msg: 'Incorrect phone number or not logged in.');
  //       }
  //
  //     } catch (e) {
  //       print('Error parsing response: $e');
  //     }
  //
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }
  final phoneController = TextEditingController();
  final c = Get.put(GetController());
  bool isAgree = false;

  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      if (phoneController.text.length == 10) {
        FocusScope.of(context).nextFocus();
      }
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    phoneController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.27,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(mediumappLogo),
                  ),
                ),
              ),
              const Tagline(),
              const SizedBox(height: 50),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(defaultRadius),
                        topRight: Radius.circular(defaultRadius)),
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(2, 2),
                        blurRadius: 6,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  child: Obx(
                    () => c.isAuthLoading.value
                        ? loading
                        : SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildDivider(),
                                buildLogin(),
                                buildOther(size),
                              ],
                            ),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: defaultPadding * 2),
      child: Text(
        'LOGIN OR SIGNUP',
        style: TextStyle(fontSize: 20, letterSpacing: 1.5),
      ),
    );
  }

  Widget buildLogin() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 2, vertical: defaultPadding / 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(flagIcon, height: 70, width: 60),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: phoneController,
                      isPhone: true,
                      hintText: 'Enter Mobile Number',
                      iconData: Icons.phone_android,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            tileColor: bgColor,
            title: const TermOfUse(),
            value: isAgree,
            onChanged: (val) => setState(() => isAgree = val!),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
                onPressed: () async {
                  if (phoneController.text.length == 10 && isAgree) {
                    // await checkLoginStatus(phoneController.text);
                    final mob = phoneController.text;
                    AuthUtils.getOtp(mob);
                  } else {
                    isAgree
                        ? Fluttertoast.showToast(
                        msg: 'Please enter 10 digit valid phone number')
                        : Fluttertoast.showToast(
                        msg:
                        'Please accept our Terms of service and Privacy Policy');
                  }
                }, child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Agree & Continue',
                                style: mediumWhiteText,
                              ),
                ),
            ),
          ),
          // myButton(
          //     onPressed: () async {
          //       if (phoneController.text.length == 10 && isAgree) {
          //         await checkLoginStatus(phoneController.text);
          //         final mob = phoneController.text;
          //         AuthUtils.getOtp(mob);
          //       } else {
          //         isAgree
          //             ? Fluttertoast.showToast(
          //                 msg: 'Please enter 10 digit valid phone number')
          //             : Fluttertoast.showToast(
          //                 msg:
          //                     'Please accept our Terms of service and Privacy Policy');
          //       }
          //     },
          //     label: 'Agree & Continue',
          //     color: primaryColor,
          //     style: mediumWhiteText),
        ],
      ),
    );
  }

  Widget buildOther(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 4, vertical: defaultPadding * 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyContainer(
            width: size.width,
            color: bgColor,
            child: Row(
              children: [
                IconButton(
                  splashColor: Colors.red,
                  icon:
                      Image.asset(spareParts, height: 35, color: primaryColor),
                  onPressed: () {},
                ),
                const Spacer(flex: 1),
                Text(
                  'Quality with affordable prices',
                  style: smallLightText,
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
          const SizedBox(height: 10),
          MyContainer(
            width: size.width,
            color: bgColor,
            child: Row(
              children: [
                IconButton(
                  icon: Image.asset(
                    headlight,
                    height: 35,
                    color: primaryColor,
                  ),
                  onPressed: () {},
                ),
                const Spacer(flex: 1),
                Text(
                  'Designed for your comfort ',
                  style: smallLightText,
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // InkWell(
          //   onTap: () {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return const AdminLogin();
          //       },
          //     );
          //   },
          //   child: Container(
          //     width: size.width,
          //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Add padding for better touch area
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(25.0), // Add rounded corners
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.grey.withOpacity(0.3), // Optional: Add a subtle shadow
          //           spreadRadius: 2,
          //           blurRadius: 5,
          //           offset: const Offset(0, 3),
          //         ),
          //       ],
          //     ),
          //     child: Row(
          //       children: [
          //         Image.asset(
          //           'assets/images/admin2.png',
          //           height: 26,
          //           width: 26,
          //           color: primaryColor,
          //         ),
          //         const Spacer(),
          //         Text(
          //           'Login using Admin Approval',
          //           style: smallLightText.copyWith(fontWeight: FontWeight.bold), // Make text bold
          //         ),
          //         const Spacer(), // Push the text to the left
          //       ],
          //     ),
          //   ),
          // ),
          // ElevatedButton(onPressed: (){
          //   showDialog(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return const AdminLogin();
          //     },
          //   );
          // }, child: Row(
          //   children: [
          //     Image.asset(
          //       'assets/images/admin2.png',
          //       height: 26,
          //       width: 26,
          //       color: primaryColor,
          //     ),
          //     const Spacer(),
          //     Text(
          //       'Login using Admin Approval',
          //       style: smallLightText.copyWith(fontWeight: FontWeight.bold),
          //     ),
          //     const Spacer(),
          //   ],
          // )),
        ],
      ),
    );
  }
}
