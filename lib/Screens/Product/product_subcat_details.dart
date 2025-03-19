// ignore_for_file: deprecated_member_use
import 'dart:convert';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:kake_autoparts/Screens/Product/product_video.dart';
import 'package:kake_autoparts/Screens/Product/translate_helper.dart';
import '../../../Constants/exports.dart';
import '../../Models/sub_cat_model.dart';
// ignore_for_file: prefer_const_constructors

class SubCategoryDetails extends StatefulWidget {
  final AsyncSnapshot<SubCategoryModel> snapshot;
  final int ind;
  final String subCatgName;
  const SubCategoryDetails({
    super.key,
    required this.snapshot,
    required this.ind,
    required this.subCatgName,
  });

  @override
  State<SubCategoryDetails> createState() => _SubCategoryDetailsState();
}

class _SubCategoryDetailsState extends State<SubCategoryDetails> {
  final c = Get.put(GetController());
  late VideoPlayerController videoController;
  late ChewieController chewieController;
  late String videoUrl;
  late List<String> allImages;
  @override
  void initState() {
    final item = widget.snapshot.data!.data![widget.ind];
    final image = item.image!;
    videoUrl = item.video ?? '';
    allImages = [];
    if (item.otherImages != null) {
      allImages = item.otherImages!.split(',');
      allImages.add(image);
    } else {
      allImages = [image];
    }
    videoController =
        VideoPlayerController.networkUrl(Uri.parse('$imgPath/$videoUrl'));
    chewieController = ChewieController(videoPlayerController: videoController);
    super.initState();
  }

  @override
  void dispose() {
    videoController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.snapshot.data!.data!.length;
    final size = MediaQuery.of(context).size;
    final item = widget.snapshot.data!.data![widget.ind];
    return Scaffold(
      appBar: AppBar(
        title: c.lang.value == 'en'
            ? Text(
                widget.subCatgName,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              )
            : c.lang.value == 'hi'
                ? TranslateHelper(
                    data: widget.subCatgName,
                    language: 'hi',
                  )
                : c.lang.value == 'mr'
                    ? TranslateHelper(data: widget.subCatgName, language: 'mr')
                    : c.lang.value == 'gu'
                        ? TranslateHelper(
                            data: widget.subCatgName, language: 'gu')
                        : TranslateHelper(
                            data: widget.subCatgName, language: 'ta'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount:
                  videoUrl == '' ? allImages.length : allImages.length + 1,
              itemBuilder: (context, index, realIndex) =>
                  index < allImages.length
                      ? Container(
                          width: double.maxFinite,
                          color: whiteColor,
                          child: CachedNetworkImage(
                              imageUrl: '$imgPath/${allImages[index]}'))
                      : Chewie(
                          controller: chewieController,
                        ),
              options: CarouselOptions(
                height: 280,
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
                          style: mediumText,
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
                          style: smallColorText),
                      const Spacer(),
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
                              icon:
                                  Icon(Icons.play_circle, color: primaryColor),
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
                  const SizedBox(height: defaultMargin * 0.5),
                  c.lang.value == 'en'
                      ? Text(
                          item.description!,
                          textAlign: TextAlign.center,
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
                      itemBuilder: (context, index) => index == widget.ind
                          ? Container()
                          : buildMayLikeCard(size, widget.snapshot, index),
                    ),
                  ),
                  // Text(
                  //   'Category'.tr,
                  //   style: normalText,
                  // ),
                  // const SizedBox(height: defaultMargin),
                  // ProductCategory(
                  //     size: size, image: image, c: c, catId: item.categoryId!),
                ],
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
      bottomSheet:
          BottomCard(snp: widget.snapshot, ind: widget.ind, item: item),
    );
  }

  Widget buildMayLikeCard(
      Size size, AsyncSnapshot<SubCategoryModel> snapshot, int index) {
    final c = Get.put(GetController());
    final item = snapshot.data!.data![index];
    final image = item.image!;
    return InkWell(
      onTap: () => Get.off(
        () => SubCatDetails(
            snapshot: snapshot, ind: index, subCatgName: widget.subCatgName),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: defaultPadding * 2),
        child: RoundedContainer(
          height: size.height / 2,
          width: size.width / 2 - (defaultPadding * 4),
          padding: const EdgeInsets.all(defaultPadding),
          isImage: false,
          color: whiteColor,
          borderColor: Colors.black12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                                  data: item.subcategory!, language: 'ta'),
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
                  Text('${item.discountedPrice} Off', style: smallColorText)
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

class BottomCard extends StatefulWidget {
  final AsyncSnapshot<SubCategoryModel> snp;
  final int ind;
  const BottomCard(
      {super.key, required this.snp, required this.ind, required Data item});

  @override
  State<BottomCard> createState() => _BottomCardState();
}

class _BottomCardState extends State<BottomCard> {
  final c = Get.put(GetController());
  Future<void> removeFromWishlist(int subCatgId) async {
    final url =
        '${apiUrl}deleteWishlist?customer_id=${GlobalVariable.id}&subcategorie_id=$subCatgId';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        c.isProductLiked.value = false;
        Fluttertoast.showToast(msg: 'Item removed from my Wishlist');
      } else {
        Fluttertoast.showToast(msg: 'item not found');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.snp.data!.data![widget.ind];
    final size = MediaQuery.of(context).size;
    c.isProductLiked.value = item.wishlist ?? false;
    c.isProductInCart.value = false;
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        height: 70,
        child: Row(
          children: [
            const Spacer(flex: 2),
            RoundedContainer(
              borderColor: primaryColor,
              height: 60,
              width: size.width * 0.2,
              isImage: false,
              color: bgColor,
              onTap: () async {
                // final url = '$imgPath/${item.image}';
                // final response = await http.put(Uri.parse(url));
                // final bytes = response.bodyBytes;
                // final temp = await getTemporaryDirectory();
                // final path = '${temp.path}/image.jpg';
                // File(path).writeAsBytesSync(bytes);
                await Share.share(
                    '$imgPath/${item.image}\n${item.subcategory}\nPrice: ${item.price}',
                    subject: "New Kake Auto Parts Products");
              },
              child: const Icon(Icons.share),
            ),
            const Spacer(flex: 1),
            Obx(
              () => RoundedContainer(
                borderColor: primaryColor,
                height: 60,
                width: size.width * 0.2,
                isImage: false,
                color: bgColor,
                onTap: () => c.isProductLiked.value
                    ? removeFromWishlist(item.id!.toInt())
                    : ProductUtils.addToWishlist(item.id!.toInt()),
                child: c.isProductLiked.value
                    ? const Icon(Icons.favorite, color: Colors.red)
                    : const Icon(Icons.favorite_outline, color: Colors.red),
              ),
            ),
            const Spacer(flex: 1),
            RoundedContainer(
              height: 60,
              width: size.width * 0.45,
              isImage: false,
              color: primaryColor,
              onTap: () => c.isProductInCart.value
                  ? Get.to(() => Cart())
                  : ProductUtils.addToCart(item.id!.toInt()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_bag_outlined, color: whiteColor),
                  const SizedBox(width: 8),
                  c.isProductInCart.value
                      ? Text('View Cart'.tr, style: mediumWhiteText)
                      : Text('Add To Cart'.tr, style: mediumWhiteText),
                ],
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
