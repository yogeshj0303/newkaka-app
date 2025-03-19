import 'package:kake_autoparts/Constants/exports.dart';
import 'package:translator/translator.dart';

class TranslateHelper extends StatelessWidget {
  final String data;
  final String language;
  const TranslateHelper(
      {super.key, required this.data, required this.language});

  @override
  Widget build(BuildContext context) {
    final translator = GoogleTranslator();
    translateToHindi(String data, String language) async {
      final result =
          await translator.translate(data, from: 'auto', to: language);
      return result.text;
    }

    return FutureBuilder<String>(
      future: translateToHindi(data, language),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
              baseColor: bgColor,
              highlightColor: whiteColor,
              child: Container(
                color: grey,
                height: 25,
                width: 100,
              ));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text(snapshot.data ?? "Translation not available",
              style: normalText);
        }
      },
    );
  }
}
