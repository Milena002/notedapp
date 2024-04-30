import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:notedapp/common/models/task.dart';
import 'package:notedapp/features/auth/pages/login_page.dart';
import 'package:notedapp/features/auth/pages/otp_page.dart';
import 'package:notedapp/features/onboarding/pages/onboarding.dart';
import 'package:notedapp/features/todo/pages/homepage.dart';
import 'package:notedapp/features/todo/pages/add.dart';
import 'package:notedapp/features/todo/pages/update.dart';

class Routes{
  static const String onboarding = 'onboarding';
  static const String login = 'login';
  static const String otp= 'otp';
  static const String home= 'home';
  static const String add = 'add';
  static const String update = 'update';

  static Route <dynamic> onGenerateRoute(RouteSettings settings){
    switch (settings.name) {
      case onboarding:
      return MaterialPageRoute(builder: (context)=> const OnBoarding());

      case login:
      return MaterialPageRoute(builder: (context)=> const LoginPage());

       case otp:
       final Map args = settings.arguments as Map;
      return MaterialPageRoute(builder: (context) =>  
      OtpPage(
        phone: args['phone'],
        smsCodeId: args['smsCodeId'],));

        case home:
      return MaterialPageRoute(builder: (context) => const HomePage());

      case add:
        return MaterialPageRoute(
          builder: (context) => const AddTask(),
        );
      case update:
        final Task data = settings.arguments as Task;
        return MaterialPageRoute(
          builder: (context) => Update(data: data,),
        );
       
      default:
      
      return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: Text('No Page Route Provided'),
              ),
            );
          },
        );
      
    }
    
  }

}