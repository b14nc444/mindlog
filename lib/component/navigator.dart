import 'package:flutter/material.dart';
import 'package:mindlog_app/const/visual.dart';

class renderBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  renderBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: secondaryColor1,
      selectedItemColor: primaryColor,
      // unselectedIconTheme,
      selectedFontSize: 12.0,
      // this.unselectedFontSize = 12.0,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/union.png'),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/document.png'),
          label: '모아보기',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/stats.png'),
          label: '통계',
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
