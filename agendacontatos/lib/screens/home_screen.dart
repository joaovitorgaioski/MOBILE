import 'package:agendacontatos/database/database_helper.dart';
import 'package:agendacontatos/models/contact.dart';
import 'package:agendacontatos/screens/contact_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchCtrl = TextEditingController();

  final DatabaseHelper dbHelper = DatabaseHelper();
  List<Contact> _contacts = [];

  Future<void> _loadContacts() async {
    try {
      final list = await dbHelper.getAll();

      setState(() {
        _contacts = list;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Erro ao carregar dados: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _openForm(Contact? contact) async {
    final ok = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => ContactFormScreen(contact: contact)),
    );

    if (ok == true) {
      _loadContacts();
    }
  }

  void _confirmDelete() {}

  // Roda ao iniciar o Widget
  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda de contatos"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: "Buscar por nome, telefone ou email...",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        padding: EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (_, i) {
          final c = _contacts[i];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(c.name[0], style: TextStyle(color: Colors.black)),
              ),
              title: Text(
                c.name,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                spacing: 5,
                children: [
                  Row(spacing: 5, children: [Icon(Icons.phone), Text(c.phone)]),
                  Row(spacing: 5, children: [Icon(Icons.mail), Text(c.email)]),
                  Row(spacing: 5, children: [Icon(Icons.cake), Text(c.age!)]),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _openForm(c),
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () => _confirmDelete,
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm,
        child: Icon(Icons.add),
      ),
    );
  }
}
