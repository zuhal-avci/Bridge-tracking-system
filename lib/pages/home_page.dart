import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../data/sample_data.dart';
import '../models/bridge.dart';
import 'bridge_detail_page.dart';
import 'add_bridge_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedDistrict;
  Bridge? selectedBridge;

  List<String> get districts {
    return sampleBridges.map((b) => b.district).toSet().toList()..sort();
  }

  List<Bridge> get filteredBridges {
    if (selectedDistrict == null) return [];
    return sampleBridges.where((b) => b.district == selectedDistrict).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Köprü Bilgi Sistemi'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownSearch<String>(
              items: districts,
              selectedItem: selectedDistrict,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "İlçe Seç",
                  filled: true,
                  fillColor: Colors.blue.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue.shade200),
                  ),
                ),
              ),
              popupProps: const PopupProps.menu(showSearchBox: false),
              onChanged: (district) {
                setState(() {
                  selectedDistrict = district;
                  selectedBridge = null;
                });
              },
            ),
            const SizedBox(height: 12),
            if (selectedDistrict != null)
              DropdownSearch<Bridge>(
                items: filteredBridges,
                itemAsString: (Bridge b) => b.name,
                selectedItem: selectedBridge,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Köprü Seç / Ara",
                    filled: true,
                    fillColor: Colors.blue.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.blue.shade200),
                    ),
                  ),
                ),
                popupProps: PopupProps.dialog(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      hintText: "Köprü adı yaz...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Köprüler - $selectedDistrict",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onChanged: (Bridge? bridge) {
                  if (bridge != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BridgeDetailPage(bridge: bridge),
                      ),
                    );
                  }
                },
              ),
          ],
        ),
      ),
      floatingActionButton: Tooltip(
        message: 'Köprü Ekle',
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddBridgePage()),
            );
          },
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
