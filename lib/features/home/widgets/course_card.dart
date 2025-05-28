import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onPressed;
  final bool isInProgress;
  final String? imagePath;

  const CourseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onPressed,
    this.isInProgress = false,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isInProgress
        ? Color.alphaBlend(Colors.black.withValues(alpha: 0.1), color)
        : color;

    return Stack(
      children: [
        Container(
          height: 180,
          width: MediaQuery.of(context).size.width - 60,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: bgColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 24, fontFamily: 'myFirstFont'),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              isInProgress
                  ? const Text(
                      'Jarayonda',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      onPressed: onPressed,
                      child: Text(
                        'Boshlash',
                        style: TextStyle(
                          color: Colors.deepOrange.withValues(alpha: 0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 30,
          child: imagePath != null
              ? Image.asset(
                  imagePath ?? "",
                  fit: BoxFit.cover,
                  height: 80,
                  width: 80,
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}
