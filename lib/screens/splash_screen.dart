import 'package:flutter/material.dart';
import 'package:ihe_mgbako_inverter/screens/welcome_screen.dart';
import 'package:ihe_mgbako_inverter/widgets/big_text_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: BigText(text: 'ihe Mgbako Inverter'),
      ),
    );
  }
}
