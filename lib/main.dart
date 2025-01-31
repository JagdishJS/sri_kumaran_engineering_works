import 'package:sri_kumaran_engineering_works/screens/orders.dart';

import './library.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        'sampleInvoice': (BuildContext context) => SampleInvoicePage(),
        'ordersPage': (BuildContext context) => OrdersPage(),
      },
      initialRoute: "Splash",
    );
  }
}
