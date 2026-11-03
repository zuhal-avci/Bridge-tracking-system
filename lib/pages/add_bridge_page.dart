import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class AddBridgePage extends StatefulWidget {
  const AddBridgePage({super.key});

  @override
  State<AddBridgePage> createState() => _AddBridgePageState();
}

class _AddBridgePageState extends State<AddBridgePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController buildDateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final List<XFile> _images = [];
  int _currentPage = 0;

  final Map<String, String?> selectedOptions = {};
  final Map<String, List<String>> featureOptions = {
    'Korkuluk Türü': [
      'Yok',
      'Metal Yaya Korkuluk',
      'Metal Kenar Korkuluk',
      'Betonarme Yaya Korkuluk',
      'Betonarme Kenar Korkuluk',
      'Taş Korkuluk',
      'Kompozit Korkuluk',
    ],
    'Bordür Türü': [
      'Yok',
      'Betonarme Bordür',
      'Taş Bordür',
      'Metal Bordür',
      'Prekast Bordür',
    ],
    'Yan Parapet Türü': ['Yok', 'Beton Parapet', 'Metal Parapet'],
    'Aşınma Tabakası Türü': [
      'Yok',
      'Asfalt Kaplama',
      'Sathi Kaplama',
      'Mastik Asfalt',
    ],
    'Tecrit Türü': ['Yok', 'Polimer Bitümlü Örtü'],
    'Genleşme Derzi Türü': ['Yok', 'Metal Derz', 'Bitüm Esaslı Derz'],
    'Garguy Türü': ['Yok', 'Metal Garguy', 'Plastik Garguy'],
    'Döşeme Türü': ['Yok', 'Betonarme Döşeme', 'Çelik Döşeme', 'Taş Döşeme'],
    'Taşıyıcı Sistem Türü': [
      'Yok',
      'Betonarme Kiriş',
      'Çelik Kiriş',
      'Öngermeli Kiriş',
    ],
    'Kemer Türü': [
      'Yok',
      'Taş Kemer',
      'Betonarme Kemer',
      'Çelik Kemer',
      'Beton Kemer',
    ],
    'Mafsal Türü': ['Yok', 'Mafsal'],
    'Betonarme Plak Türü': ['Yok', 'Betonarme Plak'],
    'Pandül Türü': ['Yok', 'Betonarme Pandül'],
    'Mesnet Türü': ['Yok', 'Elastomerik Mesnet', 'Çelik Mesnet'],
    'Mesnet Takozu': ['Yok', 'Betonarme Mesnet Takozu'],
    'Deprem Takozu': ['Yok', 'Deprem Takozu'],
    'Kenar Ayak Türü': [
      'Yok',
      'Betonarme Kolon(Kenar Ayak)',
      'Betonarme Başlık Kirişi(Kenar Ayak)',
      'Çelik Kolon(Kenar Ayak)',
      'Çelik Başlık Kirişi(Kenar Ayak)',
      'Betonarme Perde(Kenar Ayak)',
      'Betonarme Payandalı Perde(Kenar Ayak)',
      'Beton Perde(Mesnet Bandlı-Kenar Ayak)',
      'Taş(Kenar Ayak)',
      'Kompozit Kolon(Kenar Ayak)',
      'Betonarme Kutu Kesit(Kenar Ayak)',
      'Çelik Kutu Kesit(Kenar Ayak)',
      'Kanat Duvar(Kenar Ayak)',
      'Sıra Kazık(Kenar Ayak)',
      'Toprakarme(Kenar Ayak)',
      'Bağ Kirişi(Kenar Ayak)',
    ],
    'Orta Ayak Türü': [
      'Betonarme Kolon(Orta Ayak)',
      'Betonarme Başlık Kirişi(Orta Ayak)',
      'Çelik Kolon(Orta Ayak)',
      'Çelik Başlık Kirişi(Orta Ayak)',
      'Taş(Kargir) Ayak(Orta Ayak)',
      'Betonarme Perde(Orta Ayak)',
      'Kompozit Kolon(Orta Ayak)',
      'Betonarme Kutu Kesit(Orta Ayak)',
      'Çelik Kutu Kesit(Orta Ayak)',
      'Bağ Kirişi(Orta Ayak)',
    ],
    'Yaklaşım Elemanları': ['Yok', 'Yaklaşım Plağı', 'Yaklaşım Dolgusu'],
    'Tahkimat': [
      'Yok',
      'Beton Pere',
      'Taş Pere',
      'Beton Anroşman',
      'Taş Anroşman',
      'Taş Şut',
      'Beton Şut',
      'Taş Gido',
      'Beton Gido',
      'Taş Mahmuz',
      'Beton Mahmuz',
      'Gabion Tel Kafes',
    ],
    'Aydınlatma': ['Yok', 'Var'],
    'İşaretlendirme': ['Yok', 'Yatay İşaretlendirme', 'Düşey İşaretlendirme'],
    'Tesisat': [
      'Yok',
      'Enerji Tesisatı',
      'Haberleşme Tesisatı',
      'Su Tesisatı',
      'Akaryakıt Tesisatı',
    ],
    'Yol Güvenlik Elemanları': ['Yok', 'Var'],
    'Altgeçitlerde Havalandırma': ['Yok', 'Var'],
    'Drenaj ve Pompa Odası': ['Yok', 'Var'],
  };

  @override
  void initState() {
    super.initState();
    for (var key in featureOptions.keys) {
      selectedOptions[key] = null;
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Konum izni reddedildi')));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Konum izni kalıcı olarak reddedildi')),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    locationController.text = '${position.latitude}, ${position.longitude}';
  }

  Future<void> _showImageSourceSheet() async {
    if (_images.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('En fazla 5 fotoğraf yükleyebilirsiniz.')),
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeriden Seç'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await _picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) setState(() => _images.add(image));
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Fotoğraf Çek'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await _picker.pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) setState(() => _images.add(image));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            if (_images.isEmpty)
              GestureDetector(
                onTap: _showImageSourceSheet,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 40,
                          color: Colors.blue,
                        ),
                        SizedBox(height: 8),
                        Text('Resim Ekle'),
                      ],
                    ),
                  ),
                ),
              )
            else
              Column(
                children: [
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: PageView.builder(
                      itemCount: _images.length,
                      controller: PageController(viewportFraction: 1),
                      onPageChanged: (index) =>
                          setState(() => _currentPage = index),
                      itemBuilder: (context, index) => ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(_images[index].path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _images.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == _currentPage
                              ? Colors.blue
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: _showImageSourceSheet,
                    icon: const Icon(Icons.add),
                    label: const Text("Fotoğraf Ekle"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      side: const BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: featureOptions.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(top: 12),
          child: DropdownButtonFormField<String>(
            value: selectedOptions[entry.key],
            decoration: InputDecoration(
              labelText: entry.key,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            items: entry.value.isEmpty
                ? [
                    const DropdownMenuItem(
                      value: null,
                      child: Text("Alt seçenekler eklenecek..."),
                    ),
                  ]
                : entry.value.map((option) {
                    return DropdownMenuItem(value: option, child: Text(option));
                  }).toList(),
            onChanged: (val) =>
                setState(() => selectedOptions[entry.key] = val),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Köprü Ekle'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildImageSection(),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: _inputStyle('Köprü Adı'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: districtController,
              decoration: _inputStyle('İlçe'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: buildDateController,
              keyboardType: TextInputType.number,
              decoration: _inputStyle('Yapım Tarihi'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: locationController,
                    readOnly: true,
                    decoration: _inputStyle('Konum (lat, long)'),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _getCurrentLocation,
                  child: const Text('Konumu Al'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildDropdownSection(),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Köprü kaydedildi (simülasyon)'),
                  ),
                );
              },
              icon: const Icon(Icons.save),
              label: const Text('Kaydet'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
