import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final String text;

  const CircularProgress(this.text);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center),
        const SizedBox(
          height: 15,
        ),
        const CircularProgressIndicator(
          key: Key("circularLoadProduct"),
          color: Colors.white,
        )
      ],
    ));
  }
}