import '../Constants/exports.dart';

Widget myButton({
  required void Function() onPressed,
  required String label,
  required Color color,
  required TextStyle style,
}) {
  return SizedBox(
    width: 200,
    height: 40,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: style,
      ),
    ),
  );
}
