import 'package:flutter/material.dart';

class AuthMessageDisplay extends StatelessWidget {
  final String message;

  const AuthMessageDisplay({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * .3,
      child: Text(
        message,
        style: TextStyle(fontSize: 35),
      ),
    );
  }
}
