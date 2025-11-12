import 'package:flutter/material.dart';
import 'package:mis_lab01/models/exam.dart';
import 'package:intl/intl.dart';

class ExamDetailScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailScreen({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final diff = exam.dateTime.difference(now);
    final remainingDays = diff.inDays;
    final remainingHours = diff.inHours % 24;

    final formattedDate = DateFormat('dd.MM.yyyy').format(exam.dateTime);
    final formattedTime = DateFormat('HH:mm').format(exam.dateTime);

    return Scaffold(
      appBar: AppBar(
        title: Text(exam.subjectName),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exam.subjectName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 8),
                    Text('Datum: $formattedDate'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time),
                    const SizedBox(width: 8),
                    Text('Vreme: $formattedTime')
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(width: 8),
                    Text('Prostorii: ${exam.rooms.join(', ')}'),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                    exam.dateTime.isAfter(now)
                        ? 'Preostanato vreme: $remainingDays dena, $remainingHours casa'
                        : 'Ispitot e veke pominat.',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
