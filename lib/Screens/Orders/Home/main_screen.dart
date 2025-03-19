// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:ui';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:kake_autoparts/Constants/exports.dart';
import 'package:kake_autoparts/Screens/Orders/Home/home_screen.dart';

import '../../../Controllers/get_controller.dart';
import '../../Constants/exports.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final int selectedIndex = 0;
  final controller = Get.put(GetController());

  @override
  void setState(VoidCallback fn) {
    if(mounted){
      super.setState(fn);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currIndex.value,
          children: [
            HomeScreen(),
            OrderScreen(),
            WishlistScreen(),
            NotificationScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          elevation: 1,
          currentIndex: controller.currIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: smallColorText,
          onTap: (index) => controller.currIndex.value = index,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                homeIcon,
                height: 25,
                color: controller.currIndex.value == 0 ? primaryColor : grey,
              ),
              label: 'Home'.tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                orderIcon,
                height: 25,
                color: controller.currIndex.value == 1 ? primaryColor : grey,
              ),
              label: 'Orders'.tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                wishListIcon,
                height: 25,
                color: controller.currIndex.value == 2 ? primaryColor : grey,
              ),
              label: 'Wishlist'.tr,
            ),
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none, // Allow the badge to extend beyond the icon's bounds
                children: [
                  Image.asset(
                    notification,
                    height: 25,
                    color: controller.currIndex.value == 3 ? primaryColor : grey,
                  ),
                  if (controller.notificationCount > 0)
                    Positioned(
                      top: -8,
                      right: -8,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          controller.notificationCount.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10, // Adjust font size as needed
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              label: 'Notification'.tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                profileIcon,
                height: 25,
                color: controller.currIndex.value == 4 ? primaryColor : grey,
              ),
              label: 'Profile'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
