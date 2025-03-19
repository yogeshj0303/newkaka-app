import 'package:kake_autoparts/Constants/exports.dart';
import 'package:kake_autoparts/Models/category_model.dart';
import 'package:kake_autoparts/Screens/Product/translate_helper.dart';

class ProductCategory extends StatelessWidget {
  const ProductCategory({
    super.key,
    required this.size,
    required this.image,
    required this.c,
    required this.catId,
  });
  final String catId;
  final Size size;
  final String image;
  final GetController c;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CategoryModel>(
        future: HomeUtils.getCategory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String desiredCategoryId = catId;
            List<Data> filteredCategories = snapshot.data!.data!
                .where(
                    (category) => category.id.toString() == desiredCategoryId)
                .toList();
            return SizedBox(
              height: size.height * 0.21,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Get.to(() => SubCategory(
                      image: image,
                      name: filteredCategories[index].name!,
                      subCatId: filteredCategories[index].id!.toInt())),
                  child: Container(
                    margin: const EdgeInsets.only(right: defaultPadding),
                    decoration: BoxDecoration(
                      border: Border.all(color: whiteColor),
                      borderRadius: borderRadius,
                    ),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              '$imgPath/${filteredCategories[index].image}',
                          fit: BoxFit.cover,
                          height: size.height * 0.16,
                          width: size.width * 0.3,
                        ),
                        SizedBox(height: size.height * 0.01),
                        c.lang.value == 'en'
                            ? Text(
                                snapshot.data!.data![index].name ?? '',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              )
                            : c.lang.value == 'hi'
                                ? TranslateHelper(
                                    data: filteredCategories[index].name ?? '',
                                    language: 'hi',
                                  )
                                : c.lang.value == 'mr'
                                    ? TranslateHelper(
                                        data: filteredCategories[index].name ??
                                            '',
                                        language: 'mr')
                                    : c.lang.value == 'gu'
                                        ? TranslateHelper(
                                            data: filteredCategories[index]
                                                    .name ??
                                                '',
                                            language: 'gu')
                                        : TranslateHelper(
                                            data: filteredCategories[index]
                                                    .name ??
                                                '',
                                            language: 'ta'),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return loading;
          }
        });
  }
}
