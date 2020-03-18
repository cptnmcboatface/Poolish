import 'package:flutter/material.dart';
import 'package:poolish/services/auth.dart';
import 'package:poolish/shared/loading.dart';
import 'package:poolish/shared/constants.dart';
import 'package:poolish/shared/login_register_design.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  
  final Function toggleView;
  SignIn({this.toggleView});
  
  @override

  _SignInState createState() => _SignInState();
}


class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = "";
  String password = "";
  String error = "";
  @override

  Widget build(BuildContext context) {
    
    if (loading){

      return Loading(message: "Signing In");
    }else{
    //  return Text("asd");

      return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
        children: <Widget>[
          new Stack(
        children: [
          CurvedShape(curveHeightCS:CURVE_HEIGHT),
          Container(
              margin: EdgeInsets.only(top: CURVE_HEIGHT - AVATAR_DIAMETER),
              width: double.infinity,
              height: AVATAR_DIAMETER,
              padding: EdgeInsets.all(8),
              child: Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: mainThemeColor,
                ),
                child: new Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: AVATAR_RADIUS,
                ),
              )),
      
      Container(
        padding: EdgeInsets.fromLTRB(16, CURVE_HEIGHT, 16, 16),
        margin: EdgeInsets.symmetric(vertical:5.0, horizontal:25.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: <Widget>[  
              SizedBox(height: 15.0),
              TextFormField(  
                style: textInputStyle,
                decoration: textInputDecoration.copyWith(
                  hintText: 'Enter E-Mail',
                  labelText: 'E-Mail',
                  hintStyle: GoogleFonts.poppins(textStyle:hintStyle),
                  labelStyle: GoogleFonts.poppins(textStyle:TextStyle(color: Color.fromRGBO(200, 200, 200, 1.0))),
                  focusColor: mainThemeColor,
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: mainThemeColor,))
                  ),
                
                validator: (val)=> val.isEmpty ? 'Enter a Valid Email':null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 15.0),
              TextFormField( 
                style: textInputStyle,
                decoration: textInputDecoration.copyWith(

                  hintText: 'Password',
                  labelText: 'Password',
                  hintStyle: GoogleFonts.poppins(textStyle:hintStyle),
                  labelStyle: GoogleFonts.poppins(textStyle:TextStyle(color: Color.fromRGBO(200, 200, 200, 1.0))),
                  focusColor: mainThemeColor,
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: mainThemeColor,))
                  ),


                validator: (val)=> val.length < 6 ? 'Enter a Valid Password':null,
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 15.0),
              
              Container(
                height: 50.0,
                child: FlatButton(
                  onPressed: () async{
                  if(_formKey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        loading = false;
                      });
                    }
                  }
                  
                },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Color.fromRGBO(69, 211, 193,0.8), Color.fromRGBO(69, 211, 193,0.2)],
                        ),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Sign In",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(textStyle:TextStyle(color: Colors.white,fontSize: 20)),
                      ),
                    ),
                  ),
                ),
              ),
              FlatButton(onPressed: (){
                widget.toggleView();
              }, child: Text(
                "New User? Sign up",
                style: GoogleFonts.poppins(textStyle:TextStyle(fontSize: 15)),
              ))
            ],
          ),
          )
      ),
    // )
  
        ],        
      ),
    
        ],
      )
     ,
      )
      );
    //   // return RegistrationMainWidget();

  
    }
    }

}






//            Scaffold(
      // backgroundColor: Colors.blue[50],
      // appBar: AppBar(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //     bottom: Radius.circular(50),)
      //   ),
      //   actions: <Widget>[
      //     FlatButton.icon(onPressed: (){
      //       widget.toggleView();
      //     }, 
      //     icon: Icon(Icons.person), 
      //     label: Text("New User?"))
      //   ],
      //   elevation: 0.0,
      //   title: Text('Sign In to Poolish'),
      //    flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         begin: Alignment.bottomLeft,
      //           end: Alignment.bottomRight,
      //           colors: <Color>[
      //         Color.fromRGBO(69, 211, 193,1),
      //         Colors.white
      //       ])          
      //       ),        
      //     ),    

      // ),