import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Footer extends StatelessWidget {
  Footer({super.key});

  // on recupere la date pour le copyright
  final date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      color: HexColor("#2B353E"),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Terranimo',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(192, 69, 61, 1)),
                ),
                Text(
                  '.re',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Row(
            children: [
              Text(
                '© COPYRIGHT SDPMA - ${date.year}',
                style: const TextStyle(
                    color: Colors.white30,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
    );
  }
}
