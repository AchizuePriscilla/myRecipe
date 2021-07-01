import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_recipe/routes/route_names.dart';
import 'package:my_recipe/screens/views/home_view_tab.dart';
import 'package:my_recipe/screens/views/home_view.dart';
import 'package:my_recipe/screens/views/login_view.dart';
import 'package:my_recipe/screens/views/profile_view.dart';
import 'package:my_recipe/screens/views/recipes_view.dart';
import 'package:my_recipe/screens/views/register_view.dart';
import 'package:my_recipe/screens/views/search_view.dart';
import 'package:my_recipe/screens/views/welcome_view.dart';

class RouteGenerator {
//Routes will be generated with this function
//Therefore all views will be registered here with appropriate page transition
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case RouteNames.splashScreen:
      //   return CupertinoPageRoute(builder: (context) => SplashScreen());
      //   break;
      case RouteNames.homeScreen:
        return CupertinoPageRoute(builder: (context) => HomeScreen());
        break;
      // case RouteNames.onboarding:
      //   return CupertinoPageRoute(builder: (context) => OnboardingView());
      //   break;
      case RouteNames.homeScreenTab:
        return CupertinoPageRoute(builder: (context) => HomeScreenTab());
        break;
      case RouteNames.loginScreen:
        return CupertinoPageRoute(builder: (context) => LoginScreen());
        break;
      case RouteNames.profileScreen:
        return CupertinoPageRoute(builder: (context) => ProfileScreen());
        break;
      case RouteNames.recipesScreen:
        return CupertinoPageRoute(builder: (context) => RecipesScreen());
        break;
      case RouteNames.searchScreen:
        return CupertinoPageRoute(builder: (context) => SearchScreen());
        break;
      case RouteNames.welcomeScreen:
        return CupertinoPageRoute(builder: (context) => WelcomeScreen());
        break;
      case RouteNames.registerScreen:
        return CupertinoPageRoute(builder: (context) => RegisterScreen());
        break;

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(
      builder: (context) => Scaffold(
          appBar: AppBar(
              title: Text(
            'Page not found',
            style: TextStyle(color: Colors.red),
          )),
          body: Center(
            child: Text(
              'Error! Page not found',
              style: TextStyle(color: Colors.red),
            ),
          )),
    );
  }
}
