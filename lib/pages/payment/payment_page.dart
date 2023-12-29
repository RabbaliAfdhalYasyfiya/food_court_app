import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../menu_page.dart';
import 'qris/qris_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    //double sizeHeight = MediaQuery.of(context).size.height * 50;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white),
          ),
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => const MenuPage(),
              ),
            );
          },
        ),
        title: const Text(
          'Payment',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 2,
                    child: Card(
                      elevation: 2,
                      margin: const EdgeInsets.all(0),
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Positioned(
                              top: -200,
                              left: 0,
                              right: 10,
                              child: Container(
                                height: 300,
                                width: 300,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent.shade200
                                      .withOpacity(0.5),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -40,
                              right: -35,
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent.shade200,
                                ),
                              ),
                            ),
                            Positioned(
                              top: -20,
                              right: -15,
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent.shade100
                                      .withOpacity(0.25),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -60,
                              left: 75,
                              child: Container(
                                height: 100,
                                width: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent.shade100
                                      .withOpacity(0.5),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -75,
                              left: -15,
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent.shade200,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.account_balance_wallet,
                                            color: Colors.white,
                                          ),
                                          Gap(5),
                                          Text(
                                            'Balance',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Image.network(
                                          currentUser.photoURL == null
                                              ? 'https://i.pinimg.com/564x/2f/15/f2/2f15f2e8c688b3120d3d26467b06330c.jpg'
                                              : userData['image'],
                                          height: 37,
                                          width: 37,
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.low,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    'Rp 125.000,-',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  buttonPayMethod(
                    CupertinoIcons.rectangle_stack_badge_plus,
                    'Top Up',
                    () {},
                  ),
                  const Gap(10),
                  buttonPayMethod(
                    CupertinoIcons.qrcode,
                    'QRIS',
                    () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const QRISPage(),
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  const Divider(
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                    color: Colors.grey,
                  ),
                  const Gap(15),
                  const Text(
                    'Payment e-Wallet',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                      flex: 3,
                      child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const QRISPage(),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.grey.shade100),
                                padding: const MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15)),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Image.asset(
                                            'assets/images/logo/dana-blue.png'),
                                      ),
                                      const Gap(10),
                                      const Text(
                                        'DANA',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Text(
                                        ' - 0821 **** ****',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            );
                          })
                      // DottedBorder(
                      //   strokeWidth: 1,
                      //   color: Colors.grey,
                      //   strokeCap: StrokeCap.round,
                      //   dashPattern: const [10, 5],
                      //   borderType: BorderType.RRect,
                      //   radius: const Radius.circular(15),
                      //   padding: const EdgeInsets.all(5),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(10),
                      //     child: const Center(
                      //       child: Text(
                      //         'Tambahkan e-Wallet',
                      //         style: TextStyle(
                      //           color: Colors.grey,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      ),
                  const Gap(10),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showBottonSheet(context);
                    },
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStatePropertyAll(Colors.blueAccent.shade200),
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).primaryColor),
                      visualDensity: VisualDensity.standard,
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 20, vertical: 17)),
                      fixedSize: const MaterialStatePropertyAll(
                        Size.fromWidth(double.maxFinite),
                      ),
                    ),
                    icon: const Icon(
                      CupertinoIcons.add_circled,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Tambahkan e-Wallet Baru',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  final _value = '0';

  void _showBottonSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      scrollControlDisabledMaxHeightRatio: 1 / 1.25,
      useSafeArea: false,
      showDragHandle: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      constraints: const BoxConstraints(maxHeight: double.infinity),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Icon(
                      Icons.drag_handle_rounded,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Gap(20),
                  const Text(
                    'Masukkan Detail e-Wallet',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const Gap(10),
                  Divider(
                    thickness: 1,
                    color: Colors.grey.shade400,
                  ),
                  const Gap(10),
                  const Text(
                    'Pilih e-Wallet yang ingin ditambahkan dan masukkan informasi akun',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                  const Gap(15),
                  DropdownButtonFormField(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    decoration: const InputDecoration(
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    hint: const Text(
                      'Pilih e-Wallet',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    isExpanded: false,
                    isDense: true,
                    value: _value,
                    dropdownColor: Colors.white,
                    elevation: 2,
                    padding: const EdgeInsets.only(bottom: 20),
                    items: [
                      const DropdownMenuItem(
                        value: '0',
                        child: Text('- Pilih e-Wallet -'),
                      ),
                      dropMenuItem(
                        '1',
                        'assets/images/logo/dana-blue.png',
                        'DANA',
                        () {},
                      ),
                      dropMenuItem(
                        '2',
                        'assets/images/logo/gopay.png',
                        'GO-PAY',
                        () {},
                      ),
                      dropMenuItem(
                        '3',
                        'assets/images/logo/ovo.png',
                        'OVO',
                        () {},
                      ),
                      dropMenuItem(
                        '4',
                        'assets/images/logo/shopee-pay.png',
                        'ShopeePay',
                        () {},
                      ),
                    ],
                    onChanged: (dynamic) {},
                  ),
                  const Gap(20),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Tambahkan no. Handphone',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      showCloseIcon: true,
                      backgroundColor: Colors.blueAccent,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      behavior: SnackBarBehavior.floating,
                      content: const Text('e-Wallet berhasil di tambahkan'),
                    ),
                  );
                },
                style: ButtonStyle(
                  overlayColor:
                      MaterialStatePropertyAll(Colors.blueAccent.shade200),
                  visualDensity: VisualDensity.standard,
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15)),
                  backgroundColor:
                      MaterialStatePropertyAll(Theme.of(context).primaryColor),
                  fixedSize: const MaterialStatePropertyAll(
                    Size.fromWidth(double.maxFinite),
                  ),
                ),
                child: const Text(
                  'Tambahkan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  DropdownMenuItem<String> dropMenuItem(
    String value,
    String image,
    String label,
    Function() onTap,
  ) {
    return DropdownMenuItem(
      onTap: onTap,
      value: value,
      alignment: Alignment.center,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            child: Image.asset(
              image,
              filterQuality: FilterQuality.low,
              fit: BoxFit.fitWidth,
            ),
          ),
          const Gap(10),
          Text(label),
        ],
      ),
    );
  }

  Widget buttonPayMethod(
    final IconData icon,
    final String label,
    final Function() onTap,
  ) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.grey.shade100),
        padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(vertical: 15, horizontal: 15)),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Colors.black,
              ),
              const Gap(10),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.keyboard_arrow_right_rounded,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
