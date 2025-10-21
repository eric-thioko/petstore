import 'package:flutter/material.dart';
import 'package:petstore/presentation/cart/cart_page.dart';
import 'package:petstore/presentation/home/home_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  final GlobalKey<HomePageState> _homePageKey = GlobalKey<HomePageState>();
  final GlobalKey<CartPageState> _cartPageKey = GlobalKey<CartPageState>();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(key: _homePageKey),
      CartPage(key: _cartPageKey),
    ];
  }

  void _onItemTapped(int index) {
    // Refresh home page when switching back to home tab
    if (index == 0 && _selectedIndex != 0) {
      _homePageKey.currentState?.refreshPets();
    }

    // Refresh cart page when switching to cart tab
    if (index == 1 && _selectedIndex != 1) {
      _cartPageKey.currentState?.refreshCart();
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
