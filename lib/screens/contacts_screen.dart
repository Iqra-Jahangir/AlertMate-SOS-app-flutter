import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors.dart';
import '../models/contact.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Center(child: Text("Login required"));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addContactDialog,
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('contacts')
            .orderBy('createdAt')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No contacts added'));
          }

          final contacts = snapshot.data!.docs.map((doc) {
            return Contact(
              id: doc.id,
              name: doc['name'],
              number: doc['number'],
            );
          }).toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return Card(
                child: ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.number),
                  trailing: IconButton(
                    icon: const Icon(Icons.call, color: AppColors.buttonColor),
                    onPressed: () async {
                      final uri = Uri.parse('tel:${contact.number}');
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _addContactDialog() {
    final nameController = TextEditingController();
    final numberController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: numberController,
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isEmpty ||
                  numberController.text.isEmpty) return;

              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .collection('contacts')
                  .add({
                'name': nameController.text,
                'number': numberController.text,
                'createdAt': FieldValue.serverTimestamp(),
              });

              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
