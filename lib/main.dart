import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fl_location/fl_location.dart';
import 'package:fl_location_platform_interface/src/models/location.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_bloc/src/multi_bloc_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:sevin_rm/UI/Screens/favorite/favoriteScreen.dart';
import 'package:sevin_rm/UI/Screens/main_screen/bloc/cubit.dart';
import 'package:sevin_rm/UI/Screens/main_screen/bloc/states.dart';
import 'package:sevin_rm/helper/dio_helper.dart';
import 'package:sevin_rm/language/app_localization.dart';
import 'package:sevin_rm/language/language_store.dart';
import 'package:sevin_rm/language/repository.dart';
import 'package:sizer/sizer.dart';

import 'Core/di/di_manager.dart';
import 'Core/shared_prefs/shared_prefs.dart';
import 'UI/Screens/login/login.dart';
import 'UI/Screens/main_screen/bloc/bloc_observer.dart';
import 'UI/Screens/main_screen/main_screen.dart';
import 'UI/Screens/onbording/onbording.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'data/models/notifications/notifications_model.dart';
import 'helper/PusherHelper.dart';
import 'package:pusher_client/pusher_client.dart';

Future<bool?> checkAndRequestPermission({bool? background}) async {
  var status = await Permission.location.status;

  if (status.isDenied) {
    // Location permission is denied, request permission
    var result = await Permission.location.request();

    if (result == PermissionStatus.granted) {
      // Location permission granted
      return true;
    } else {
      // Location permission denied by the user
      // You can display a message or UI to inform the user to enable location
      return false;
    }
  } else {
    // Location permission is already granted
    return true;
  }
}

Future<Location?> GetMyLocation() async {
  bool? checkPermission = await checkAndRequestPermission();
  if (checkPermission != null && checkPermission) {
    const timeLimit = Duration(seconds: 20);
    return await FlLocation.getLocation(timeLimit: timeLimit)
        .onError((error, stackTrace) {
      print('error: ${error.toString()}');
      return error as Location;
    });
  } else {
    print("Error in My Location");
    return null;
  }
}

final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

// Initialize the Firebase SDK
Future<void> _initFirebaseMessaging() async {
  await firebaseMessaging.getToken().then((token) {
    print("----------------------------------------------------------------");
    print("token is $token");
    print("----------------------------------------------------------------");

    DIManager.findDep<SharedPrefs>().setDeviceToken(token);
  });
  // Request permission to receive notifications
  NotificationSettings settings = await firebaseMessaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
}

// Handle the received notification when the app is in the background
Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  // ...
  print("mymessage" + message.data["notification"].toString());
  final json = jsonDecode(message.data["notification"].toString());
  final notification = ItemsNotificationsModel.fromJson(json);
  print(notification.type.toString());

  // if (notification.type == "Evaluation User" ||
  //     notification.type  == "Follow") {
  //   DIManager.findNavigator().pushNamed(ClientAccountPage.routeName,
  //       arguments: int.parse(notification.user_id.toString()) );
  // }
  // else if(
  // notification.type == "Approve Ad" ||
  //     notification.type == "Add Ad" ||
  //     notification.type == "Evaluation Ad" ||
  //     notification.type  == "Like"
  // ){
  //   DIManager.findNavigator().pushNamed(
  //     ItemsDetailsPage.routeName,
  //     arguments: ItemsArgs(
  //       id: int.parse(notification.ad_id.toString()),
  //     ),
  //   );
  // }
}

// Set up a notification listener
void _configureFirebaseMessaging() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // // Handle the received notification when the app is in the foreground

    print("mymessage" + message.data["notification"].toString());
    final json = jsonDecode(message.data["notification"].toString());
    final notification = ItemsNotificationsModel.fromJson(json);
    print(notification.type.toString());
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Handle the received notification when the app is in the background

    print("mymessage" + message.data["notification"].toString());
    final json = jsonDecode(message.data["notification"].toString());
    final notification = ItemsNotificationsModel.fromJson(json);
    print(notification.type.toString());

    // if (notification.type == "Evaluation User" ||
    //     notification.type  == "Follow") {
    //   DIManager.findNavigator().pushNamed(ClientAccountPage.routeName,
    //       arguments: int.parse(notification.user_id.toString()) );
    // }
    //
    // else if(
    // notification.type == "Approve Ad" ||
    //     notification.type == "Add Ad" ||
    //     notification.type == "Evaluation Ad" ||
    //     notification.type  == "Like"
    // ){
    //   DIManager.findNavigator().pushNamed(
    //     ItemsDetailsPage.routeName,
    //     arguments: ItemsArgs(
    //       id: int.parse(notification.ad_id.toString()),
    //     ),
    //   );
    // }
    // ...
  });

  FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
}

