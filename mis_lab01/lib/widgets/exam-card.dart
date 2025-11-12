import 'package:flutter/material.dart';
import 'package:mis_lab01/models/exam.dart';
import 'package:intl/intl.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;
  final VoidCallback onTap;

  const ExamCard({super.key, required this.exam, required this.onTap});

  @override
  Widget build(BuildContext context) {

    final now = DateTime.now();
    final isPast = exam.dateTime.isBefore(now);
    final formattedDate = DateFormat('dd.MM.yyyy').format(exam.dateTime);
    final formattedTime = DateFormat('HH:mm').format(exam.dateTime);

    return Card(
      color: isPast ? Colors.grey[300] : Colors.lightBlue[100],
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        title: Text(
          exam.subjectName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 6),
                Text('$formattedDate - $formattedTime'),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 6),
                Text(exam.rooms.join(', ')),
              ],
            ),
          ],
        ),
        trailing: Icon(
          isPast ? Icons.check_circle : Icons.access_time,
          color: isPast ? Colors.green : Colors.orange,
        ),
      ),
    );
  }
}
