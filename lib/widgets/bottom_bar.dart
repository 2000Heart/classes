import 'clipped_view.dart';
import 'bottom_bar_button.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final ValueChanged<int> onTap;
  final int currentIndex;
  final List<BottomBarItemData> items;

  const BottomBar({super.key, required this.items, required this.onTap, this.currentIndex = 0});

  BottomBarItemData? get selectedItem => currentIndex >= 0 && currentIndex < items.length ? items[currentIndex] : null;

  @override
  Widget build(BuildContext context) {
    List<Widget> buttonWidgets = items.map((data) {
      return NavbarButton(data, data == selectedItem, onTap: () {
        var index = items.indexOf(data);
        onTap(index);
      });
    }).toList();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 16, color: Colors.black12),
          BoxShadow(blurRadius: 24, color: Colors.black12),
        ],
      ),
      alignment: Alignment.center,
      height: 80,
      child: ClippedView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buttonWidgets,
        ),
      ),
    );
  }
}

class BottomBarItemData {
  final String title;
  final IconData icon;
  final List<Color> selectedColor;
  final double width;

  BottomBarItemData({required this.title, required this.icon, required this.width, required this.selectedColor});
}
