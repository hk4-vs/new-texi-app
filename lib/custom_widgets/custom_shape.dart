import 'package:flutter/material.dart';

import 'my_clipper.dart';



class CustomShapeWidget extends StatelessWidget {
  const CustomShapeWidget({super.key, required this.child, this.height});
  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: MyClipper2(),
          child: Container(
            height: height ?? MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xffFF90BC),
          ),
        ),
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            height: height ?? MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      const Color(0xffFF90BC).withOpacity(0.8),
                      const Color(0xff83A2FF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.1, 0.5])),
            child: child,
          ),
        ),
      ],
    );
  }
}
