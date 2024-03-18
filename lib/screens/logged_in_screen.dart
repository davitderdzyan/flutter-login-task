import 'package:flutter/material.dart';
import 'package:login_task/auth_provider.dart';
import 'package:login_task/screens/main_screen.dart';
import 'package:login_task/ui/custom_button.dart';
import 'package:provider/provider.dart';

class LoggedInScreen extends StatefulWidget {
  const LoggedInScreen({super.key});

  @override
  State<LoggedInScreen> createState() => _LoggedInScreenState();
}

class _LoggedInScreenState extends State<LoggedInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'You are logged in',
                style: TextStyle(fontSize: 20),
              ),
              CustomButton(
                  onPressed: () {
                    Provider.of<AuthProvider>(context, listen: false).signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()));
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: const Text('Log out'))
            ],
          ),
        ),
      ),
    );
  }
}
