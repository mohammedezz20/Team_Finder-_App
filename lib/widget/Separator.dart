import 'package:flutter/material.dart';

class Custom_Dividor extends StatelessWidget {
  const Custom_Dividor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width/1.3,
      height: 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        gradient: const LinearGradient(
          colors: [
            Colors.black12,
            Colors.black26,
            Colors.black38,
            Colors.black45,
            Colors.black54,
            Colors.black87,
            Colors.black87,
            Colors.black54,
            Colors.black45,
            Colors.black38,
            Colors.black26,
            Colors.black12,
          ],

          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
    );
  }
}
