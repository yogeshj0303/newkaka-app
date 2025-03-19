import 'package:kake_autoparts/Constants/exports.dart';
import 'package:kake_autoparts/Screens/Product/translate_helper.dart';
import '../../Models/noti_model.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final c = Get.put(GetController());
  late Future<NotificationModel> _getNotification;


  @override
  void initState() {
    super.initState();
    _getNotification = ProductUtils.showNotification();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notification'.tr),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: FutureBuilder<NotificationModel>(
            future: _getNotification,
            builder: (context, snapshot) => snapshot.hasData
                ? snapshot.data!.message!.isEmpty
                    ? noNotification(size)
                    : notificationCard(snapshot, size)
                : loading,
          ),
        ),
      ),
    );
  }

  Center noNotification(Size size) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.2),
          const Icon(Icons.circle_notifications,
              size: 170, color: primaryColor),
          Text('No Notifications Yet'.tr, style: xLargeLightText)
        ],
      ),
    );
  }

  Widget notificationCard(
      AsyncSnapshot<NotificationModel> snapshot, Size size) {
    final item = snapshot.data!.message!;
    int length = item.length;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: RoundedContainer(
          color: whiteColor,
          width: size.width,
          padding: const EdgeInsets.all(defaultPadding * 2),
          isImage: false,
          child: Row(
            children: [
              SizedBox(
                width: 50,
                child: Column(
                  children: [
                    Text(
                      item[index].date!.split(' ')[0],
                      textAlign: TextAlign.center,
                      style: largeLightText,
                    ),
                    c.lang.value == 'en'
                        ? Text(
                            item[index].date!.split(' ')[1].substring(0, 3),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          )
                        : c.lang.value == 'hi'
                            ? TranslateHelper(
                                data: item[index]
                                    .date!
                                    .split(' ')[1]
                                    .substring(0, 3),
                                language: 'hi',
                              )
                            : c.lang.value == 'mr'
                                ? TranslateHelper(
                                    data: item[index]
                                        .date!
                                        .split(' ')[1]
                                        .substring(0, 3),
                                    language: 'mr')
                                : c.lang.value == 'gu'
                                    ? TranslateHelper(
                                        data: item[index]
                                            .date!
                                            .split(' ')[1]
                                            .substring(0, 3),
                                        language: 'gu')
                                    : TranslateHelper(
                                        data: item[index]
                                            .date!
                                            .split(' ')[1]
                                            .substring(0, 3),
                                        language: 'ta'),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  c.lang.value == 'en'
                      ? Text(
                          item[index].type!,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        )
                      : c.lang.value == 'hi'
                          ? TranslateHelper(
                              data: item[index].type!,
                              language: 'hi',
                            )
                          : c.lang.value == 'mr'
                              ? TranslateHelper(
                                  data: item[index].type!, language: 'mr')
                              : c.lang.value == 'gu'
                                  ? TranslateHelper(
                                      data: item[index].type!, language: 'gu')
                                  : TranslateHelper(
                                      data: item[index].type!, language: 'ta'),
                  SizedBox(
                    width: size.width - 125,
                    child: c.lang.value == 'en'
                        ? Text(
                            item[index].message!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          )
                        : c.lang.value == 'hi'
                            ? TranslateHelper(
                                data: item[index].message!,
                                language: 'hi',
                              )
                            : c.lang.value == 'mr'
                                ? TranslateHelper(
                                    data: item[index].message!, language: 'mr')
                                : c.lang.value == 'gu'
                                    ? TranslateHelper(
                                        data: item[index].message!,
                                        language: 'gu')
                                    : TranslateHelper(
                                        data: item[index].message!,
                                        language: 'ta'),
                  ),
                  Text(
                    item[index].time!,
                    style: smallLightText,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
