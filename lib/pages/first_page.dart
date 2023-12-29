import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../auth/auth_page.dart';
import 'menu_page.dart';


class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _user != null ? const MenuPage() : const AuthPage();
  }
}
