import 'package:flutter/material.dart';
import 'package:reis_project/features/register/view/register_screen.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RegisterScreen()
  ));
}

/*
MainNavigationScreen(
  isClient: false,
  userType: UserType.collaborator,
)
*/