
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kake_autoparts/Models/currentUser.dart';
import 'package:kake_autoparts/Utils/auth_utils.dart';
import 'package:kake_autoparts/Constants/exports.dart';
import 'package:get/get.dart';

import '../../Models/listtile_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final c = Get.put(GetController());

  @override
  void initState() {
    super.initState();
    fetchUserData(c); // Call fetchUserData here or wherever needed
  }

  Future<void> fetchUserData(GetController c) async {
    var headers = {
      'Authorization': 'Bearer sk-proj-lvOy2JU3EbHjOlkGjHMZT3BlbkFJbPIDfmDJQk89WcagsYgr'
    };
    var request = http.Request(
        'GET', Uri.parse('https://newkakaautoparts.com/api/get-current-user?phone_no=${c.phone.value}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonData = json.decode(responseBody);
      print('Response JSON: $jsonData'); // Print the JSON response for debugging

      currentUser user = currentUser.fromJson(jsonData);

      // Update GetController values
      c.name.value = user.data?.name ?? 'N/A';
      c.city.value = user.data?.city ?? 'N/A';
      c.phone.value = user.data?.phone ?? 'N/A';

      print('The Name is: ${c.name.value}, The City is: ${c.city.value}'); // Debug to check values

      setState(() {}); // Trigger a rebuild of the UI with updated values
    } else {
      print('Error fetching user data: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(
                defaultPadding, defaultPadding, defaultPadding, 0),
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              color: whiteColor,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.75],
                colors: [whiteColor, primaryColor],
              ),
            ),
            child: Column(
              children: [
                buildProfileCard(size, context),
                buildBottomCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileCard(Size size, BuildContext context) {
    return SizedBox(
      height: size.height * 0.21,
      width: size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 12),
          Image.asset(
            man,
            height: size.height * 0.175,
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                c.name.value,
                style: largeText,
                overflow: TextOverflow.ellipsis,
              ),
              Text(c.phone.value, style: normalLightText),
              Text(
                c.city.value,
                style: normalLightText,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBottomCard() {
    List<ListTileModel> myProfileList = [
      ListTileModel(
          label: 'Cart'.tr,
          image: cart,
          onTap: () =>
              Get.to(() => Cart(), transition: Transition.rightToLeftWithFade)),
      ListTileModel(
          label: 'Your Orders'.tr,
          image: orderIcon,
          onTap: () => Get.to(() => OrderScreen(),
              transition: Transition.rightToLeftWithFade)),
      ListTileModel(
          label: 'Wishlist'.tr,
          image: wishListIcon,
          onTap: () => Get.to(() => WishlistScreen(),
              transition: Transition.rightToLeftWithFade)),
      ListTileModel(
          label: 'Saved Addresses'.tr,
          image: address,
          onTap: () => Get.to(
                  () =>
              const SavedAddress(forOrder: false, forWhatsappOrder: false),
              transition: Transition.rightToLeftWithFade)),
      ListTileModel(
        label: 'Change Language'.tr,
        image: langIcon,
        onTap: () => Get.bottomSheet(
          SizedBox(
            height: 325,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Choose Language'.tr, style: normalText),
                ListTile(
                  title: Text('हिन्दी'),
                  onTap: () {
                    c.lang.value = 'hi';
                    SharedPrefs.loginSave(c.phone.value, 'hi');
                    Locale locale = Locale('hi', 'IN');
                    Get.updateLocale(locale);
                    Get.back();
                  },
                  trailing: c.lang.value == 'hi'
                      ? Icon(Icons.radio_button_checked, color: primaryColor)
                      : Icon(Icons.radio_button_unchecked),
                ),
                ListTile(
                  title: Text('English'),
                  onTap: () {
                    c.lang.value = 'en';
                    SharedPrefs.loginSave(c.phone.value, 'en');
                    Locale locale = Locale('en', 'US');
                    Get.updateLocale(locale);
                    Get.back();
                  },
                  trailing: c.lang.value == 'en'
                      ? Icon(Icons.radio_button_checked, color: primaryColor)
                      : Icon(Icons.radio_button_unchecked),
                ),
                ListTile(
                  title: Text('Marathi'),
                  onTap: () {
                    c.lang.value = 'mr';
                    SharedPrefs.loginSave(c.phone.value, 'mr');
                    Locale locale = Locale('mr', 'IN');
                    Get.updateLocale(locale);
                    Get.back();
                  },
                  trailing: c.lang.value == 'mr'
                      ? Icon(Icons.radio_button_checked, color: primaryColor)
                      : Icon(Icons.radio_button_unchecked),
                ),
                ListTile(
                  title: Text('Gujrati'),
                  onTap: () {
                    c.lang.value = 'gu';
                    SharedPrefs.loginSave(c.phone.value, 'gu');
                    Locale locale = Locale('gu', 'IN');
                    Get.updateLocale(locale);
                    Get.back();
                  },
                  trailing: c.lang.value == 'gu'
                      ? Icon(Icons.radio_button_checked, color: primaryColor)
                      : Icon(Icons.radio_button_unchecked),
                ),
                ListTile(
                  title: Text('Tamil'),
                  onTap: () {
                    c.lang.value = 'ta';
                    SharedPrefs.loginSave(c.phone.value, 'ta');
                    Locale locale = Locale('ta', 'IN');
                    Get.updateLocale(locale);
                    Get.back();
                  },
                  trailing: c.lang.value == 'ta'
                      ? Icon(Icons.radio_button_checked, color: primaryColor)
                      : Icon(Icons.radio_button_unchecked),
                ),
              ],
            ),
          ),
          backgroundColor: whiteColor,
        ),
      ),
      ListTileModel(
          label: 'Notification'.tr,
          image: notification,
          onTap: () => Get.to(() => NotificationScreen(),
              transition: Transition.rightToLeftWithFade)),
      ListTileModel(
        label: 'About us'.tr,
        image: group,
        onTap: () => launchUrl(Uri.parse('https://newkakaautoparts.com/')),
      ),
      ListTileModel(
        label: 'Privacy Policy'.tr,
        image: privacy,
        onTap: () =>
            launchUrl(Uri.parse('https://newkakaautoparts.com/privacy-policy')),
      ),
      ListTileModel(
        label: 'Terms and Conditions'.tr,
        image: privacy,
        onTap: () => launchUrl(Uri.parse('https://newkakaautoparts.com/terms')),
      ),
      ListTileModel(
        label: 'Logout'.tr,
        image: logout,
        onTap: () => Get.defaultDialog(
          title: 'Confirm Logout'.tr,
          middleText: 'Are you sure you want to logout?'.tr,
          confirmTextColor: whiteColor,
          confirm: ElevatedButton(
            onPressed: () => SharedPrefs.logout(),
            child: Text('Logout'.tr),
          ),
          cancel: ElevatedButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'.tr),
          ),
        ),
      ),
    ];
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(
            defaultPadding, defaultPadding, defaultPadding, 0),
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(appLogo), opacity: 0.1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(defaultCardRadius),
              topRight: Radius.circular(defaultCardRadius)),
          color: whiteColor,
        ),
        child: Column(
          children: [
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: myProfileList.length,
              itemBuilder: (context, index) => ListTile(
                dense: true,
                title: Text(myProfileList[index].label),
                leading: Image.asset(
                  myProfileList[index].image,
                  height: 20,
                  color: primaryColor,
                ),
                onTap: myProfileList[index].onTap,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () => launchUrl(Uri.parse('https://acttconnect.com/')),
              child: Text(
                'Powered by Act T Connect \n v^1.0.1',
                style: smallLightText,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}


// // ignore_for_file: prefer_const_constructors
//
// import 'package:kake_autoparts/Constants/exports.dart';
// import 'package:kake_autoparts/Models/listtile_model.dart';
// import 'package:kake_autoparts/Utils/auth_utils.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../../Models/currentUser.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final c = Get.put(GetController());
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserData(c); // Call fetchUserData here or wherever needed
//   }
//
//   Future<void> fetchUserData(GetController c) async {
//     var headers = {
//       'Authorization': 'Bearer sk-proj-lvOy2JU3EbHjOlkGjHMZT3BlbkFJbPIDfmDJQk89WcagsYgr'
//     };
//     var request = http.Request(
//         'GET', Uri.parse('https://newkakaautoparts.com/api/get-current-user?phone_no=${c.phone.value}'));
//
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       var responseBody = await response.stream.bytesToString();
//       var jsonData = json.decode(responseBody);
//       currentUser user = currentUser.fromJson(jsonData);
//
//       // Update GetController values
//       c.name.value = user.data?.name ?? 'N/A';
//       c.city.value = user.data?.city ?? 'N/A';
//       c.phone.value = user.data?.phone ?? 'N/A';
//
//       setState(() {}); // Trigger a rebuild of the UI with updated values
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Container(
//             padding: const EdgeInsets.fromLTRB(
//                 defaultPadding, defaultPadding, defaultPadding, 0),
//             height: size.height,
//             width: size.width,
//             decoration: const BoxDecoration(
//               color: whiteColor,
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 stops: [0.0, 0.75],
//                 colors: [whiteColor, primaryColor],
//               ),
//             ),
//             child: Column(
//               children: [
//                 buildProfileCard(size, context),
//                 buildBottomCard(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildProfileCard(Size size, BuildContext context) {
//     return SizedBox(
//       height: size.height * 0.21,
//       width: size.width,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(width: 12),
//           Image.asset(
//             man,
//             height: size.height * 0.175,
//           ),
//           const SizedBox(width: 12),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 child: Text(
//                   c.name.value,
//                   style: largeText,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               Text(c.phone.value, style: normalLightText),
//               Text(
//                 c.city.value,
//                 style: normalLightText,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildBottomCard() {
//     List<ListTileModel> myProfileList = [
//       ListTileModel(
//           label: 'Cart'.tr,
//           image: cart,
//           onTap: () =>
//               Get.to(() => Cart(), transition: Transition.rightToLeftWithFade)),
//       ListTileModel(
//           label: 'Your Orders'.tr,
//           image: orderIcon,
//           onTap: () => Get.to(() => OrderScreen(),
//               transition: Transition.rightToLeftWithFade)),
//       ListTileModel(
//           label: 'Wishlist'.tr,
//           image: wishListIcon,
//           onTap: () => Get.to(() => WishlistScreen(),
//               transition: Transition.rightToLeftWithFade)),
//       ListTileModel(
//           label: 'Saved Addresses'.tr,
//           image: address,
//           onTap: () => Get.to(
//               () =>
//                   const SavedAddress(forOrder: false, forWhatsappOrder: false),
//               transition: Transition.rightToLeftWithFade)),
//       ListTileModel(
//         label: 'Change Language'.tr,
//         image: langIcon,
//         onTap: () => Get.bottomSheet(
//           SizedBox(
//             height: 325,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Choose Language'.tr, style: normalText),
//                 ListTile(
//                   title: Text('हिन्दी'),
//                   onTap: () {
//                     c.lang.value = 'hi';
//                     SharedPrefs.loginSave(c.phone.value, 'hi');
//                     Locale locale = Locale('hi', 'IN');
//                     Get.updateLocale(locale);
//                     Get.back();
//                   },
//                   trailing: c.lang.value == 'hi'
//                       ? Icon(Icons.radio_button_checked, color: primaryColor)
//                       : Icon(Icons.radio_button_unchecked),
//                 ),
//                 ListTile(
//                   title: Text('English'),
//                   onTap: () {
//                     c.lang.value = 'en';
//                     SharedPrefs.loginSave(c.phone.value, 'en');
//                     Locale locale = Locale('en', 'US');
//                     Get.updateLocale(locale);
//                     Get.back();
//                   },
//                   trailing: c.lang.value == 'en'
//                       ? Icon(Icons.radio_button_checked, color: primaryColor)
//                       : Icon(Icons.radio_button_unchecked),
//                 ),
//                 ListTile(
//                   title: Text('Marathi'),
//                   onTap: () {
//                     c.lang.value = 'mr';
//                     SharedPrefs.loginSave(c.phone.value, 'mr');
//                     Locale locale = Locale('mr', 'IN');
//                     Get.updateLocale(locale);
//                     Get.back();
//                   },
//                   trailing: c.lang.value == 'mr'
//                       ? Icon(Icons.radio_button_checked, color: primaryColor)
//                       : Icon(Icons.radio_button_unchecked),
//                 ),
//                 ListTile(
//                   title: Text('Gujrati'),
//                   onTap: () {
//                     c.lang.value = 'gu';
//                     SharedPrefs.loginSave(c.phone.value, 'gu');
//                     Locale locale = Locale('gu', 'IN');
//                     Get.updateLocale(locale);
//                     Get.back();
//                   },
//                   trailing: c.lang.value == 'gu'
//                       ? Icon(Icons.radio_button_checked, color: primaryColor)
//                       : Icon(Icons.radio_button_unchecked),
//                 ),
//                 ListTile(
//                   title: Text('Tamil'),
//                   onTap: () {
//                     c.lang.value = 'ta';
//                     SharedPrefs.loginSave(c.phone.value, 'ta');
//                     Locale locale = Locale('ta', 'IN');
//                     Get.updateLocale(locale);
//                     Get.back();
//                   },
//                   trailing: c.lang.value == 'ta'
//                       ? Icon(Icons.radio_button_checked, color: primaryColor)
//                       : Icon(Icons.radio_button_unchecked),
//                 ),
//               ],
//             ),
//           ),
//           backgroundColor: whiteColor,
//         ),
//       ),
//       ListTileModel(
//           label: 'Notification'.tr,
//           image: notification,
//           onTap: () => Get.to(() => NotificationScreen(),
//               transition: Transition.rightToLeftWithFade)),
//       ListTileModel(
//         label: 'About us'.tr,
//         image: group,
//         onTap: () => launchUrl(Uri.parse('https://newkakaautoparts.com/')),
//       ),
//       ListTileModel(
//         label: 'Privacy Policy'.tr,
//         image: privacy,
//         onTap: () =>
//             launchUrl(Uri.parse('https://newkakaautoparts.com/privacy-policy')),
//       ),
//       ListTileModel(
//         label: 'Terms and Conditions'.tr,
//         image: privacy,
//         onTap: () => launchUrl(Uri.parse('https://newkakaautoparts.com/terms')),
//       ),
//       ListTileModel(
//         label: 'Logout'.tr,
//         image: logout,
//         onTap: () => Get.defaultDialog(
//           title: 'Confirm Logout'.tr,
//           middleText: 'Are you sure you want to logout?'.tr,
//           confirmTextColor: whiteColor,
//           confirm: ElevatedButton(
//             onPressed: () => SharedPrefs.logout(),
//             child: Text('Logout'.tr),
//           ),
//           cancel: ElevatedButton(
//             onPressed: () => Get.back(),
//             child: Text('Cancel'.tr),
//           ),
//         ),
//       ),
//     ];
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.fromLTRB(
//             defaultPadding, defaultPadding, defaultPadding, 0),
//         decoration: const BoxDecoration(
//           image: DecorationImage(image: AssetImage(appLogo), opacity: 0.1),
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(defaultCardRadius),
//               topRight: Radius.circular(defaultCardRadius)),
//           color: whiteColor,
//         ),
//         child: Column(
//           children: [
//             ListView.builder(
//               padding: EdgeInsets.zero,
//               shrinkWrap: true,
//               itemCount: myProfileList.length,
//               itemBuilder: (context, index) => ListTile(
//                 dense: true,
//                 title: Text(myProfileList[index].label),
//                 leading: Image.asset(
//                   myProfileList[index].image,
//                   height: 20,
//                   color: primaryColor,
//                 ),
//                 onTap: myProfileList[index].onTap,
//               ),
//             ),
//             const Spacer(),
//             InkWell(
//               onTap: () => launchUrl(Uri.parse('https://acttconnect.com/')),
//               child: Text(
//                 'Powered by Act T Connect \n v^1.0.1',
//                 style: smallLightText,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             const Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
// }
