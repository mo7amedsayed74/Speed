import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components.dart';

import '../constants.dart';

class VerifyWithMail extends StatelessWidget {
  const VerifyWithMail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.amber.withOpacity(0.7),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
          ),
          const SizedBox(
            width: 15,
          ),
          const Expanded(child: Text('VERIFY YOUR MAIL')),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
                showToast(
                  msg: 'check your mail',
                  state: ToastStates.success,
                );
              }).catchError((error) {});
            },
            child: Text(
              'VERIFY',
              style: TextStyle(
                color: defaultColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
