import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_task/screens/main_screen.dart';
import 'package:provider/provider.dart';

import '../auth_provider.dart';
import 'logged_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => authProvider.status == AuthStatus.authenticated
              ? const LoggedInScreen()
              : const MainScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/logo_1.svg',
              ),
              const SizedBox(height: 17),
              SvgPicture.asset(
                'assets/images/logo_2.svg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
