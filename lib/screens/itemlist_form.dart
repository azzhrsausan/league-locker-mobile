import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:league_locker/screens/menu.dart';

class ItemListFormPage extends StatefulWidget {
  const ItemListFormPage({super.key});

  @override
  State<ItemListFormPage> createState() => _ItemListFormPageState();
}

class _ItemListFormPageState extends State<ItemListFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _price = "";
  String _category = "";
  String _description = "";
  String _thumbnail = "";
  bool _isFeatured = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Product Name"),
              onChanged: (value) => _name = value,
              validator: (value) =>
              value!.isEmpty ? "Name cannot be empty" : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Price"),
              keyboardType: TextInputType.number,
              onChanged: (value) => _price = value,
              validator: (value) =>
              value!.isEmpty ? "Price cannot be empty" : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Category"),
              onChanged: (value) => _category = value,
              validator: (value) =>
              value!.isEmpty ? "Category cannot be empty" : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Description"),
              maxLines: 5,
              onChanged: (value) => _description = value,
              validator: (value) =>
              value!.isEmpty ? "Description cannot be empty" : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Thumbnail URL"),
              onChanged: (value) => _thumbnail = value,
              validator: (value) =>
              value!.isEmpty ? "Thumbnail cannot be empty" : null,
            ),
            SwitchListTile(
              title: const Text("Featured Product"),
              value: _isFeatured,
              onChanged: (value) {
                setState(() {
                  _isFeatured = value;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final response = await request.postJson(
                    "http://localhost:8000/create-flutter/",
                    jsonEncode({
                      "name": _name,
                      "price": int.parse(_price),
                      "category": _category,
                      "description": _description,
                      "thumbnail": _thumbnail,
                      "is_featured": _isFeatured,
                    }),
                  );

                  if (context.mounted) {
                    if (response['status'] == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Product successfully saved!"),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MyHomePage(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Something went wrong."),
                        ),
                      );
                    }
                  }
                }
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
