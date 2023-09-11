import 'package:flutter/material.dart';
import 'package:hng_stage_2/screens/edit/pages/edit_page.dart';
import 'package:hng_stage_2/screens/home/pages/home_page.dart';

class AppRouter {
  static _getPageRoute(
    Widget child, [
    String? routeName,
    dynamic args,
  ]) =>
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => child,
        settings: RouteSettings(
          name: routeName,
          arguments: args,
        ),
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 100),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(
            CurveTween(curve: curve),
          );
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return _getPageRoute(const HomePage());
      case EditPage.routeName:
        final data = settings.arguments as Map<String, dynamic>;
        return _getPageRoute(
          EditPage(
            fullName: data["full_name"],
            username: data["user_name"],
            image: data["image"],
            bio: data["bio"],
            email: data["email"],
            github: data["github"],
            address: data["address"],
            workExperiences: data["work_experiences"],
            education: data["education"],
            languages: data["languages"],
            skills: data["skills"],
            phone: data["phone"],
          ),
        );
      default:
        return _getPageRoute(const HomePage());
    }
  }
}
