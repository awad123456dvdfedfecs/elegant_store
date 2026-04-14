import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/app_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const EleganceStoreApp());
}

class EleganceStoreApp extends StatelessWidget {
  const EleganceStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MaterialApp(
        title: 'ELEGANCE',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: GoogleFonts.tajawal().fontFamily,
          primaryColor: const Color(0xFF0A0A0A),
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF0A0A0A),
            secondary: Color(0xFFC9A84C),
            surface: Color(0xFFF9F9F9),
            background: Colors.white,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: Color(0xFF0A0A0A)),
            titleTextStyle: TextStyle(
              color: Color(0xFF0A0A0A),
              fontSize: 22,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          textTheme: TextTheme(
            displayLarge: GoogleFonts.tajawal(fontSize: 36, fontWeight: FontWeight.w700),
            displayMedium: GoogleFonts.tajawal(fontSize: 30, fontWeight: FontWeight.w600),
            displaySmall: GoogleFonts.tajawal(fontSize: 26, fontWeight: FontWeight.w500),
            headlineMedium: GoogleFonts.tajawal(fontSize: 22, fontWeight: FontWeight.w600),
            titleLarge: GoogleFonts.tajawal(fontSize: 20, fontWeight: FontWeight.w600),
            bodyLarge: GoogleFonts.tajawal(fontSize: 16, fontWeight: FontWeight.normal),
            bodyMedium: GoogleFonts.tajawal(fontSize: 14, fontWeight: FontWeight.normal),
          ),
        ),
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },
        home: const SplashScreen(),
      ),
    );
  }
}