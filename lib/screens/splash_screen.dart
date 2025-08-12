import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Check authentication status after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      _checkAuthAndNavigate();
    });
  }

  void _checkAuthAndNavigate() {
    final authService = Provider.of<AuthService>(context, listen: false);
    
    if (authService.isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/images/logo_mobile.svg', 
              height: 120,
              width: 120,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.temple_hindu,
                  size: 80,
                  color: Colors.white,
                );
              },
            ),
            const SizedBox(height: 24),
            // App name
            const Text(
              'PujaKaro',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 48),
            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
} 