import 'package:flutter/material.dart';
import 'bill_uploader_card.dart';
import 'chat_agent_card.dart';
import 'recurring_payments_card.dart';

void main() {
  runApp(const FinBroApp());
}

class FinBroApp extends StatelessWidget {
  const FinBroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinBro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A list of all our main widgets
    final List<Widget> cards = [
      const BillUploaderCard(),
      const ChatAgentCard(),
      const RecurringPaymentsCard(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FinBro - Your Financial Co-Pilot'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            // For wide screens, use a responsive grid
            return GridView.count(
              crossAxisCount: 2, // You can change this to 3 if you have more cards
              childAspectRatio: 1.8, // Adjust aspect ratio to prevent long cards
              padding: const EdgeInsets.all(8.0),
              children: cards,
            );
          } else {
            // For narrow screens, use a simple vertical list
            return ListView(
              padding: const EdgeInsets.all(8.0),
              children: cards,
            );
          }
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
    );
  }
}