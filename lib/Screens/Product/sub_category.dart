import 'package:flutter/material.dart';
import 'package:kake_autoparts/Screens/Product/translate_helper.dart';
import 'package:kake_autoparts/Constants/exports.dart';
import 'package:kake_autoparts/Models/sub_cat_model.dart';

class SubCategory extends StatefulWidget {
  final String image;
  final String name;
  final int subCatId;
  SubCategory(
      {super.key,
      required this.image,
      required this.name,
      required this.subCatId
      }
      );

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  late Future<SubCategoryModel> subCategoryData;
  final c = Get.put(GetController());

  @override
  void initState() {
    super.initState();
    subCategoryData = HomeUtils.getSubCategory(widget.subCatId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: c.lang.value == 'en'
            ? Text(
                widget.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              )
            : c.lang.value == 'hi'
                ? TranslateHelper(
                    data: widget.name,
                    language: 'hi',
                  )
                : c.lang.value == 'mr'
                    ? TranslateHelper(data: widget.name, language: 'mr')
                    : c.lang.value == 'gu'
                        ? TranslateHelper(data: widget.name, language: 'gu')
                        : TranslateHelper(data: widget.name, language: 'ta'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              defaultPadding, defaultPadding, defaultPadding, 0),
          child: FutureBuilder<SubCategoryModel>(
            future: subCategoryData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error loading data: ${snapshot.error}',
                    style: largeText,
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
                return Center(
                  child: Text('No Products Found', style: largeText),
                );
              } else {
                return Scrollbar(
                  thumbVisibility: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) =>
                        buildProductCard(size, snapshot, index, widget.name),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget buildProductCard(Size size, AsyncSnapshot<SubCategoryModel> snapshot,
    int index, String subCatgName) {
  var item = snapshot.data!.data![index];
  final c = Get.put(GetController());
  return Padding(
    padding: const EdgeInsets.only(bottom: defaultPadding),
    child: GestureDetector(
      onTap: () => Get.to(
        () => SubCategoryDetails(
          snapshot: snapshot,
          ind: index,
          subCatgName: subCatgName,
        ),
      ),
      child: RoundedContainer(
        padding: const EdgeInsets.all(defaultPadding),
        height: size.height / 5,
        width: size.width,
        borderColor: Colors.black12,
        color: whiteColor,
        isImage: false,
        child: Row(
          children: [
            RoundedContainer(
              height: size.height / 6,
              width: size.width / 3,
              borderColor: Colors.black12,
              networkImg: '$imgPath/${item.image}',
              isImage: true,
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width / 2,
                  child: c.lang.value == 'en'
                      ? Text(
                          item.subcategory!,
                          overflow: TextOverflow.ellipsis,
                        )
                      : c.lang.value == 'hi'
                          ? TranslateHelper(
                              data: item.subcategory!,
                              language: 'hi',
                            )
                          : c.lang.value == 'mr'
                              ? TranslateHelper(
                                  data: item.subcategory!, language: 'mr')
                              : c.lang.value == 'gu'
                                  ? TranslateHelper(
                                      data: item.subcategory!, language: 'gu')
                                  : TranslateHelper(
                                      data: item.subcategory!, language: 'ta'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '₹${item.total}',
                      style: normalText,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '₹${item.price}',
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.black45),
                    ),
                    const SizedBox(width: 8),
                    Text('₹${item.discountedPrice} Off', style: smallColorText)
                  ],
                ),
                const SizedBox(height: 2),
                SizedBox(
                  width: size.width / 2 - 12,
                  child: c.lang.value == 'en'
                      ? Text(
                          item.description!,
                          overflow: TextOverflow.ellipsis,
                        )
                      : c.lang.value == 'hi'
                          ? TranslateHelper(
                              data: item.description!,
                              language: 'hi',
                            )
                          : c.lang.value == 'mr'
                              ? TranslateHelper(
                                  data: item.description!, language: 'mr')
                              : c.lang.value == 'gu'
                                  ? TranslateHelper(
                                      data: item.description!, language: 'gu')
                                  : TranslateHelper(
                                      data: item.description!, language: 'ta'),
                ),
                const SizedBox(height: 8),
                RoundedContainer(
                  height: 35,
                  width: size.width * 0.33,
                  isImage: false,
                  color: primaryColor,
                  onTap: () => ProductUtils.addToCart(item.id!.toInt()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_bag_outlined,
                          color: whiteColor),
                      const SizedBox(width: 8),
                      Text('Add To Cart'.tr, style: smallWhiteText),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
