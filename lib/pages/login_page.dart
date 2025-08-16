import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisebud/main.dart';
// import 'package:wisebud/pages/account_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _userId;
  GoogleSignInAccount? _user;

  Future<void> _signIn() async {
    try {
      // Check if platform supports authenticate
      if (GoogleSignIn.instance.supportsAuthenticate()) {
        await GoogleSignIn.instance.authenticate(scopeHint: ['email']);
      } else {
        // Handle web platform differently
        print('This platform requires platform-specific sign-in UI');
      }
    } catch (e) {
      print('Sign-in error: $e');
    }
  }

  Future<void> _initializeGoogleSignIn() async {
    // Initialize and listen to authentication events
    await GoogleSignIn.instance.initialize(serverClientId: '288108565666-ouit0sh6p4ccjra9lesjhcresjre07j9.apps.googleusercontent.com');
    GoogleSignIn.instance.authenticationEvents.listen((event) {
      setState(() {
        _user = switch (event) {
          GoogleSignInAuthenticationEventSignIn() => event.user,
          GoogleSignInAuthenticationEventSignOut() => null,
        };
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _initializeGoogleSignIn();

    supabase.auth.onAuthStateChange.listen((data) {
      setState(() {
        _userId = data.session?.user.id;
        print(data.session?.toJson());
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          const Text('Sign in with Google to continue.'),
          ElevatedButton(
            onPressed: _signIn,
            child: Text('Sign in with Google'),
          ),
          // SupaSocialsAuth(
          //   socialProviders: [OAuthProvider.apple, OAuthProvider.google],
          //   colored: true,
          //   redirectUrl: kIsWeb ? null : 'io.mydomain.myapp://callback',
          //   onSuccess: (Session response) {},
          //   onError: (error) {},
          // ),
        ],
      ),
    );
  }
}
