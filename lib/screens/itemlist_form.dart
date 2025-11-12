import 'package:flutter/material.dart';
import 'package:league_locker/widgets/left_drawer.dart';

class ItemFormPage extends StatefulWidget {
  const ItemFormPage({super.key});

  @override
  State<ItemFormPage> createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _description = "";
  String _thumbnail = "";
  String _category = "jersey";
  bool _isFeatured = false;
  double? _price;

  final List<String> _categories = [
    'jersey',
    'boots',
    'ball',
    'accessories',
    'merch',
    'training',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Create Product Form',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  // === Title ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Nama Produk",
                        labelText: "Nama Produk",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _name = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Nama tidak boleh kosong!";
                        }
                        if (value.length < 3) {
                          return "Minimal 3 karakter";
                        }
                        return null;
                      },
                    ),
                  ),

                  // PRICE
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Price",
                        hintText: "Contoh: 499000",
                        border: OutlineInputBorder(),
                        prefixText: "Rp ",
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (String? value) {
                        _price = double.tryParse((value ?? "").replaceAll(",", "").trim());
                        setState(() {});
                      },
                      validator: (String? value) {
                        final v = (value ?? "").replaceAll(",", "").trim();
                        final parsed = double.tryParse(v);
                        if (v.isEmpty) return "Price tidak boleh kosong!";
                        if (parsed == null) return "Price harus berupa angka";
                        if (parsed <= 0) return "Price harus lebih dari 0";
                        return null;
                      },
                    ),
                  ),

                  // DESCRIPTION
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Description",
                        hintText: "Tuliskan deskripsi produk",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                      onChanged: (String? value) {
                        setState(() {
                          _description = value?.trim() ?? "";
                        });
                      },
                      validator: (String? value) {
                        final v = value?.trim() ?? "";
                        if (v.isEmpty) return "Description tidak boleh kosong!";
                        if (v.length < 10) return "Minimal 10 karakter";
                        return null;
                      },
                    ),
                  ),

                  // CATEGORY
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                      value: _category,
                      decoration: const InputDecoration(
                        labelText: "Category",
                        border: OutlineInputBorder(),
                      ),
                      items: _categories
                          .map((c) => DropdownMenuItem<String>(value: c, child: Text(c)))
                          .toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          setState(() {
                            _category = value;
                          });
                        }
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) return "Category tidak boleh kosong!";
                        if (!_categories.contains(value)) return "Category tidak valid";
                        return null;
                      },
                    ),
                  ),

                  // THUMBNAIL (URL)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Thumbnail (URL)",
                          hintText: "https://contoh.com/gambar.jpg",
                          border: OutlineInputBorder(),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _thumbnail = value?.trim() ?? "";
                      });
                    },
                    validator: (String? value) {
                      final v = value?.trim() ?? "";
                      if (v.isEmpty) return "Thumbnail tidak boleh kosong!";
                      final uri = Uri.tryParse(v);
                      final valid = uri != null && uri.hasScheme && uri.hasAuthority;
                      return valid ? null : "URL tidak valid";
                    },
                    ),
                  ),

                  // FEATURED (BOOLEAN)
                  SwitchListTile(
                    title: const Text("Featured"),
                    subtitle: const Text("Tampilkan sebagai produk unggulan"),
                    value: _isFeatured,
                    onChanged: (bool value) {
                      setState(() {
                        _isFeatured = value; // boolean selalu terisi, tidak bisa kosong
                      });
                    },
                  ),

                  // === Tombol Simpan ===
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.indigo),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Produk berhasil disimpan!'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text('Nama: $_name'),
                                          Text('Deskripsi: $_description'),
                                          Text('Thumbnail: $_thumbnail'),
                                          Text('Kategori: $_category'),
                                          Text(
                                              'Unggulan: ${_isFeatured ? "Ya" : "Tidak"}'),
                                          Text('Harga: $_price'),
                                        ],
                                      ),
                                    ),

                                    actions: [
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _formKey.currentState!.reset();
                                        },
                                      ),
                                    ],
                                );
                              },
                            );
                          }
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ]
            ),
        ),
      ),
    );
  }
}