import 'package:flutter/material.dart';
import 'package:mobile_project/body_containers/tasks.dart';
import 'home_page.dart';
import 'login_screen.dart';
import '/./body_containers/members.dart';
import '../performance_utils/Performance.dart';
import '/./utils/user_preferences.dart';

const user = UserPreferences.myUser;

void main() {
  runApp(MaterialApp(initialRoute: '/login_screen', routes: {
    '/home_page': (context) => const HomePage(),
    '/login_screen': (context) => const LoginScreen(),
    '/performance': (context) => const PerPage(),
    '/tasks': (context) => Tasks(tasksInfo: user.tasksInfo),
    'members': (context) => Members(
          membersList: user.membersList,
          memberImageURL: user.imagePath,
        )
  }));
}
