import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth.dart';
import 'screens/splash_screen.dart';
// import 'screens/home/test_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //HI THIS IS AMAL
  @override
  Widget build(BuildContext context) {
    // return Text("asd");

    return  StreamProvider.value(
      value: AuthService().user,
      child: MaterialApp(
              home:SplashScreen(),
            )
    );
    
  }
}
