import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeTabView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    controller.fetchUser();
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesan Dokter'),
        centerTitle: true,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: controller.onChangeTab,
          currentIndex: controller.currentIndex.value,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Beranda",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profil",
            ),
          ],
        ),
      ),
      body: Obx(
        () => controller.user.value == null
            ? Center(child: CircularProgressIndicator())
            : PageView(
                controller: controller.pageController,
                children: controller.tabs,
                physics: NeverScrollableScrollPhysics(),
              ),
      ),
    );
  }
}