void main() async {
  await GetStorage.init();
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DIManager.initDI();
  await DIManager.setUpLocator();
  await _initFirebaseMessaging();

  FirebaseMessaging.onMessage.listen((event) {
    print('trueeee');
  }).onError((error) {
    print(error.toString());
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('trueeee');
  }).onError((error) {
    print(error.toString());
  });

  Location? getMyLocation = await GetMyLocation();
  DIManager.findDep<SharedPrefs>().setMyLocationLat(getMyLocation!.latitude);
  DIManager.findDep<SharedPrefs>().setMyLocationLang(getMyLocation.longitude);

  _configureFirebaseMessaging();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());

  @override
  void initState() {
    PusherHelper().initalize();
    if (Platform.isAndroid) {
      // Code for Android devices
      print('This is an Android device.');
      DIManager.findDep<SharedPrefs>().setDeviceType("android");
    } else if (Platform.isIOS) {
      // Code for iOS devices
      print('This is an iOS device.');
      DIManager.findDep<SharedPrefs>().setDeviceType("ios");
    } else {
      // Code for other devices
      print('This is not an Android or iOS device.');
      DIManager.findDep<SharedPrefs>().setDeviceType("iphone");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GetStorage _prefs = GetStorage();
    bool isFirst() {
      // DIManager.findDep<SharedPrefs>().setIsFirst(false);
      if (DIManager.findDep<SharedPrefs>().getIsFirst() == true) {
        return true;
      }
      return false;
    }

    bool isLogin() {
      // DIManager.findDep<SharedPrefs>().setToken(null);
      if (DIManager.findDep<SharedPrefs>().getToken() == null) {
        return false;
      }
      return true;
    }

// print(DIManager.findDep<SharedPrefs>().getToken());
    bool _showOnboarding = true;
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          Provider<LanguageStore>(create: (_) => _languageStore),
          BlocProvider(
            create: (BuildContext context) {
              return AppCubitMainPage()
                ..getAllCategories()
                ..getBestStables()
                ..getAllStables()
                ..getAllBooking();
            },
          ),
        ],
        child: BlocConsumer<AppCubitMainPage, AppCubitMainPageStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return ScreenUtilInit(
              useInheritedMediaQuery: true,
              designSize: Size(376, 812),
              minTextAdapt: true,
              splitScreenMode: false,
              child: MaterialApp(
                  title: '7RM',
                  locale: Locale(_languageStore.locale),
                  supportedLocales: _languageStore.supportedLanguages
                      .map(
                          (language) => Locale(language.locale!, language.code))
                      .toList(),
                  localizationsDelegates: [
                    // A class which loads the translations from JSON files
                    AppLocalizations.delegate,
                    // Built-in localization of basic text for Material widgets
                    GlobalMaterialLocalizations.delegate,
                    // Built-in localization for text direction LTR/RTL
                    GlobalWidgetsLocalizations.delegate,
                    // Built-in localization of basic text for Cupertino widgets
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(),
                  home: isFirst() && !isLogin()
                      ? Onbording()
                      : isLogin()
                          ? MainScreen()
                          : LoginW()
                  // home: MainScre en(),
                  ),
            );
          },
        ),
      );

      // return MaterialApp(
      //   title: '7RM',
      //   debugShowCheckedModeBanner: false,
      //   theme: ThemeData(),
      //   home: isFirst() ? Onbording() :isLogin()?MainScreen():LoginW()
      //   // home: MainScreen(),
      // );
    });
  }
}
