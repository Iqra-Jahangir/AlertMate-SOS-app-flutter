import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors.dart';

class MessageContactsScreen extends StatelessWidget {
  const MessageContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Login required'));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Message Contacts')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('contacts')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No contacts found'));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: snapshot.data!.docs.map((doc) {
              final name = doc['name'];
              final number = doc['number'];

              return Card(
                child: ListTile(
                  title: Text(name),
                  subtitle: Text(number),
                  trailing: IconButton(
                    icon: const Icon(Icons.message,
                        color: AppColors.buttonColor),
                    onPressed: () async {
                      final uri = Uri(
                        scheme: 'sms',
                        path: number,
                        queryParameters: {
                          'body': 'I need help. Please respond.',
                        },
                      );
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      }
                    },
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
