import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home/home_page.dart';
import 'package:flutter_firebase/screens/login/login_page.dart';
import 'package:flutter_firebase/services/user/user_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new HomePage(),
      '/login': (BuildContext context) => new LoginPage()
    },
      home: FutureBuilder<FirebaseUser>(
        future: UserController().getUserAuthenticated(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          //
          if (snapshot.connectionState == ConnectionState.done) {
            // log error to console
            if (snapshot.error != null) {
              return Text(snapshot.error.toString());
            }
            //UserController().saveUserData(snapshot.data);
            return snapshot.hasData ? HomePage() : LoginPage();
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}


