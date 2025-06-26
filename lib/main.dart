import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/shop_screen.dart';
import 'screens/puja_booking_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/blog_screen.dart';
import 'screens/astrology/daily_horoscope_screen.dart';
import 'screens/astrology/birth_chart_screen.dart';
import 'screens/about_us_screen.dart';
import 'screens/contact_screen.dart';
import 'services/cart_service.dart';
import 'services/data_service.dart';
import 'services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartService()),
        ChangeNotifierProvider(create: (_) => DataService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'PujaKaro',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF8B0000),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF8B0000),
            primary: const Color(0xFF8B0000),
            secondary: const Color(0xFFFB9548),
            tertiary: const Color(0xFF317BEA),
          ),
          scaffoldBackgroundColor: const Color(0xFFFCF7F1),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFB9548),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/home': (context) => const HomeScreen(),
          '/shop': (context) => const ShopScreen(),
          '/puja-booking': (context) => const PujaBookingScreen(),
          '/product-detail': (context) => const ProductDetailScreen(),
          '/cart': (context) => const CartScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/blog': (context) => const BlogScreen(),
          '/daily-horoscope': (context) => const DailyHoroscopeScreen(),
          '/birth-chart': (context) => const BirthChartScreen(),
          '/about-us': (context) => const AboutUsScreen(),
          '/contact': (context) => const ContactScreen(),
        },
      ),
    );
  }
}
