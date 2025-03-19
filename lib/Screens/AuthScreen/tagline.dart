import 'package:kake_autoparts/Constants/exports.dart';

class Tagline extends StatelessWidget {
  const Tagline({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: largeColorText,
        children: [
          const TextSpan(text: 'मेरी अपनी '),
          TextSpan(
            text: 'Digital',
            style: xLargeColorText,
          ),
          const TextSpan(text: ' दुकान')
        ],
      ),
    );
  }
}
