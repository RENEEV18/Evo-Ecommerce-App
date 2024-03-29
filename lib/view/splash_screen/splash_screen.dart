import 'package:evo_mart/controller/providers/onboard_provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      ((timeStamp) {
        Provider.of<SplashProvider>(context, listen: false)
            .splashTimer(context);
      }),
    );
    return const Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Image(
          height: 50,
          image: AssetImage('assets/images/lOGO.png'),
        ),
      ),
    );
  }
}
