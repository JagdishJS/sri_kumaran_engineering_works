import '../library.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: createMaterialColor(spearmint),
    primaryColor: whiteColor,
    scaffoldBackgroundColor: whiteColor,
    fontFamily: 'Comfortaa',
    buttonTheme: ButtonThemeData(
      buttonColor: celodon, // Default button color
      textTheme: ButtonTextTheme.primary, // Button text color
    ),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: blackColor),
    iconTheme: IconThemeData(color: blackColor),
    textTheme: TextTheme(
      displaySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: blackColor,
          letterSpacing: 1),
      displayMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: blackColor,
          letterSpacing: 1),
      displayLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: blackColor,
          letterSpacing: 1),
      bodySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: blackColor,
          letterSpacing: 1.2),
      bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: blackColor,
          letterSpacing: 1.2),
      bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: blackColor,
          letterSpacing: 1.4),
      labelSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: blackColor,
          letterSpacing: 1),
      labelMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: blackColor,
          letterSpacing: 1),
      labelLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: blackColor,
          letterSpacing: 1),
      titleSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: blackColor,
          letterSpacing: 1),
      titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: blackColor,
          letterSpacing: 1),
      titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.normal,
          color: blackColor,
          letterSpacing: 1),
    ),
    dialogBackgroundColor: blackColor,
    unselectedWidgetColor: blackColor,
    dividerColor: blackColor,
    cardColor: blackColor,
    dialogTheme: DialogTheme(shape: dialogShape()),
    appBarTheme: AppBarTheme(
      foregroundColor: blackColor,
      backgroundColor: blackColor,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: blackColor),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: celodon,
        shadowColor: green,
        foregroundColor: green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // Set border radius
        ),
      ),
    ),
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: createMaterialColor(spearmint),
    primaryColor: blackColor,
    scaffoldBackgroundColor: blackColor,
    fontFamily: 'Comfortaa',
    buttonTheme: ButtonThemeData(
      buttonColor: celodon, // Default button color
      textTheme: ButtonTextTheme.primary, // Button text color
    ),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: whiteColor),
    iconTheme: IconThemeData(color: whiteColor),
    textTheme: TextTheme(
      displaySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: whiteColor,
          letterSpacing: 1),
      displayMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: whiteColor,
          letterSpacing: 1),
      displayLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: whiteColor,
          letterSpacing: 1),
      bodySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: whiteColor,
          letterSpacing: 1.2),
      bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: whiteColor,
          letterSpacing: 1.2),
      bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: whiteColor,
          letterSpacing: 1.4),
      labelSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: whiteColor,
          letterSpacing: 1),
      labelMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: whiteColor,
          letterSpacing: 1),
      labelLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: whiteColor,
          letterSpacing: 1),
      titleSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: whiteColor,
          letterSpacing: 1),
      titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: whiteColor,
          letterSpacing: 1),
      titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.normal,
          color: whiteColor,
          letterSpacing: 1),
    ),
    dialogBackgroundColor: whiteColor,
    unselectedWidgetColor: Colors.white60,
    dividerColor: Colors.white12,
    cardColor: whiteColor,
    dialogTheme: DialogTheme(shape: dialogShape()),
    appBarTheme: AppBarTheme(
      backgroundColor: whiteColor,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: celodon,
        shadowColor: green,
        foregroundColor: green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // Set border radius
        ),
      ),
    ),
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
