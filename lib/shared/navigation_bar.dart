import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  final List<Widget> screens;
  final List<BottomNavigationBarItem> navItems;

  const MainLayout({
    super.key,
    required this.screens,
    required this.navItems,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.screens.length == widget.navItems.length);

    const Color itemColor = Color(0xFFD1B072);
    const TextStyle itemTextStyle = TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
      color: itemColor,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF3D3D3D),
      body: widget.screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFF3D3D3D),
        type: BottomNavigationBarType.fixed,

        showSelectedLabels: false,
        showUnselectedLabels: false,

        items: List.generate(widget.navItems.length, (index) {
          final originalItem = widget.navItems[index];

          return BottomNavigationBarItem(
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(originalItem.label!, style: itemTextStyle),
                const SizedBox(height: 4),
                Container(
                  height: 2.5,
                  width: 70,
                  color: itemColor,
                ),
              ],
            ),
            

            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(originalItem.label!, style: itemTextStyle),
                const SizedBox(height: 4),
                Container(height: 2.5),
              ],
            ),

            label: '',
          );
        }),
      ),
    );
  }
}