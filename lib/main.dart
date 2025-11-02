import 'package:flutter/material.dart';
import 'package:fourthapp/widgets/expenses.dart';
// import 'package:flutter/services.dart';

// ColorScheme is used to set a color scheme for different widgets in entire app and .fromseed sets a scheme based on a single color for the entire app
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

// for dark theme
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness:
      Brightness.dark, // to tell flutter that this Scheme is for dark mode
  seedColor: Color.fromARGB(255, 5, 99, 125),
);

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); // to ensure below orientation locking code works properly
  // // to lock device orientation using SystemChrome provided by services.dart package
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
  //   fn,
  // ) {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: CardThemeData().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      // ThemeData is best for setting theme to the app as an overall
      // .copyWith() → keep everything else the same, just tweak this.
      theme: ThemeData().copyWith(
        // scaffoldBackgroundColor: const Color.fromARGB(255, 187, 158, 238),
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: CardThemeData().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        ),
        // there is no .copyWith method for elevatedButtonTheme so .stylefrom is used for same effect
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
      ),
      home: Expenses(),
      themeMode: ThemeMode.system,
    ),
  );
  // });
}
