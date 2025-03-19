import 'package:kake_autoparts/Constants/exports.dart';
import 'package:kake_autoparts/Models/sub_cat_model.dart';

class AllTopSelling extends StatelessWidget {
  const AllTopSelling({super.key, required this.snapshot});
  final AsyncSnapshot<SubCategoryModel> snapshot;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text('Deal of the day'.tr),
      ),
      body: SafeArea(
          child: Scrollbar(
        thumbVisibility: true,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: ListView.builder(
            itemCount: snapshot.data!.data!.length,
            itemBuilder: (context, index) => buildProductCard(size, snapshot,
                index, snapshot.data!.data![index].subcategory!),
          ),
        ),
      )),
    );
  }
}
