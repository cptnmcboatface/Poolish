import 'package:flutter/material.dart';
import 'package:poolish/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';
import 'package:poolish/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return home or authenticate
    final user = Provider.of<User>(context);

    if (user==null){
      return Authenticate();
    }else{
      return Home(uid:user.uid);
    }    
  }
}