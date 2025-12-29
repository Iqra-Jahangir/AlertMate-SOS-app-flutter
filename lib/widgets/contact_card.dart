import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/contact.dart';
import '../utils/colors.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;
  final VoidCallback onDelete;

  const ContactCard({
    super.key,
    required this.contact,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: AppColors.buttonColor,
          child: Text(
            contact.name[0].toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          contact.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(contact.number),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.call, color: Colors.green),
              onPressed: () async {
                final uri = Uri(scheme: 'tel', path: contact.number);
                await launchUrl(uri);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
