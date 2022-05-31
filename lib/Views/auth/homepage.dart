import 'package:flutter/material.dart';
import 'package:booking_doctor_mobile/components/reusable_primary_button.dart';
import 'package:booking_doctor_mobile/controllers/auth_controllers.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = AuthController();
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: ReusablePrimaryButton(
          buttonText: 'Logout',
          onTap: () {
            authController.logoutUser();
          },
        ),
      ),
    );
  }
}
