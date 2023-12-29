import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:gap/gap.dart';

import '../auth/auth_page.dart';
import '../widget/button.dart';
import 'about_us/about_page.dart';
import 'location/location_page.dart';
import 'payment/payment_page.dart';
import 'profile/profile_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  bool loadSign = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Stack(
            children: [
              loadSign
                  ? const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                        strokeCap: StrokeCap.round,
                        strokeWidth: 10,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ClipRRect(
                          borderRadius: SmoothBorderRadius(
                            cornerRadius: 20,
                            cornerSmoothing: 100,
                          ),
                          child: SizedBox(
                            height: 125,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/menu/menu-foodcourt.jpg',
                                  filterQuality: FilterQuality.low,
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                                StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(currentUser.email)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final userData = snapshot.data!.data()
                                          as Map<String, dynamic>;
                                      return Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, top: 15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Selamat Datang,',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const Gap(5),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 0),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.35),
                                                  borderRadius:
                                                      const BorderRadius
                                                          .horizontal(
                                                    left: Radius.circular(5),
                                                    right: Radius.circular(15),
                                                  ),
                                                ),
                                                child: AnimatedTextKit(
                                                  displayFullTextOnTap: true,
                                                  repeatForever: true,
                                                  isRepeatingAnimation: true,
                                                  pause: const Duration(
                                                      milliseconds: 2500),
                                                  animatedTexts: [
                                                    TypewriterAnimatedText(
                                                      '${userData['username']}.',
                                                      speed: const Duration(
                                                          milliseconds: 250),
                                                      curve: Curves.decelerate,
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        decorationStyle:
                                                            TextDecorationStyle
                                                                .solid,
                                                        decorationColor:
                                                            Colors.white,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Gap(5),
                        Divider(
                          thickness: 1,
                          color: Colors.grey.shade400,
                          endIndent: 15,
                          indent: 15,
                        ),
                        const Gap(5),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: SmoothBorderRadius(
                              cornerRadius: 20,
                              cornerSmoothing: 100,
                            ),
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'assets/images/menu/menu-location.jpg',
                                    filterQuality: FilterQuality.low,
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                    width: double.infinity,
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 10,
                                    child: buildElevatedButton(
                                      context,
                                      () {
                                        debugPrint('Enter Location');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LocationPage(),
                                          ),
                                        );
                                      },
                                      'Location',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Gap(5),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: SmoothBorderRadius(
                              cornerRadius: 20,
                              cornerSmoothing: 100,
                            ),
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'assets/images/menu/menu-payment.jpg',
                                    filterQuality: FilterQuality.low,
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                    width: double.infinity,
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 10,
                                    child: buildElevatedButton(
                                      context,
                                      () {
                                        debugPrint('Enter Payment');

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const PaymentPage(),
                                          ),
                                        );
                                      },
                                      'Payment',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Gap(5),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: SmoothBorderRadius(
                                  cornerRadius: 20,
                                  cornerSmoothing: 100,
                                ),
                                child: SizedBox(
                                  height: 150,
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        'assets/images/menu/menu-about.jpg',
                                        filterQuality: FilterQuality.low,
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: buildElevatedButton(
                                          context,
                                          () {
                                            debugPrint('Enter About');
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const AboutPage(),
                                              ),
                                            );
                                          },
                                          'About',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Gap(5),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: SmoothBorderRadius(
                                  cornerRadius: 20,
                                  cornerSmoothing: 100,
                                ),
                                child: SizedBox(
                                  height: 150,
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        'assets/images/menu/menu-profile.jpg',
                                        filterQuality: FilterQuality.low,
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: buildElevatedButton(
                                          context,
                                          () {
                                            debugPrint('Enter Profile');

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ProfilePage(),
                                              ),
                                            );
                                          },
                                          'Profile',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(15),
                        buttonKeluar(
                          context,
                          customDialog,
                          'Keluar',
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void customDialog() {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          title: const Text(
            'Konfirmasi',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: const Text(
            'Apakah Anda yakin ingin keluar ?',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          actionsPadding: const EdgeInsets.only(right: 15, bottom: 10),
          actions: [
            TextButton(
              style: ButtonStyle(
                padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                ),
                backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).primaryColor,
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                textStyle: const MaterialStatePropertyAll(
                  TextStyle(fontSize: 15),
                ),
              ),
              onPressed: () {
                enterKeluar();
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthPage(),
                  ),
                );
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                ),
                backgroundColor: const MaterialStatePropertyAll(
                  Colors.white30,
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                side: const MaterialStatePropertyAll(
                  BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                textStyle: const MaterialStatePropertyAll(
                  TextStyle(fontSize: 15),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void enterKeluar() async {
    setState(() {
      loadSign = true;
    });
    final scaffoldM = ScaffoldMessenger.of(context);

    await FirebaseAuth.instance.signOut();

    setState(() {
      loadSign = false;
    });

    scaffoldM.showSnackBar(
      SnackBar(
        showCloseIcon: true,
        backgroundColor: Colors.blueAccent,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        behavior: SnackBarBehavior.floating,
        content: const Text('Successfully Keluar'),
      ),
    );
  }
}
