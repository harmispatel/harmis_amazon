import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/services/api_url.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:big_mart/views/categories/categories_view_model.dart';
import 'package:big_mart/views/checkout/checkout_view_model.dart';
import 'package:big_mart/views/home/top_seller_item_view_model.dart';
import 'package:big_mart/views/more/more_view.dart';
import 'package:big_mart/views/order_details/order_details_view_model.dart';
import 'package:big_mart/views/product_detail/similar_product_view_model.dart';
import 'package:big_mart/views/splash/splash_view.dart';
import 'package:big_mart/views/splash/splash_view_model.dart';
import 'package:big_mart/widgets/product_selection_layout/product_selection.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'database/app_preferences.dart';
import 'generated/i18n.dart';
import 'main.dart';
import 'models/app.dart';
import 'views/addAddress/add_address_view_model.dart';
import 'views/addressList/address_list_view_model.dart';
import 'views/cart/cart_list_item_view_model.dart';
import 'views/cart/cart_list_view_model.dart';
import 'views/categories/sub_category_view_model.dart';
import 'views/currect_location_header/current_location_header_view_model.dart';
import 'views/deals/deal_list_view_model.dart';
import 'views/filter_dialog/filter_view_model.dart';
import 'views/forgot_password/forgot_password_view_model.dart';
import 'views/home/home_view_model.dart';
import 'views/invoice_summary/invoice_summary_view_model.dart';
import 'views/language_selection/language_selection_view_model.dart';
import 'views/login/login_view_model.dart';
import 'views/more/more_view_model.dart';
import 'views/my_list/my_list_item_view_model.dart';
import 'views/my_list/my_list_view_model.dart';
import 'views/my_orders/my_orders_view_model.dart';
import 'views/order_track/order_trick_view_model.dart';
import 'views/product_detail/product_details_view_model.dart';
import 'views/product_list/product_list_item_view_model.dart';
import 'views/product_list/product_list_view_model.dart';
import 'views/profile/profile_view_model.dart';
import 'views/register/register_view_model.dart';
import 'views/search_product/search_product_view_model.dart';
import 'views/verify_account/verify_account_view_model.dart';
import 'widgets/bottom_nav_bar/bottom_nav_bar_view_model.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  static BuildContext appContext;
  final _app = AppModel();
  AppPreferences appPreferences = new AppPreferences();
  List<StreamSubscription> _streams = List();

  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  @override
  Future initState() {
    super.initState();
    print("Init app");
    /*if (Platform.isIOS || Platform.isAndroid) {
      setUpLocalNotifications();
      _streams.clear();
      _fcmSetup();
    }*/
  }

  @override
  void dispose() {
    /*if (Platform.isIOS || Platform.isAndroid) {
      _streams.clear();
      _streams.forEach((element) {
        element.cancel();
      });
    }*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appContext = context;
    if (!kIsWeb) {
      FlutterStatusbarcolor.setStatusBarColor(CommonColors.dark_6060);
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    }
    return ChangeNotifierProvider<AppModel>.value(
      value: _app,
      child: Consumer<AppModel>(
        builder: (context, value, child){
          value.isLoading = false;

          if (value.isLoading) {
            return Container(
              color: Theme.of(context).backgroundColor,
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (context) => BottomNavBarViewModel()),
              ChangeNotifierProvider(
                  create: (context) => SplashViewModel()),
              ChangeNotifierProvider(
                  create: (context) => LanguageSelectionViewModel()),
              ChangeNotifierProvider(create: (context) => LoginViewModel()),
              ChangeNotifierProvider(create: (context) => RegisterViewModel()),
              ChangeNotifierProvider(
                  create: (context) => VerifyAccountViewModel()),
              ChangeNotifierProvider(create: (context) => ProfileViewModel()),
              ChangeNotifierProvider(create: (context) => HomeViewModel()),
              ChangeNotifierProvider(
                  create: (context) => CategoriesViewModel()),
              ChangeNotifierProvider(
                  create: (context) => ProductListViewModel()),
              ChangeNotifierProvider(
                  create: (context) => ProductDetailsViewModel()),
              ChangeNotifierProvider(create: (context) => FilterViewModel()),
              ChangeNotifierProvider(
                  create: (context) => SearchProductViewModel()),
              ChangeNotifierProvider(create: (create) => MyListViewModel()),
              ChangeNotifierProvider(create: (create) => MoreViewModel()),
              ChangeNotifierProvider(
                  create: (context) => ForgotPasswordViewModel()),
              ChangeNotifierProvider(
                  create: (context) => SubCategoryViewModel()),
              ChangeNotifierProvider(
                  create: (context) => TopSellerItemViewModel()),
              ChangeNotifierProvider(
                  create: (context) => ProductListItemViewModel()),
              ChangeNotifierProvider(
                  create: (context) => MyListItemViewModel()),
              ChangeNotifierProvider(create: (context) => CartListViewModel()),
              ChangeNotifierProvider(
                  create: (context) => CartListItemViewModel()),
              ChangeNotifierProvider(
                  create: (context) => AddAddressViewModel()),
              ChangeNotifierProvider(create: (context) => DealListViewModel()),
              ChangeNotifierProvider(
                  create: (context) => AddressListViewModel()),
              ChangeNotifierProvider(create: (context) => CheckoutViewModel()),
              ChangeNotifierProvider(create: (context) => MyOrdersViewModel()),
              ChangeNotifierProvider(
                  create: (context) => OrderDetailsViewModel()),
              ChangeNotifierProvider(
                  create: (context) => InvoiceSummaryViewModel()),
              ChangeNotifierProvider(
                  create: (context) => OrderTrackViewModel()),
              ChangeNotifierProvider(
                  create: (context) => SimilarProduactViewModel()),
              ChangeNotifierProvider(
                create: (context) => CurrentLocationHeaderViewModel(),
              ),
            ],
            child: MaterialApp(
              /*builder: (BuildContext context, Widget child) {
                final MediaQueryData data = MediaQuery.of(context);
                return MediaQuery(
                    child: child, data: data.copyWith(textScaleFactor: 1));
              },*/
              theme: ThemeData(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
              debugShowCheckedModeBanner: false,
              locale: new Locale(Provider.of<AppModel>(context).locale, ""),
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              localeListResolutionCallback: S.delegate.listResolution(
                  fallback: const Locale(AppConstants.LANGUAGE_ARABIC, '')),
              home: SplashView(),
              navigatorObservers: [],
              routes: <String, WidgetBuilder>{},
            ),
          );
        },
      ),
    );
  }
