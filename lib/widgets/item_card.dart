import 'package:flutter/material.dart';
import 'package:league_locker/screens/menu.dart' show ItemHomepage;
import 'package:league_locker/screens/itemlist_form.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    // Menentukan warna berbeda untuk setiap tombol
    Color backgroundColor;

    if (item.name == "All Products") {
      backgroundColor = Colors.blue; // Warna biru
    } else if (item.name == "My Products") {
      backgroundColor = Colors.green; // Warna hijau
    } else if (item.name == "Create Product") {
      backgroundColor = Colors.red; // Warna merah
    } else {
      backgroundColor = Theme.of(context).colorScheme.secondary;
    }

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!")),
            );

          // Navigate ke route yang sesuai (tergantung jenis tombol)
          if (item.name == "Create Product") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ItemFormPage()),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
