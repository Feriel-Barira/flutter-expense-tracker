import 'package:flutter/material.dart';
import 'package:flutter_app/models/contact_info_model.dart';
import 'package:flutter_app/pages/contact_info.dart';
import 'package:provider/provider.dart';

class ContactFormWidget extends StatefulWidget {
  const ContactFormWidget({super.key});
  @override
  State<ContactFormWidget> createState() => _ContactFormWidgetState();
}

class _ContactFormWidgetState extends State<ContactFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _imageCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _imageCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final newContact = ContactInfo(
      _nameCtrl.text.trim(),
      _phoneCtrl.text.trim(),
      _imageCtrl.text.trim().isEmpty
          ? 'https://picsum.photos/120/120'
          : _imageCtrl.text.trim(),
    );
    Provider.of<ContactInfoModel>(context, listen: false)
        .addContact(newContact);
    // clear form
    _nameCtrl.clear();
    _phoneCtrl.clear();
    _imageCtrl.clear();
    // feedback
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contact ajouté')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Nom'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nom requis' : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _phoneCtrl,
              decoration: const InputDecoration(labelText: 'Téléphone'),
              keyboardType: TextInputType.phone,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Téléphone requis' : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _imageCtrl,
              decoration:
                  const InputDecoration(labelText: 'URL image (optionnel)'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.add),
                  label: const Text('Ajouter'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Vider les champs
                    _nameCtrl.clear();
                    _phoneCtrl.clear();
                    _imageCtrl.clear();
                    // Feedback optionnel
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Champs vidés')),
                    );
                  },
                  icon: const Icon(Icons.clear),
                  label: const Text('Vider'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
