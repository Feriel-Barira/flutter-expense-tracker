import 'package:flutter/material.dart';
import 'package:flutter_app/models/contact_info_model.dart';
import 'package:flutter_app/pages/contact_info.dart';
import 'package:provider/provider.dart';

class ContactListWidget extends StatelessWidget {
  const ContactListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactInfoModel>(
      builder: (context, model, child) {
        final contacts = model.contacts;
        if (contacts.isEmpty) {
          return const Center(child: Text('Aucun contact'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: contacts.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final ContactInfo c = contacts[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(c.image),
                onBackgroundImageError: (_, __) {},
                backgroundColor: Colors.grey[200],
              ),
              title: Text(c.username),
              subtitle: Text(c.phone),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // confirmation dialog
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Supprimer le contact'),
                      content: Text('Supprimer ${c.username} ?'),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text('Annuler')),
                        TextButton(
                          onPressed: () {
                            model.removeContactAt(index);
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('Supprimer'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              onTap: () {
                // Optionnel : ouvrir page de détails
              },
            );
          },
        );
      },
    );
  }
}
