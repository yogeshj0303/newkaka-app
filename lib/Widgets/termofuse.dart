import 'package:flutter/gestures.dart';
import '../Constants/exports.dart';

class TermOfUse extends StatelessWidget {
  const TermOfUse({Key? key}) : super(key: key);

  final TextStyle defaultStyle =
      const TextStyle(color: grey, fontSize: smallTextsize);
  final TextStyle linkStyle = const TextStyle(
    color: secondaryColor,
    fontSize: smallTextsize,
  );

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          const TextSpan(text: 'I agree to the '),
          TextSpan(
            text: 'Terms & Conditions',
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchUrl(Uri.parse('https://newkakaautoparts.com/terms'));
              },
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchUrl(
                    Uri.parse('https://newkakaautoparts.com/privacy-policy'));
              },
          ),
        ],
      ),
    );
  }
}
