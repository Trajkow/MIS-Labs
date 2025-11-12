import 'package:flutter/material.dart';
import 'package:mis_lab01/models/exam.dart';
import 'package:mis_lab01/widgets/exam-card.dart';
import 'exam-detail-screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Exam> exams = [
    Exam(
      subjectName: 'Оперативни системи',
      dateTime: DateTime(2025, 12, 15, 9, 0),
      rooms: ['A1', 'A2'],
    ),
    Exam(
      subjectName: 'Дискретна математика',
      dateTime: DateTime(2025, 12, 17, 11, 0),
      rooms: ['B3'],
    ),
    Exam(
      subjectName: 'Бизнис и статистика',
      dateTime: DateTime(2025, 1, 20, 9, 0),
      rooms: ['C2'],
    ),
    Exam(
      subjectName: 'Интернет технологии',
      dateTime: DateTime(2025, 1, 22, 12, 0),
      rooms: ['D1'],
    ),
    Exam(
      subjectName: 'Дизајн на интеракција човек-компјутер',
      dateTime: DateTime(2025, 1, 25, 10, 0),
      rooms: ['E3'],
    ),
    Exam(
      subjectName: 'Алгоритми и структури на податоци',
      dateTime: DateTime(2025, 1, 28, 9, 30),
      rooms: ['A4'],
    ),
    Exam(
      subjectName: 'Објектно ориентирано програмирање',
      dateTime: DateTime(2025, 2, 1, 8, 30),
      rooms: ['B2'],
    ),
    Exam(
      subjectName: 'Компјутерски мрежи',
      dateTime: DateTime(2025, 2, 3, 10, 0),
      rooms: ['C1'],
    ),
    Exam(
      subjectName: 'Веб дизајн',
      dateTime: DateTime(2025, 2, 6, 9, 0),
      rooms: ['D2'],
    ),
    Exam(
      subjectName: 'Архитектура на компјутери',
      dateTime: DateTime(2025, 2, 10, 8, 0),
      rooms: ['E1'],
    ),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    exams.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Raspored za ispiti - 221274'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: ListView.builder(
        itemCount: exams.length,
        itemBuilder: (context, i) {
          final exam = exams[i];
          return ExamCard(
            exam: exam,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExamDetailScreen(exam: exam),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Vkupno ispiti ${exams.length}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
