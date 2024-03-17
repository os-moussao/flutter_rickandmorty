import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class OfflineMode extends StatelessWidget {
  const OfflineMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color(0xFFEE4400),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              'Please check your internet connection  '.text.size(15).make(),
              Transform.scale(
                scale: 0.6,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ],
          ).py(10),
        ),
        Lottie.asset('assets/animation/sad_morty.json').centered(),
      ],
    );
  }
}
