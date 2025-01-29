import './library.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> appNavigateKey = GlobalKey<NavigatorState>();

  final GlobalKey<ScaffoldMessengerState> appScaffoldMessKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sri Kumaran Engineering Works',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      initialBinding: GlobalBinding(),
      scaffoldMessengerKey: appScaffoldMessKey,
      navigatorKey: appNavigateKey,
      routes: <String, WidgetBuilder>{
        'splashScreen': (BuildContext context) => const SplashScreen(),
        'dashboard': (BuildContext context) => DashboardScreen(),
      },
      initialRoute: "Splash",
    );
  }
}
