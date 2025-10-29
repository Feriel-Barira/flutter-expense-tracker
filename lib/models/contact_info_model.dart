import 'package:flutter/foundation.dart';
import 'package:flutter_app/pages/contact_info.dart';

class ContactInfoModel extends ChangeNotifier {
  final List<ContactInfo> _contacts = [
    ContactInfo("Ali", "94546621", "https://picsum.photos/120/120"),
    ContactInfo("Salah", "66885547", "https://picsum.photos/121/121"),
    ContactInfo("Ons", "78548583", "https://picsum.photos/122/122"),
    ContactInfo("Kais", "45785454", "https://picsum.photos/123/123"),
  ];

  List<ContactInfo> get contacts => List.unmodifiable(_contacts);

  void addContact(ContactInfo contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void removeContactAt(int index) {
    if (index >= 0 && index < _contacts.length) {
      _contacts.removeAt(index);
      notifyListeners();
    }
  }

  void updateContact(int index, ContactInfo updated) {
    if (index >= 0 && index < _contacts.length) {
      _contacts[index] = updated;
      notifyListeners();
    }
  }

  void clear() {
    _contacts.clear();
    notifyListeners();
  }
}
