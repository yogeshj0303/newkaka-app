import 'package:kake_autoparts/Constants/exports.dart';
import 'package:kake_autoparts/Models/show_ordermodel.dart';
import 'package:kake_autoparts/Screens/Product/translate_helper.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});
  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text('Your Orders'.tr),
      ),
      body: FutureBuilder<ShowOrderModel>(
          future: ProductUtils.showOrders(),
          builder: (context, snapshot) => snapshot.hasData
              ? snapshot.data!.orders!.isEmpty
                  ? noOrder()
                  : Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.orders!.length,
                        itemBuilder: (context, index) =>
                            OrdersCard(snapshot: snapshot, index: index, c: c),
                      ),
                    )
              : loading),
    );
  }

  Align noOrder() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(orderLottie, height: 300, fit: BoxFit.cover),
          Text('No Orders Yet'.tr, style: largeLightText)
        ],
      ),
    );
  }
}

class OrdersCard extends StatelessWidget {
  final AsyncSnapshot<ShowOrderModel> snapshot;
  final int index;
  final GetController c;
  const OrdersCard(
      {super.key,
      required this.snapshot,
      required this.index,
      required this.c});

  @override
  Widget build(BuildContext context) {
    final address = snapshot.data!.orders![index].address!;
    final orderId = snapshot.data!.orders![index].orderid;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: RoundedContainer(
        padding: const EdgeInsets.all(defaultPadding),
        color: Colors.black12,
        isImage: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            c.lang.value == 'en'
                ? Text(
                    'Order Id : $orderId',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  )
                : c.lang.value == 'hi'
                    ? TranslateHelper(
                        data: 'Order Id : $orderId',
                        language: 'hi',
                      )
                    : c.lang.value == 'mr'
                        ? TranslateHelper(
                            data: 'Order Id : $orderId', language: 'mr')
                        : c.lang.value == 'gu'
                            ? TranslateHelper(
                                data: 'Order Id : $orderId', language: 'gu')
                            : TranslateHelper(
                                data: 'Order Id : $orderId', language: 'ta'),
            c.lang.value == 'en'
                ? Text(
                    snapshot.data!.orders![index].orderdetails![0].orderDate!,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  )
                : c.lang.value == 'hi'
                    ? TranslateHelper(
                        data: snapshot
                            .data!.orders![index].orderdetails![0].orderDate!,
                        language: 'hi',
                      )
                    : c.lang.value == 'mr'
                        ? TranslateHelper(
                            data: snapshot.data!.orders![index].orderdetails![0]
                                .orderDate!,
                            language: 'mr')
                        : c.lang.value == 'gu'
                            ? TranslateHelper(
                                data: snapshot.data!.orders![index]
                                    .orderdetails![0].orderDate!,
                                language: 'gu')
                            : TranslateHelper(
                                data: snapshot.data!.orders![index]
                                    .orderdetails![0].orderDate!,
                                language: 'ta'),
            Text('Delivery Address : '.tr, style: normalColorText),
            c.lang.value == 'en'
                ? Text(
                    '${address.street!}, ${address.city!},\n${address.state}, ${address.country}\n${address.pinCode}',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  )
                : c.lang.value == 'hi'
                    ? TranslateHelper(
                        data:
                            '${address.street!}, ${address.city!},\n${address.state}, ${address.country}\n${address.pinCode}',
                        language: 'hi',
                      )
                    : c.lang.value == 'mr'
                        ? TranslateHelper(
                            data:
                                '${address.street!}, ${address.city!},\n${address.state}, ${address.country}\n${address.pinCode}',
                            language: 'mr')
                        : c.lang.value == 'gu'
                            ? TranslateHelper(
                                data:
                                    '${address.street!}, ${address.city!},\n${address.state}, ${address.country}\n${address.pinCode}',
                                language: 'gu')
                            : TranslateHelper(
                                data:
                                    '${address.street!}, ${address.city!},\n${address.state}, ${address.country}\n${address.pinCode}',
                                language: 'ta'),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.orders![index].orderdetails!.length,
              itemBuilder: (context, ind) =>
                  ordersItemCard(snapshot, ind, size),
            )
          ],
        ),
      ),
    );
  }

  ordersItemCard(AsyncSnapshot<ShowOrderModel> snapshot, int ind, Size size) {
    final item = snapshot.data!.orders![index].orderdetails![ind];
    return Padding(
      padding: const EdgeInsets.only(top: defaultPadding),
      child: RoundedContainer(
        padding: const EdgeInsets.all(defaultPadding),
        isImage: false,
        color: whiteColor,
        child: Row(
          children: [
            RoundedContainer(
              height: 150,
              width: size.width * 0.3,
              isImage: true,
              networkImg: '$imgPath/${item.image}',
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width / 2,
                  child: c.lang.value == 'en'
                      ? Text(
                          item.subcategoryName!,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        )
                      : c.lang.value == 'hi'
                          ? TranslateHelper(
                              data: item.subcategoryName!,
                              language: 'hi',
                            )
                          : c.lang.value == 'mr'
                              ? TranslateHelper(
                                  data: item.subcategoryName!, language: 'mr')
                              : c.lang.value == 'gu'
                                  ? TranslateHelper(
                                      data: item.subcategoryName!,
                                      language: 'gu')
                                  : TranslateHelper(
                                      data: item.subcategoryName!,
                                      language: 'ta'),
                ),
                Text('₹${item.total}', style: normalText),
                const SizedBox(height: 2),
                c.lang.value == 'en'
                    ? Text(
                        'Status : ${item.activeStatus}',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      )
                    : c.lang.value == 'hi'
                        ? TranslateHelper(
                            data: 'Status : ${item.activeStatus}',
                            language: 'hi',
                          )
                        : c.lang.value == 'mr'
                            ? TranslateHelper(
                                data: 'Status : ${item.activeStatus}',
                                language: 'mr')
                            : c.lang.value == 'gu'
                                ? TranslateHelper(
                                    data: 'Status : ${item.activeStatus}',
                                    language: 'gu')
                                : TranslateHelper(
                                    data: 'Status : ${item.activeStatus}',
                                    language: 'ta'),
                const SizedBox(height: 2),
                RoundedContainer(
                  isImage: false,
                  color: bgColor,
                  padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding * 0.5,
                      horizontal: defaultPadding),
                  child: c.lang.value == 'en'
                      ? Text(
                          'Quantity : ${item.quantity}',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        )
                      : c.lang.value == 'hi'
                          ? TranslateHelper(
                              data: 'Quantity : ${item.quantity}',
                              language: 'hi',
                            )
                          : c.lang.value == 'mr'
                              ? TranslateHelper(
                                  data: 'Quantity : ${item.quantity}',
                                  language: 'mr')
                              : c.lang.value == 'gu'
                                  ? TranslateHelper(
                                      data: 'Quantity : ${item.quantity}',
                                      language: 'gu')
                                  : TranslateHelper(
                                      data: 'Quantity : ${item.quantity}',
                                      language: 'ta'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
