import 'package:kake_autoparts/Constants/exports.dart';

class Terms extends StatelessWidget {
  Terms({super.key});
  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('T&C'),
        centerTitle: true,
        
        elevation: 1,
      ),
    );
  }
}
