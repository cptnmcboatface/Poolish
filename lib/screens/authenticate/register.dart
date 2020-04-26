import 'package:flutter/material.dart';
import 'package:poolish/services/auth.dart';
import 'package:poolish/shared/loading.dart';
import 'package:poolish/shared/constants.dart';
import 'package:poolish/shared/login_register_design.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';





class SignUp extends StatefulWidget {
  
  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  
  String password="";
  String email="";
  String error = "";
  bool loading  = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible= false;
  bool passwordVisible2= false;


  @override
  void initState() {
    passwordVisible = false;
    passwordVisible2=false;
  }
  Widget build(BuildContext context) {
    
    if (loading){

      return Loading(message: "Signing Up");
    }else{

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
                
//                validator: (val)=> val.isEmpty ? 'Enter a Valid Email':null,

                validator: (val) => !EmailValidator.Validate(val, true)
                    ? 'Please provide a valid email.'
                    : null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 15.0),
              TextFormField( 
                style: textInputStyle,
                obscureText: !passwordVisible,
                decoration: textInputDecoration.copyWith(

                  hintText: 'Password',
                  labelText: 'Password',

                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),


                  hintStyle: GoogleFonts.poppins(textStyle:hintStyle),
                  labelStyle: GoogleFonts.poppins(textStyle:TextStyle(color: Color.fromRGBO(200, 200, 200, 1.0))),
                  focusColor: mainThemeColor,
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: mainThemeColor,))
                  ),


            //  validator: (val)=> val.length < 8 ? 'Password must be at least 8 characters long':null,
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Password cannot be empty';
                  }
                  if (val.length <8){
                    return 'Password must be at least 8 characters long';
                  }
                  if (val.length >28)
                    {
                      return "Password cannot be longer than 28 characters";
                    }
                  return null;
                },
                onChanged: (val){
                  setState(() {
                    password = val;

                  });
                },
              ),
              SizedBox(height: 15.0),
              TextFormField(
                style: textInputStyle,
                obscureText: !passwordVisible2,
                decoration: textInputDecoration.copyWith(

                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        passwordVisible2
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          passwordVisible2 = !passwordVisible2;
                        });
                      },
                    ),
                    hintStyle: GoogleFonts.poppins(textStyle:hintStyle),
                    labelStyle: GoogleFonts.poppins(textStyle:TextStyle(color: Color.fromRGBO(200, 200, 200, 1.0))),
                    focusColor: mainThemeColor,
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: mainThemeColor,))
                ),


                //  validator: (val)=> val.length < 8 ? 'Password must be at least 8 characters long':null,
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Password cannot be empty';
                  }
                  if (val!=password)
                    {
                      return "Passwords don't match";
                    }
                  return null;
                },
                //obscureText: true,
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
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        loading = false; 
                        error="Invalid Credentials";
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
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(textStyle:TextStyle(color: Colors.white,fontSize: 20,),)
                        ),
                    ),
                  ),
                ),
              ),
              FlatButton(onPressed: (){
                widget.toggleView();
              }, child: Text(
                "Already a User? Sign in",
                style: GoogleFonts.poppins(textStyle:TextStyle(fontSize: 15)),
              )),
              Text(
                error,
                style: GoogleFonts.poppins(textStyle:TextStyle(color: Colors.red, fontSize: 14.0))
              )
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

  // Widget build(BuildContext context) {
  //   if(loading){
  //     print("HERE");
  //     return Loading();
  //   }else{
  //     return Container(
  //     child: Scaffold(
  //     backgroundColor: Colors.blue[50],
  //     appBar: AppBar(
  //       actions: <Widget>[FlatButton.icon(onPressed: (){
  //         widget.toggleView();
  //       }, 
  //       icon: Icon(Icons.person), 
  //       label: Text("Sign In")),],
  //       backgroundColor: Colors.blue[400],
  //       elevation: 0.0,
  //       title: Text('Register on Poolish'),
  //     ),
  //     body: Container(
  //       padding: EdgeInsets.symmetric(vertical:20.0, horizontal:50.0),
  //       child: Form(
  //         key: _formKey,
  //         child: Column(
  //           children: <Widget>[
  //             SizedBox(height:20.0),
  //             TextFormField(
  //               validator: (val)=> val.isEmpty ? 'Enter an email':null,
  //               onChanged: (val){
  //                 setState(() {
  //                   email = val;
  //                 });
  //               },
  //             ),
  //             SizedBox(height:20.0),
  //             TextFormField( 
  //               validator: (val)=> val.length < 6 ? 'Enter a Valid Password':null,
  //               obscureText: true,
  //               onChanged: (val){
  //                 setState(() {
                    
  //                   password = val;
  //                 });
  //               },
  //             ),
  //             SizedBox(height:20.0),
  //             RaisedButton(
  //               child: Text('Sign Up!'),
  //               color: Colors.white,
  //               onPressed: () async{
  //                 if(_formKey.currentState.validate()){
  //                   setState(() {
  //                     loading = true;
  //                   });
  //                   dynamic result = await _auth.registerWithEmailAndPassword(email, password);
  //                   if(result ==null){
  //                     setState(() {
  //                       loading = false;
  //                       error = "Invalid Credentials";
  //                     });
  //                   }else{

  //                   }
  //                 }
  //               }
  //             ),
  //             SizedBox(height: 12.0,),
  //             Text(
  //               error,
  //               style: TextStyle(color: Colors.red, fontSize: 14.0)
  //             )

  //           ],
  //         ),
  //         )
  //     ),
  //   )
  //   );
  
  //   }
  //   }

}















