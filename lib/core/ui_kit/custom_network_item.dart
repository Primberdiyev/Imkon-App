import 'package:flutter/material.dart';

class CustomNetworkItem extends StatelessWidget {
  final String imagePath;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomNetworkItem({
    super.key,
    required this.imagePath,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        margin: const EdgeInsets.symmetric(vertical: 15),
        height: 65,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isSelected ? Colors.purple : const Color(0xFFAAB0B7),
            width: 2,
          ),
          color: isSelected ? Color(0xFFFFD700) : Colors.white,
        ),
        child: Row(
          children: [
            Image.asset(imagePath, height: 50, width: 50),
            const SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'myFirstFont',
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
