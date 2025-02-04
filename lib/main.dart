import 'package:bhakti_app/config.dart';
import 'package:bhakti_app/screens/home_screen/drawer_screen/layouts/support_us_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'common/languages/app_localizations.dart';
import 'package:bhakti_app/common/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Future.delayed(const Duration(seconds: 2));

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString('bookList');

  if (jsonString != null) {
    List<dynamic> jsonData = jsonDecode(jsonString);
    appArray.localBookList =
        jsonData.map((e) => Map<String, dynamic>.from(e)).toList();
  }
  await Firebase.initializeApp();
  runApp(MyApp(prefs: prefs));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final SharedPreferences? prefs;

  const MyApp({super.key, this.prefs});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return
    // const MaterialApp(
    //   home: SupportUsScreen(),
    // );

    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context1, AsyncSnapshot<SharedPreferences> snapData) {
          if (snapData.hasData) {
            return MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (_) => LoadingProvider()),
                  ChangeNotifierProvider(create: (_) => EmailLoginProvider()),
                  ChangeNotifierProvider(create: (_) => EmailSignUpProvider()),
                  ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
                  ChangeNotifierProvider(create: (_) => SetUpProfileProvider()),
                  ChangeNotifierProvider(create: (_) => LoginAuthProvider()),
                  ChangeNotifierProvider(create: (_) => PhoneLoginProvider()),
                  ChangeNotifierProvider(create: (_) => OtpScreenProvider()),
                  ChangeNotifierProvider(create: (_) => CommonApiProvider()),
                  ChangeNotifierProvider(
                      create: (_) => UpdateProfileProvider()),
                  ChangeNotifierProvider(create: (_) => BottomNavProvider()),
                  ChangeNotifierProvider(create: (_) => SettingProvider()),
                  ChangeNotifierProvider(create: (_) => DashboardProvider()),
                  ChangeNotifierProvider(create: (_) => MonitoringProvider()),
                  ChangeNotifierProvider(create: (_) => SplashScreenProvider()),
                  ChangeNotifierProvider(create: (_) => FirebaseFCMToken()),
                  ChangeNotifierProvider(
                      create: (_) => AppLanguageProvider(prefs)),
                  ChangeNotifierProvider(
                      create: (_) => ThemeService(snapData.data!))
                ],
                child: Consumer3<ThemeService, CommonApiProvider,
                        AppLanguageProvider>(
                    builder: (context2, theme, commonApi, lan, child) {
                  return MaterialApp(
                      title: 'Bhakti App',
                      debugShowCheckedModeBanner: false,
                      theme: AppTheme.fromType(ThemeType.light).themeData,
                      themeMode: ThemeMode.light,
                      initialRoute: "/",
                      routes: appRoute.route,
                      supportedLocales: const [
                        Locale('hi', 'IN'),
                        Locale('en', 'US'),
                        Locale('ru', 'RU')
                      ],
                      localizationsDelegates: const [
                        AppLocalizations.delegate,
                        CountryLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate
                      ],
                      locale: lan.appLocal);
                }));
          } else {
            return MaterialApp(
                theme: AppTheme.fromType(ThemeType.light).themeData,
                themeMode: ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: Container(
                    padding: const EdgeInsets.only(bottom: Insets.i27),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage(eImageAssets.splashBg)))));
          }
        });
  }
}
