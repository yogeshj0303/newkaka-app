import 'package:kake_autoparts/Screens/Product/product_video.dart';
import 'package:kake_autoparts/Screens/Product/translate_helper.dart';
import '../../../Constants/exports.dart';
import '../../Models/sub_cat_model.dart';

class SubCatDetails extends StatelessWidget {
  final AsyncSnapshot<SubCategoryModel> snapshot;
  final int ind;
  final String subCatgName;
  const SubCatDetails(
      {super.key,
      required this.snapshot,
      required this.ind,
      required this.subCatgName});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(GetController());
    final count = snapshot.data!.data!.length;
    final size = MediaQuery.of(context).size;
    final item = snapshot.data!.data![ind];
    final image = item.image!;
    final videoUrl = item.video ?? '';
    List<String> allImages = [];
    if (item.otherImages != null) {
      allImages = item.otherImages!.split(',');
      allImages.add(image);
    } else {
      allImages = [image];
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: c.lang.value == 'en'
            ? Text(
                subCatgName,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              )
            : c.lang.value == 'hi'
                ? TranslateHelper(
                    data: subCatgName,
                    language: 'hi',
                  )
                : c.lang.value == 'mr'
                    ? TranslateHelper(data: subCatgName, language: 'mr')
                    : c.lang.value == 'gu'
                        ? TranslateHelper(data: subCatgName, language: 'gu')
                        : TranslateHelper(data: subCatgName, language: 'ta'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              CarouselSlider.builder(
                itemCount: count,
                itemBuilder: (context, index, realIndex) => Container(
                    width: double.maxFinite,
                    color: whiteColor,
                    child: CachedNetworkImage(imageUrl: '$imgPath/$image')),
                options: CarouselOptions(
                  height: 280,
                  autoPlay: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    c.lang.value == 'en'
                        ? Text(
                            item.subcategory!,
                            textAlign: TextAlign.center,
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
                                        data: item.subcategory!,
                                        language: 'ta'),
                    Row(
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
                        Text('₹${item.discountedPrice} Off',
                            style: smallColorText)
                      ],
                    ),
                    const SizedBox(height: defaultMargin),
                    videoUrl != ''
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Product Video Available'.tr,
                                  style: normalText),
                              TextButton.icon(
                                onPressed: () => Get.to(
                                    () => ProductVideo(videoUrl: videoUrl)),
                                icon: const Icon(Icons.play_circle,
                                    color: primaryColor),
                                label: Text('Play Video'.tr),
                              )
                            ],
                          )
                        : Container(),
                    const SizedBox(height: defaultMargin),
                    Text(
                      'Description : '.tr,
                      style: normalText,
                    ),
                    const SizedBox(height: defaultMargin),
                    Text(item.description!, style: smallLightText),
                    const SizedBox(height: defaultMargin),
                    Text(
                      'You may also like :'.tr,
                      style: normalText,
                    ),
                    const SizedBox(height: defaultMargin),
                    SizedBox(
                      height: size.height / 3.75,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: count,
                        itemBuilder: (context, index) => index == ind
                            ? Container()
                            : buildMayLikeCard(size, snapshot, index),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
      bottomSheet: BottomCard(item: item, snp: snapshot, ind: ind),
    );
  }

  Widget buildMayLikeCard(
      Size size, AsyncSnapshot<SubCategoryModel> snapshot, int index) {
    final item = snapshot.data!.data![index];
    final image = item.image!;
    return InkWell(
      onTap: () => Get.off(() => SubCategoryDetails(
            snapshot: snapshot,
            ind: index,
            subCatgName: subCatgName,
          )),
      child: Padding(
        padding: const EdgeInsets.only(right: defaultPadding * 2),
        child: RoundedContainer(
          height: size.height / 2,
          width: size.width / 2 - (defaultPadding * 4),
          padding: const EdgeInsets.all(defaultPadding),
          isImage: false,
          borderColor: Colors.black12,
          color: whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              CircleAvatar(
                radius: 50,
                backgroundColor: grey,
                backgroundImage: CachedNetworkImageProvider(
                  '$imgPath/$image',
                ),
              ),
              const Spacer(),
              Text(
                item.subcategory!,
                style: smallText,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                '₹${item.total}',
                style: smallText,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '₹${item.price}',
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.black45),
                  ),
                  const SizedBox(width: 5),
                  Text('₹${item.discountedPrice}% Off', style: smallColorText)
                ],
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star,
                    size: 25,
                    color: primaryColor,
                  ),
                  const Spacer(flex: 1),
                  Text('4.7', style: smallLightText),
                  const Spacer(flex: 5),
                  Text('India'.tr, style: smallLightText),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
