// ignore: unnecessary_import
import 'package:carousel_slider/carousel_options.dart';
import 'package:kake_autoparts/Constants/exports.dart';
import 'package:kake_autoparts/Models/banner_model.dart';
import 'package:kake_autoparts/Models/category_model.dart';
import 'package:kake_autoparts/Models/sub_cat_model.dart';
import 'package:kake_autoparts/Screens/Orders/Home/search_result.dart';
import 'package:kake_autoparts/Screens/Product/translate_helper.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final c = Get.put(GetController());

  late Future<CategoryModel> _categoryFuture;
  late Future<BannerModel> _bannerFuture;
  late Future<SubCategoryModel> _dealOfDayFuture;

  @override
  void initState() {
    super.initState();
    _categoryFuture = HomeUtils.getCategory();
    _bannerFuture = HomeUtils.getBanner();
    _dealOfDayFuture = HomeUtils.getDealofDay();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Image.asset(smallappLogo, height: 75),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.to(() => const Cart(), transition: Transition.upToDown),
            icon: Image.asset(cart, height: 25, color: Colors.black54),
          ),
          IconButton(
            onPressed: () => _showLanguageSelection(),
            icon: Image.asset(langIcon, height: 30),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: defaultPadding * 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
                child: buildSearchBar(),
              ),
              const SizedBox(height: defaultPadding),
              buildBanner(size),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: buildCategory(size),
              ),
              const SizedBox(height: defaultPadding),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: buildTopSelling(),
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageSelection() {
    Get.bottomSheet(
      SizedBox(
        height: 325,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Choose Language'.tr, style: normalText),
            _buildLanguageTile('हिन्दी', 'hi'),
            _buildLanguageTile('English', 'en'),
            _buildLanguageTile('Marathi', 'mr'),
            _buildLanguageTile('Gujrati', 'gu'),
            _buildLanguageTile('Tamil', 'ta'),
          ],
        ),
      ),
      backgroundColor: whiteColor,
    );
  }

  ListTile _buildLanguageTile(String language, String code) {
    return ListTile(
      title: Text(language),
      onTap: () {
        c.lang.value = code;
        SharedPrefs.loginSave(c.phone.value, code);
        Locale locale = Locale(code, code == 'en' ? 'US' : 'IN');
        Get.updateLocale(locale);
        Get.back();
      },
      trailing: c.lang.value == code
          ? const Icon(Icons.radio_button_checked, color: primaryColor)
          : const Icon(Icons.radio_button_unchecked),
    );
  }

  Widget buildSearchBar() {
    return TextFormField(
      onTap: () => Get.to(() => const SearchResult()),
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: whiteColor,
        constraints: const BoxConstraints.tightFor(width: double.infinity, height: 50),
        contentPadding: EdgeInsets.zero,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.all(Radius.circular(12.00)),
        ),
        prefixIcon: const Icon(Icons.search),
        hintText: "Search".tr,
      ),
    );
  }

  Widget buildCategory(Size size) {
    return FutureBuilder<CategoryModel>(
      future: _categoryFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerEffect(size);
        } else if (snapshot.hasError) {
          return _buildErrorWidget('Failed to load categories');
        } else if (snapshot.hasData) {
          return buildCategoryCard(snapshot, size);
        } else {
          return _buildErrorWidget('No categories available');
        }
      },
    );
  }

  Column buildCategoryCard(AsyncSnapshot<CategoryModel> snapshot, Size size) {
    var item = snapshot.data!.data!;
    return Column(
      children: [
        BuildTitle(
          title: 'Product Category'.tr,
          onPressed: () => Get.to(() => AllCategory(snapshot: snapshot)),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: item.length > 9 ? 9 : item.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemBuilder: (context, index) => Column(
            children: [
              Ink(
                height: size.height / 10,
                width: size.width / 4,
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(defaultCardRadius),
                      child: SizedBox(
                        child: CachedNetworkImage(
                          imageUrl: '$imgPath/${snapshot.data!.data![index].image}',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.to(
                      () => SubCategory(
                        image: '$imgPath/${snapshot.data!.data![index].image}',
                        name: item[index].name!,
                        subCatId: item[index].id!.toInt(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: 70,
                height: 20,
                child: _buildTranslatedText(item[index].name),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTranslatedText(String? text) {
    return c.lang.value == 'en'
        ? Text(
            text ?? '',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        : TranslateHelper(
            data: text ?? '',
            language: c.lang.value,
          );
  }

  Widget buildBanner(Size size) {
    return FutureBuilder<BannerModel>(
      future: _bannerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerEffect(size);
        } else if (snapshot.hasError) {
          return _buildErrorWidget('Failed to load banners');
        } else if (snapshot.hasData && snapshot.data!.data!.isNotEmpty) {
          return CarouselSlider.builder(
            itemCount: snapshot.data!.data!.length,
            itemBuilder: (BuildContext context, int index, int realIndex) =>
                Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Container(
                height: size.height / 4,
                width: size.width - 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultCardRadius),
                  color: Colors.white,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        '$imgPath/${snapshot.data!.data![index].image}'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1,
            ),
          );
        } else {
          return _buildErrorWidget('No banners available');
        }
      },
    );
  }

  Widget _buildShimmerEffect([Size? size]) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Container(
          height: size != null ? size.height / 4 : 100,
          width: size != null ? size.width : double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultCardRadius),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildTopSelling() {
    return FutureBuilder<SubCategoryModel>(
      future: _dealOfDayFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerEffect();
        } else if (snapshot.hasError) {
          return _buildErrorWidget('Failed to load top selling items');
        } else if (snapshot.hasData) {
          return _buildTopSellingContent(snapshot);
        } else {
          return _buildErrorWidget('No top selling items available');
        }
      },
    );
  }

  Column _buildTopSellingContent(AsyncSnapshot<SubCategoryModel> snapshot) {
    return Column(
      children: [
        BuildTitle(
          title: 'Deal of the day'.tr,
          onPressed: () => Get.to(() => AllTopSelling(snapshot: snapshot)),
        ),
        CarouselSlider.builder(
          itemCount: snapshot.data!.data!.length,
          itemBuilder: (context, index, realIndex) =>
              topSellingCard(snapshot, index),
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1,
            aspectRatio: 1.15,
          ),
        ),
      ],
    );
  }

  Widget topSellingCard(AsyncSnapshot<SubCategoryModel> snapshot, int index) {
    final item = snapshot.data!.data![index];
    final image = item.image!;
    return InkWell(
      onTap: () => Get.to(() => SubCategoryDetails(
          snapshot: snapshot, ind: index, subCatgName: item.subcategory!)),
      child: RoundedContainer(
        padding: const EdgeInsets.all(defaultPadding),
        isImage: false,
        color: whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedContainer(
              height: 180,
              isImage: true,
              networkImg: '$imgPath/$image',
            ),
            const Spacer(),
            _buildTranslatedText(item.subcategory),
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
                    color: Colors.black45,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 8),
                Text('₹${item.discountedPrice} Off', style: xSmallColorText),
              ],
            ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: _buildTranslatedText(item.description),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, style: TextStyle(color: Colors.red)),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Retry logic
                _categoryFuture = HomeUtils.getCategory();
                _bannerFuture = HomeUtils.getBanner();
                _dealOfDayFuture = HomeUtils.getDealofDay();
              });
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
}
