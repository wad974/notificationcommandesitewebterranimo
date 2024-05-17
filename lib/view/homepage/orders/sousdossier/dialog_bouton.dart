// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogBouton extends StatelessWidget {
  dynamic index;
  List<bool> btn;

  DialogBouton({super.key, required this.index, required this.btn});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.warning_outlined,
        size: 50,
        color: Colors.red,
      ),
      title: Text(
        btn[index] == false
            ? 'Voulez-vous confirmer ?'
            : 'Voulez-vous annuler ?',
        style: TextStyle(color: Colors.grey.shade900),
      ),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Colors.white,
      content: Container(
        height: 100,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context, 'annuler');
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 70,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context, 'sauvegarder');
                  },
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 70,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
