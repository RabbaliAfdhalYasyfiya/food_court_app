import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

class AddSecurityPIN extends StatefulWidget {
  const AddSecurityPIN({super.key});

  @override
  State<AddSecurityPIN> createState() => _AddSecurityPINState();
}

class _AddSecurityPINState extends State<AddSecurityPIN> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(10),
                    const Text(
                      'Enter to choose a 4-Digit Password',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(10),
                    const Text(
                      'This Password will be used as security measure to prevent unauthorized access',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Gap(30),
                    Center(
                      child: formField(),
                    ),
                  ],
                ),
              ),
              const Gap(30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        buttonNumber(
                          () {},
                          '1',
                        ),
                        buttonNumber(
                          () {},
                          '2',
                        ),
                        buttonNumber(
                          () {},
                          '3',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        buttonNumber(
                          () {},
                          '4',
                        ),
                        buttonNumber(
                          () {},
                          '5',
                        ),
                        buttonNumber(
                          () {},
                          '6',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        buttonNumber(
                          () {},
                          '7',
                        ),
                        buttonNumber(
                          () {},
                          '8',
                        ),
                        buttonNumber(
                          () {},
                          '9',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonNumber(
    Function() onTap,
    String number,
    //bool change,
  ) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(vertical: 20)),
          elevation: const MaterialStatePropertyAll(0),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget formField() {
    return Pinput(
      closeKeyboardWhenCompleted: true,
      useNativeKeyboard: true,
      crossAxisAlignment: CrossAxisAlignment.center,
      showCursor: false,
      length: 4,
      onChanged: (value) {},
      focusedPinTheme: PinTheme(
        height: 60,
        width: 55,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        textStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 3,
            style: BorderStyle.solid,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      followingPinTheme: PinTheme(
        height: 60,
        width: 55,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          border: Border.all(
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      keyboardType: TextInputType.number,
      defaultPinTheme: PinTheme(
        height: 60,
        width: 55,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        textStyle: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          color: Colors.white,
          border: Border.all(
            width: 1,
            style: BorderStyle.solid,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
