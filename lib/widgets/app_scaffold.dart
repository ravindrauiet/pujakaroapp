import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/cart_service.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final int currentIndex;
  final bool showAppBar;
  final bool showBottomNav;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool extendBodyBehindAppBar;
  final Color? backgroundColor;
  final PreferredSizeWidget? customAppBar;

  const AppScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.currentIndex = 0,
    this.showAppBar = true,
    this.showBottomNav = true,
    this.actions,
    this.floatingActionButton,
    this.extendBodyBehindAppBar = false,
    this.backgroundColor,
    this.customAppBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context);
    final authService = Provider.of<AuthService>(context);
    
    return Scaffold(
      appBar: showAppBar 
        ? customAppBar ?? _buildAppBar(context, cartService, authService) 
        : null,
      body: body,
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      bottomNavigationBar: showBottomNav ? _buildBottomNav(context) : null,
      floatingActionButton: floatingActionButton,
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context, 
    CartService cartService,
    AuthService authService
  ) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF8B0000),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0.5,
      leading: Navigator.canPop(context)
        ? IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF8B0000)),
            onPressed: () => Navigator.pop(context),
          )
        : null,
      actions: actions ?? [
        IconButton(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.search, color: Color(0xFF5F4B32)),
              if (authService.unreadCount > 0)
                Positioned(
                  right: -5,
                  top: -5,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      authService.unreadCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          onPressed: () {
            _showSearchDialog(context);
          },
        ),
        IconButton(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.shopping_cart, color: Color(0xFF5F4B32)),
              if (cartService.itemCount > 0)
                Positioned(
                  right: -5,
                  top: -5,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFB9548),
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      cartService.itemCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
      ],
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onNavTap(index, context),
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF8B0000),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: 'Shop',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.celebration),
          label: 'Puja',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: 'Blog',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  void _onNavTap(int index, BuildContext context) {
    if (currentIndex == index) return;
    
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/shop');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/puja-booking');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/blog');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Search'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
} 