/*

  Future<void> setUpLocalNotifications() async {
    final NotificationAppLaunchDetails notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {
      debugPrint('onDidReceiveLocalNotification payload: $payload');
    });
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      debugPrint('notification payload: $payload');
    });
  }

  Future<void> onReceivedMessage(RemoteMessage event) async {
    // print("onMessage : ${event.notification.title}");
    // print("onMessage : ${event.notification.body}");
    */ /*if (event.notification != null) {
      _showNotification(event);
    }*/ /*

    RemoteNotification notification = event.notification;

    if (notification != null && Platform.isIOS) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              icon: 'launch_background',
            ),
          ),
          payload: jsonEncode(event.data));
    }
  }

  void onReceivedMessageFromBG(RemoteMessage event) {
    print("onMessageOpen : ${event.notification.title}");
  }

  _fcmSetup() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('launch_background');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) async {
      print(
          "_fcmSetup: IOSInitializationSettings $id = $title -> $body -> $payload");
    });

    /// For handle manual notification click for foreground
    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS),
      onSelectNotification: (payload) async {
        print("_fcmSetup: initialize payload -> $payload");

        // Fluttertoast.showToast(msg: "onSelectNotification\n${jsonDecode(payload)}", toastLength: Toast.LENGTH_LONG);
      },
    );

    /// only in Android when app is in foreground and need to show manual notification
    _streams
        .add(FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(
          "_fcmSetup: onMessage -> ${message.notification?.title ?? ""} -> ${message.notification?.body ?? ""} -> ${message.data}");
      print("onMessage" + message.data.toString());

      RemoteNotification notification = message.notification;

      if (notification != null && Platform.isIOS) {
        final String bigPicturePath = await _downloadAndSaveFile(
            notification.apple.imageUrl, 'bigPicture.jpg');
        final IOSNotificationDetails iOSPlatformChannelSpecifics =
            IOSNotificationDetails(attachments: <IOSNotificationAttachment>[
          IOSNotificationAttachment(bigPicturePath)
        ]);
        final NotificationDetails notificationDetails =
            NotificationDetails(iOS: iOSPlatformChannelSpecifics);
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          notificationDetails,
        );
      }
    }));

    /// only when app is in background and notification click
    /// Android : only when app is in background
    /// iOS : foreground and background both
    _streams.add(
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          "_fcmSetup: onMessageOpenedApp -> ${message.notification.title} -> ${message.notification.body} -> ${message.data}");
      // Fluttertoast.showToast(msg: "onMessageOpenedApp\n${message.data}", toastLength: Toast.LENGTH_LONG);
    }));

    var fcmToken = await FirebaseMessaging.instance.getToken();
    print("_fcmSetup: $fcmToken");
    AppPreferences().setDeviceToken(fcmToken);

    /// only when app is terminated and notification click
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        print("_fcmSetup: getInitialMessage ${message.data}");
        // Fluttertoast.showToast(msg: "getInitialMessage\n${message.data}", toastLength: Toast.LENGTH_LONG);
      } else
        print("_fcmSetup: getInitialMessage not found");
    });
  }

  void _showBigPictureNotification(
      String image, String title, String message) async {
    final String largeIconPath =
        await _downloadAndSaveFile(ApiUrl.NOTIFICATION_LOGO_URL, 'largeIcon');
    final String bigPicturePath =
        await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
            hideExpandedLargeIcon: true,
            contentTitle: title,
            htmlFormatContentTitle: true,
            summaryText: message,
            htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('big text channel id',
            'big text channel name', 'big text channel description',
            largeIcon: FilePathAndroidBitmap(largeIconPath),
            styleInformation: bigPictureStyleInformation);
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title, message, platformChannelSpecifics);
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(url);
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  */
}
