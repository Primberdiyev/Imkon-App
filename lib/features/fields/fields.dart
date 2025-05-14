import 'package:flutter/material.dart';
import 'package:imkon/features/home/widgets/course_card.dart';

class Fields extends StatelessWidget {
  const Fields({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 100, right: 25, left: 25),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Dilshodbek',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.notifications),
          ],
        ),
        CourseCard(
          title: 'Bepul Matematika Kursi',
          subtitle: "Matematikani tez, oson va\nsamarali o'rganing",
          color: const Color(0xFFFFF599),
          onPressed: () {},
        ),
        CourseCard(
          title: 'Intensiv Ona Tili Kursi',
          subtitle: "Ona tilini o'rganing va\nyangi yo'llarni kashf eting",
          color: const Color(0xFF9EFFFF),
          onPressed: () {},
        ),
        CourseCard(
          isInProgress: true,
          title: 'Moslashtirilgan Ingliz Tili',
          subtitle: "Ingliz tilini o'yin o'ynab o'rganing",
          color: const Color(0xFF91F48F).withValues(alpha: 0.2),
          onPressed: () {},
        ),
        CourseCard(
          isInProgress: true,
          title: 'Zamonaviy Axborot Texnologiyalari kursi',
          subtitle: "Ingliz tilini o'yin o'ynab o'rganing",
          color: const Color(0xFF91F48F).withValues(alpha: 0.2),
          onPressed: () {},
        ),
      ],
    );
  }
}
