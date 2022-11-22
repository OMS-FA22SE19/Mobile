// ignore_for_file: prefer_const_constructors, avoid_print
import 'dart:io';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:oms_mobile/firebase_options.dart';
import 'package:oms_mobile/locale_string.dart';
import 'Login/login_page.dart';
import 'package:get/get.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  String userId = "c3adacd4-324f-428f-bbef-5bf4f1e24501";
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message.data}');

  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}');
  //   } else {
  //     print("check main.dart");
  //   }
  // }

  // );

  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  // RemoteService().postFCMtoken(userId, fcmToken.toString());

  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    // If necessary send token to application server.
    print('Your fcmToken : $fcmToken');
    // Note: This callback is fired at each app startup and whenever a new
    // token is generated.
  }).onError((err) {
    print("check main.dart");
  });

  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      locale: Locale('en', 'US'),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginScreen(),
    );
  }
}

// class _MyAppState extends State<MyApp> {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       translations: LocaleString(),
//       locale: Locale('en', 'US'),
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       // supportedLocales: const [
//       //   Locale('en', ''),
//       //   Locale('vi', ''),
//       // ],
//       // localizationsDelegates: const [
//       //   AppLocalizations.delegate,
//       //   GlobalMaterialLocalizations.delegate,
//       //   GlobalWidgetsLocalizations.delegate,
//       //   GlobalCupertinoLocalizations.delegate,
//       // ],
//       // localeResolutionCallback: (locale, supportedLocales) {
//       //   for (var supportedLocale in supportedLocales) {
//       //     if (supportedLocale.languageCode == locale.languageCode &&
//       //         supportedLocale.countryCode == locale.countryCode) {
//       //       return supportedLocale;
//       //     }
//       //   }
//       //   return supportedLocales.first;
//       // },
//       home: loginScreen(),
//     );
//     // BlocProvider<LanguageCubit>(
//     //   create: (context) => LanguageCubit(context),
//     //   child: BlocBuilder<LanguageCubit, Locale?>(builder: (context, locale) {
//     //     return
//     //   }),
//     // );
//   }
// }
