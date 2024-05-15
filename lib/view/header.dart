import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String loginName;
  Header({super.key, required this.loginName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: const Color.fromRGBO(192, 69, 61, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.person,
            color: Colors.white,
          ),
          const SizedBox(width: 15),
          Text(
            'Bonjour  $loginName',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white70),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
