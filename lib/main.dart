import './library.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  PushNotificationService().initialize();
   await GetStorage.init();
  await NotificationService().initNotification();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
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
        'orderDetail': (BuildContext context) => OrderDetailScreen(),
        'equipmentsPage': (BuildContext context) => EquipmentsListWidget(),
        'equipmentsDetails': (BuildContext context) => EquipmentDetailsPage(),
        'addEquipmentsDetails': (BuildContext context) =>
            AddEquipmentDetailsPage(),
      },
      initialRoute: "Splash",
    );
  }
}
