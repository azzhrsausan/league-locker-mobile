import 'package:flutter/material.dart';
import 'package:league_locker/models/item_entry.dart';
import 'package:league_locker/widgets/left_drawer.dart';
import 'package:league_locker/widgets/item_entry_card.dart';
import 'package:league_locker/screens/item_detail.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ItemEntryListPage extends StatefulWidget {
  const ItemEntryListPage({super.key});

  @override
  State<ItemEntryListPage> createState() => _ItemEntryListPageState();
}

class _ItemEntryListPageState extends State<ItemEntryListPage> {
  Future<List<ItemEntry>> fetchItems(CookieRequest request) async {
    final response = await request.get('http://localhost:8000/json/');
    List<ItemEntry> listItems = [];
    for (var d in response) {
      if (d != null) listItems.add(ItemEntry.fromJson(d));
    }
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchItems(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Center(
                child: Text(
                  'There are no products yet.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff59A5D8),
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => ItemEntryCard(
                  item: snapshot.data![index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ItemDetailPage(
                          item: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
