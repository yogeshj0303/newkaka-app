// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kake_autoparts/Constants/exports.dart';
import 'package:kake_autoparts/Models/wishlistmodel.dart';
import 'package:kake_autoparts/Screens/Product/translate_helper.dart';

class WishlistScreen extends StatefulWidget {
  WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final c = Get.put(GetController());
  late Future<WishListModel> _wishList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _wishList = ProductUtils.showWishlist();
  }
  Future<void> removeFromWishlist(int subCatgId) async {
    final url =
        '${apiUrl}deleteWishlist?customer_id=${GlobalVariable.id}&subcategorie_id=$subCatgId';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        Fluttertoast.showToast(msg: 'Item removed from your Wishlist'.tr)
            .then((value) => setState(() {}));
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Wishlist'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: FutureBuilder<WishListModel>(
            future: _wishList,
            builder: (context, snapshot) => snapshot.hasData
                ? snapshot.data!.data!.isEmpty
                    ? buildEmptyLottie()
                    : GridView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) =>
                            wishListCard(snapshot, index, c, size),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                      )
                : loading),
      ),
    );
  }

  Widget wishListCard(AsyncSnapshot<WishListModel> snapshot, int index,
      GetController c, Size size) {
    final item = snapshot.data!.data![index].subcategorie!;
    final image = item.image;
    c.isProductLiked.value = snapshot.data!.data![index].wishlist!;
    return InkWell(
      // onTap: () =>
      //     Get.to(() => SubCategoryDetails(snapshot: snapshot, ind: index)),
      child: RoundedContainer(
        padding: const EdgeInsets.all(defaultPadding),
        isImage: false,
        color: whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            RoundedContainer(
              width: size.width * 0.5,
              height: 150,
              isImage: true,
              networkImg: '$imgPath/$image',
              child: Align(
                alignment: Alignment.topRight,
                child: MyContainer(
                  height: 35,
                  width: 35,
                  color: Colors.black26,
                  child: IconButton(
                      onPressed: () => c.isProductLiked.value
                          ? removeFromWishlist(item.id!.toInt())
                          : ProductUtils.addToWishlist(item.id!.toInt()),
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 15,
                      )),
                ),
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
                    ? TranslateHelper(data: item.subcategory!, language: 'mr')
                    : c.lang.value == 'gu'
                        ? TranslateHelper(data: item.subcategory!, language: 'gu')
                        : TranslateHelper(data: item.subcategory!, language: 'ta'),
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
                const SizedBox(width: 8),
                Text('₹${item.discountedPrice} Off', style: smallColorText),
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
    );
  }

  Align buildEmptyLottie() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: const BoxDecoration(
              color: whiteColor,
              shape: BoxShape.circle,
            ),
            child: Lottie.asset(wishlistLottie, height: 275),
          ),
          const SizedBox(height: 8),
          Text('No Products in your Wishlist'.tr, style: largeLightText)
        ],
      ),
    );
  }
}