// import 'package:flutter/material.dart';
// import 'package:poolish/services/auth.dart';
// import 'package:poolish/shared/loading.dart';
// import 'package:poolish/shared/constants.dart';
// import 'package:poolish/shared/login_register_design.dart';
// import 'package:google_fonts/google_fonts.dart';









// class SignUp extends StatefulWidget {
  
//   final Function toggleView;
//   SignUp({this.toggleView});

//   @override
//   _SignUpState createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
  
//   String password="";
//   String email="";
//   String error = "";
//   bool loading  = false;
//   final AuthService _auth = AuthService();
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
    
//     if (loading){

//       return Loading(message: "Signing Up");
//     }else{

//       return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: SingleChildScrollView(
//         child: Column(
//         children: <Widget>[
//           new Stack(
//         children: [
//           CurvedShape(curveHeightCS:CURVE_HEIGHT),
//           Container(
//               margin: EdgeInsets.only(top: CURVE_HEIGHT - AVATAR_DIAMETER),
//               width: double.infinity,
//               height: AVATAR_DIAMETER,
//               padding: EdgeInsets.all(8),
//               child: Container(
//                 decoration: new BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: mainThemeColor,
//                 ),
//                 child: new Icon(
//                   Icons.person_outline,
//                   color: Colors.white,
//                   size: AVATAR_RADIUS,
//                 ),
//               )),
      
//       Container(
//         padding: EdgeInsets.fromLTRB(16, CURVE_HEIGHT, 16, 16),
//         margin: EdgeInsets.symmetric(vertical:5.0, horizontal:25.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,

//             children: <Widget>[  
//               SizedBox(height: 15.0),
//               TextFormField(  
//                 style: textInputStyle,
//                 decoration: textInputDecoration.copyWith(
//                   hintText: 'Enter E-Mail',
//                   labelText: 'E-Mail',
//                   hintStyle: GoogleFonts.poppins(textStyle:hintStyle),
//                   labelStyle: GoogleFonts.poppins(textStyle:TextStyle(color: Color.fromRGBO(200, 200, 200, 1.0))),
//                   focusColor: mainThemeColor,
//                   focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: mainThemeColor,))
//                   ),
                
//                 validator: (val)=> val.isEmpty ? 'Enter a Valid Email':null,
//                 onChanged: (val){
//                   setState(() {
//                     email = val;
//                   });
//                 },
//               ),
//               SizedBox(height: 15.0),
//               TextFormField( 
//                 style: textInputStyle,
//                 decoration: textInputDecoration.copyWith(

//                   hintText: 'Password',
//                   labelText: 'Password',
//                   hintStyle: GoogleFonts.poppins(textStyle:hintStyle),
//                   labelStyle: GoogleFonts.poppins(textStyle:TextStyle(color: Color.fromRGBO(200, 200, 200, 1.0))),
//                   focusColor: mainThemeColor,
//                   focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: mainThemeColor,))
//                   ),


//                 validator: (val)=> val.length < 6 ? 'Enter a Valid Password':null,
//                 obscureText: true,
//                 onChanged: (val){
//                   setState(() {
//                     password = val;
//                   });
//                 },
//               ),
//               SizedBox(height: 15.0),
              
