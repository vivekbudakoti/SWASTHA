import 'package:flutter/material.dart';

class CircularLoginOption extends StatelessWidget {
  const CircularLoginOption({Key? key, required this.icon, required this.onTap})
      : super(key: key);

  final Image icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.scaleDown, image: icon.image))),
        ),
      ),
    );
  }
}
