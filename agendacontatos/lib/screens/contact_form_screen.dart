import 'package:agendacontatos/database/database_helper.dart';
import 'package:agendacontatos/models/contact.dart';
import 'package:flutter/material.dart';

class ContactFormScreen extends StatefulWidget {
  final Contact? contact;
  const ContactFormScreen({super.key, this.contact});

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  bool get _isEditing => widget.contact != null;

  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();

  DatabaseHelper dbHelper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();

  Future<void> _save() async {
    final c = Contact(
      id: widget.contact?.id,
      name: _nameCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      age: _ageCtrl.text.trim(),
    );

    if (!_formKey.currentState!.validate()) return;

    _isEditing ? await dbHelper.update(c) : await dbHelper.insert(c);

    Navigator.pop(context, true);
  }

  @override
  void initState() {
    super.initState();
    final c = widget.contact;
    if (c != null) {
      _nameCtrl.text = c.name;
      _emailCtrl.text = c.email;
      _phoneCtrl.text = c.phone;
      _ageCtrl.text = c.age!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? "Editar Contato" : "Novo Contato"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: InputDecoration(
                  labelText: "Nome",
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Informe o nome' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _phoneCtrl,
                decoration: InputDecoration(
                  labelText: "Telefone",
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Informe o telefone'
                    : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailCtrl,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return "Preencha o email";

                  final regex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
                  return regex.hasMatch(v) ? null : "Email inválido";
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _ageCtrl,
                decoration: InputDecoration(
                  labelText: "Idade",
                  prefixIcon: Icon(Icons.cake),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 20,
                child: ElevatedButton(
                  onPressed: _save,
                  child: Text(
                    _isEditing ? "Atualizar Contato" : "Criar Contato",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
