import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_court_app/auth/services/firebase_auth_service.dart';
import 'package:gap/gap.dart';

import '../pages/menu_page.dart';
import '../widget/widget_form.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _auth = FirebaseAuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool obscure = false;
  bool loadSign = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Stack(
            children: [
              loadSign
                  ? const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                        strokeCap: StrokeCap.round,
                        strokeWidth: 5,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Gap(10),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/navig-pana.png',
                            width: 200,
                            filterQuality: FilterQuality.low,
                          ),
                        ),
                        const Gap(5),
                        const Text(
                          "Let's! Enter to find out.",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            height: 1,
                          ),
                        ),
                        const Gap(30),
                        fieldFormEmail(
                          context,
                          'Enter email address',
                          emailController,
                          CupertinoIcons.mail,
                          TextInputType.emailAddress,
                        ),
                        const Gap(15),
                        fieldFormPassword(
                          () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          obscure,
                          context,
                          'Enter password',
                          passwordController,
                        ),
                        const Gap(30),
                        ElevatedButton(
                          onPressed: () {
                            if (emailController.text.isNotEmpty ||
                                passwordController.text.isNotEmpty) {
                              enterAuth();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  showCloseIcon: true,
                                  backgroundColor: Colors.redAccent,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  behavior: SnackBarBehavior.floating,
                                  content:
                                      const Text('Email and Password is empty'),
                                ),
                              );
                            }
                          },
                          style: ButtonStyle(
                            fixedSize: const MaterialStatePropertyAll(
                                Size.fromWidth(double.maxFinite)),
                            elevation: const MaterialStatePropertyAll(3),
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).primaryColor),
                            padding: const MaterialStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                          child: const Text(
                            'Enter',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Gap(20),
                        const Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                indent: 10,
                                color: Colors.grey,
                              ),
                            ),
                            Gap(10),
                            Text(
                              'or',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Gap(10),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                endIndent: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),
                        ElevatedButton.icon(
                          style: const ButtonStyle(
                            elevation: MaterialStatePropertyAll(2),
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(vertical: 20)),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white),
                            fixedSize: MaterialStatePropertyAll(
                              Size.fromWidth(double.maxFinite),
                            ),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                side: BorderSide(
                                  color: Colors.white54,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          onPressed: enterAuthGoogle,
                          icon: Image.asset(
                            'assets/images/google.png',
                            height: 25,
                          ),
                          label: const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Enter with Google Account',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void enterAuthGoogle() async {
    setState(() {
      loadSign = true;
    });
    final scaffoldM = ScaffoldMessenger.of(context);

    User? userSignGoogle = await _auth.signInWithGoogleAccount(context);

    setState(() {
      loadSign = false;
    });

    if (userSignGoogle != null) {
      scaffoldM.showSnackBar(
        SnackBar(
          showCloseIcon: true,
          backgroundColor: Colors.redAccent,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          behavior: SnackBarBehavior.floating,
          content: const Text('Some error happen'),
        ),
      );
    } else {
      scaffoldM.showSnackBar(
        SnackBar(
          showCloseIcon: true,
          backgroundColor: Colors.blueAccent,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          behavior: SnackBarBehavior.floating,
          content: const Text('Enter, Successfully using Google Account'),
        ),
      );
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MenuPage(),
      ),
    );
  }

  void enterAuth() async {
    setState(() {
      loadSign = true;
    });

    final scaffoldM = ScaffoldMessenger.of(context);

    String email = emailController.text;
    String password = passwordController.text;

    User? userSignUp =
        await _auth.signUpEmailAndPassword(context, email, password);
    User? userSignIn =
        await _auth.signInEmailAndPassword(context, email, password);

    setState(() {
      loadSign = false;
    });

    if (userSignUp != null || userSignIn == null) {
      scaffoldM.showSnackBar(
        SnackBar(
          showCloseIcon: true,
          backgroundColor: Colors.blueAccent,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          behavior: SnackBarBehavior.floating,
          content: const Text('Enter, Successfully is created'),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MenuPage(),
        ),
      );
    } else if (userSignIn != null || userSignUp == null) {
      scaffoldM.showSnackBar(
        SnackBar(
          showCloseIcon: true,
          backgroundColor: Colors.blueAccent,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          behavior: SnackBarBehavior.floating,
          content: const Text('Enter, Successfully'),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MenuPage(),
        ),
      );
    } else {
      scaffoldM.showSnackBar(
        SnackBar(
          showCloseIcon: true,
          backgroundColor: Colors.redAccent,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          behavior: SnackBarBehavior.floating,
          content: const Text('Some error happen'),
        ),
      );

      Navigator.pop(context);
    }
  }
}