//               Container(
//                 height: 50.0,
//                 child: FlatButton(
//                   onPressed: () async{
//                   if(_formKey.currentState.validate()){
//                     setState(() {
//                       loading = true;
//                     });
//                     dynamic result = await _auth.registerWithEmailAndPassword(email, password);
//                     if(result == null){
//                       setState(() {
//                         loading = false; 
//                         error="Invalid Credentials";
//                       });
//                     }
//                   }
//                 },
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//                   padding: EdgeInsets.all(0.0),
//                   child: Ink(
//                     decoration: BoxDecoration(
//                         gradient: LinearGradient(colors: [Color.fromRGBO(69, 211, 193,0.8), Color.fromRGBO(69, 211, 193,0.2)],
//                         ),
//                         borderRadius: BorderRadius.circular(10.0)
//                     ),
//                     child: Container(
//                       constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
//                       alignment: Alignment.center,
//                       child: Text(
//                         "Sign Up",
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.poppins(textStyle:TextStyle(color: Colors.white,fontSize: 20,),)
//                         ),
//                     ),
//                   ),
//                 ),
//               ),
//               FlatButton(onPressed: (){
//                 widget.toggleView();
//               }, child: Text(
//                 "Already a User? Sign in",
//                 style: GoogleFonts.poppins(textStyle:TextStyle(fontSize: 15)),
//               )),
//               Text(
//                 error,
//                 style: GoogleFonts.poppins(textStyle:TextStyle(color: Colors.red, fontSize: 14.0))
//               )
//             ],
//           ),
//           )
//       ),
//     // )
  
//         ],        
//       ),
    
//         ],
//       )
//      ,
//       )
//       );
//     //   // return RegistrationMainWidget();

  
//     }
//     }

//   // Widget build(BuildContext context) {
//   //   if(loading){
//   //     print("HERE");
//   //     return Loading();
//   //   }else{
//   //     return Container(
//   //     child: Scaffold(
//   //     backgroundColor: Colors.blue[50],
//   //     appBar: AppBar(
//   //       actions: <Widget>[FlatButton.icon(onPressed: (){
//   //         widget.toggleView();
//   //       }, 
//   //       icon: Icon(Icons.person), 
//   //       label: Text("Sign In")),],
//   //       backgroundColor: Colors.blue[400],
//   //       elevation: 0.0,
//   //       title: Text('Register on Poolish'),
//   //     ),
//   //     body: Container(
//   //       padding: EdgeInsets.symmetric(vertical:20.0, horizontal:50.0),
//   //       child: Form(
//   //         key: _formKey,
//   //         child: Column(
//   //           children: <Widget>[
//   //             SizedBox(height:20.0),
//   //             TextFormField(
//   //               validator: (val)=> val.isEmpty ? 'Enter an email':null,
//   //               onChanged: (val){
//   //                 setState(() {
//   //                   email = val;
//   //                 });
//   //               },
//   //             ),
//   //             SizedBox(height:20.0),
//   //             TextFormField( 
//   //               validator: (val)=> val.length < 6 ? 'Enter a Valid Password':null,
//   //               obscureText: true,
//   //               onChanged: (val){
//   //                 setState(() {
                    
//   //                   password = val;
//   //                 });
//   //               },
//   //             ),
//   //             SizedBox(height:20.0),
//   //             RaisedButton(
//   //               child: Text('Sign Up!'),
//   //               color: Colors.white,
//   //               onPressed: () async{
//   //                 if(_formKey.currentState.validate()){
//   //                   setState(() {
//   //                     loading = true;
//   //                   });
//   //                   dynamic result = await _auth.registerWithEmailAndPassword(email, password);
//   //                   if(result ==null){
//   //                     setState(() {
//   //                       loading = false;
//   //                       error = "Invalid Credentials";
//   //                     });
//   //                   }else{

//   //                   }
//   //                 }
//   //               }
//   //             ),
//   //             SizedBox(height: 12.0,),
//   //             Text(
//   //               error,
//   //               style: TextStyle(color: Colors.red, fontSize: 14.0)
//   //             )

//   //           ],
//   //         ),
//   //         )
//   //     ),
//   //   )
//   //   );
  
//   //   }
//   //   }

// }










