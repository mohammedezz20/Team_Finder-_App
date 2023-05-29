


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../shared/Network/remote/auth_method.dart';
import 'LoginScreen.dart';
import 'Layout/mainScreen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: Auth().authChanges,

        builder: ((context,snapshot)  {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child:  SpinKitSpinningLines(
                color: Colors.blue,
                size: 100,
                itemCount: 8,
                lineWidth: 3,
              ),
            );
          }
          if(snapshot.hasData) {
            return  const MianScreen();
          } else {
            return  const LoginScreen();
          }
        }),

      ),
    );
  }
}