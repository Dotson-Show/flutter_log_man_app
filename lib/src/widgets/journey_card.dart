// lib/src/widgets/journey_card.dart
import 'package:flutter/material.dart';
import '../models/journey.dart';

class JourneyCard extends StatelessWidget {
  final Journey journey;
  final VoidCallback? onTap;

  const JourneyCard({super.key, required this.journey, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        onTap: onTap,
        title: Text('${journey.origin} → ${journey.destination}'),
        subtitle: Text('Status: ${journey.status} • ${journey.transportType}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(journey.createdAt.toLocal().toString().split(' ').first),
            const SizedBox(height: 4),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
