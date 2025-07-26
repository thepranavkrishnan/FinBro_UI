import 'package:flutter/material.dart';

// Data model for a recurring payment
class RecurringPayment {
  final String name;
  final double amount;
  final String dueDateInfo;
  final IconData icon;

  // THE FIX IS HERE: We added 'const' to the constructor.
  const RecurringPayment({
    required this.name,
    required this.amount,
    required this.dueDateInfo,
    required this.icon,
  });
}

class RecurringPaymentsCard extends StatelessWidget {
  const RecurringPaymentsCard({super.key});

  // Dummy data for the demo
  // AND THE FIX IS HERE: We added 'const' before each object.
  final List<RecurringPayment> _payments = const [
    const RecurringPayment(name: 'Netflix Subscription', amount: 15.99, dueDateInfo: 'Due on the 28th', icon: Icons.movie),
    const RecurringPayment(name: 'Spotify Premium', amount: 9.99, dueDateInfo: 'Due on the 15th', icon: Icons.music_note),
    const RecurringPayment(name: 'Gym Membership', amount: 45.00, dueDateInfo: 'Due on the 1st', icon: Icons.fitness_center),
    const RecurringPayment(name: 'Rent', amount: 1200.00, dueDateInfo: 'Due on the 1st', icon: Icons.home),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2.0,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.event_repeat_outlined),
            title: Text('Recurring Payments', style: Theme.of(context).textTheme.titleLarge),
            subtitle: const Text('Your monthly subscriptions & bills'),
            trailing: IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {
                // TODO: Show a dialog or navigate to a new screen to add a payment
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add new recurring payment (Demo)')),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: _payments.length,
              itemBuilder: (context, index) {
                final payment = _payments[index];
                return ListTile(
                  leading: Icon(payment.icon, color: Theme.of(context).colorScheme.primary),
                  title: Text(payment.name),
                  subtitle: Text(payment.dueDateInfo),
                  trailing: Text(
                    '\$${payment.amount.toStringAsFixed(2)}', // Assuming USD for demo
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}