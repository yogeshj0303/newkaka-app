import 'package:kake_autoparts/Models/category_model.dart';
import 'package:kake_autoparts/Screens/Product/translate_helper.dart';
import '../../Constants/exports.dart';

class AllCategory extends StatelessWidget {
  final AsyncSnapshot<CategoryModel> snapshot;
  AllCategory({super.key, required this.snapshot});
  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    var item = snapshot.data!.data!;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Category'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: item.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) => Column(
            children: [
              Ink(
                height: size.height * 0.1,
                child: InkWell(
                  onTap: () {
                    Get.to(
                      () => SubCategory(
                          image:
                              '$imgPath/${snapshot.data!.data![index].image}',
                          name: item[index].name!,
                          subCatId: item[index].id!.toInt()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(defaultCardRadius),
                      child: Container(
                        color: whiteColor,
                        width: size.width * 3,
                        child: CachedNetworkImage(
                          imageUrl:
                              '$imgPath/${snapshot.data!.data![index].image}',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(
                () => SizedBox(
                  width: size.width * 0.28,
                  height: 20,
                  child: c.lang.value == 'en'
                      ? Text(
                          snapshot.data!.data![index].name ?? '',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        )
                      : c.lang.value == 'hi'
                          ? TranslateHelper(
                              data: snapshot.data!.data![index].name ?? '',
                              language: 'hi',
                            )
                          : c.lang.value == 'mr'
                              ? TranslateHelper(
                                  data: snapshot.data!.data![index].name ?? '',
                                  language: 'mr')
                              : c.lang.value == 'gu'
                                  ? TranslateHelper(
                                      data: snapshot.data!.data![index].name ??
                                          '',
                                      language: 'gu')
                                  : TranslateHelper(
                                      data: snapshot.data!.data![index].name ??
                                          '',
                                      language: 'ta'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
