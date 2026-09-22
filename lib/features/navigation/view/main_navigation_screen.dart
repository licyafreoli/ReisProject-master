import 'package:flutter/material.dart';
import 'package:reis_project/features/communication/view/communication_screen.dart';
import 'package:reis_project/features/home/model/user_type.dart';
import 'package:reis_project/features/home/view/home_screen.dart';
import 'package:reis_project/features/processes/view/process_screen.dart';
import 'package:reis_project/features/profile/view/profile_screen.dart';
import 'package:reis_project/shared/colors.dart';

class MainNavigationScreen extends StatefulWidget {
  final bool? isClient;
  final UserType? userType;

  const MainNavigationScreen(
      {this.isClient = true, this.userType = UserType.client, super.key});

  @override
  MainNavigationScreenState createState() => MainNavigationScreenState();
}

class MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  bool _isClient() {
    return widget.isClient! && widget.userType! == UserType.client;
  }

  List<Widget> get _pages {
    return [
      HomeScreen(userType: widget.userType!),
      ProcessScreen(isClient: widget.isClient),
      ProfileScreen(isClient: widget.isClient),
      const CommunicationScreen()
    ];
  }

  void _onItemTapped(int index) {
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
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.work_outline_rounded),
            activeIcon: const Icon(Icons.work_rounded),
            label: widget.isClient! ? 'Processos' : 'Clientes',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: 'Perfil',
          ),
          if (!_isClient()) ...[
            const BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              activeIcon: Icon(Icons.chat),
              label: 'Comunicação',
            ),
          ]
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: _isClient() ? kSoftGold : kPrimaryColor,
        selectedItemColor: _isClient() ? kPrimaryColor : kSoftGold,
        unselectedItemColor: _isClient() ? kPrimaryColor : kSoftGold,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
