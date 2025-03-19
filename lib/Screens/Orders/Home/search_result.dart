import 'package:kake_autoparts/Constants/exports.dart';
import 'package:kake_autoparts/Models/sub_cat_model.dart';
//import '../../Models/sub_cat_model.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    searchController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SafeArea(
          child: Column(
            children: [
              buildSearchBar(),
              const SizedBox(height: defaultPadding),
              searchController.text.isEmpty
                  ? Container()
                  : Expanded(
                      child: FutureBuilder<SubCategoryModel>(
                        future: HomeUtils.getSearch(searchController.text),
                        builder: (context, snapshot) => snapshot.hasData
                            ? snapshot.data!.data!.isEmpty
                                ? Center(
                                    child: Text('No Result found',
                                        style: largeText),
                                  )
                                : Scrollbar(
                                    interactive: true,
                                    thickness: 8,
                                    trackVisibility: true,
                                    child: ListView.builder(
                                      itemCount: snapshot.data!.data!.length,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          buildProductCard(
                                              size,
                                              snapshot,
                                              index,
                                              snapshot.data!.data![index]
                                                  .subcategory!),
                                    ),
                                  )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.all(
              Radius.circular(12.00),
            ),
          ),
          prefixIcon: const Icon(Icons.search),
          hintText: "Search".tr,
        ),
      ),
    );
  }
}
