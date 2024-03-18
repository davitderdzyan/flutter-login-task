import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_button.dart';

class ContinueWithGoogle extends StatelessWidget {
  const ContinueWithGoogle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: CustomButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        textColor: Theme.of(context).primaryColor,
        borderColor: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/google.svg',
              height: 26,
              width: 26,
            ),
            const SizedBox(
              width: 10.5,
            ),
            const Text('Continue with Google'),
          ],
        ),
      ),
    );
  }
}
