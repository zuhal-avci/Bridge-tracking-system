import '../models/bridge.dart';

final List<Bridge> sampleBridges = [
  Bridge(
    name: 'Acemler Kavşağı Köprüsü',
    buildDate: '2001',
    location: '40.2222, 29.0123',
    district: 'Osmangazi', // <-- Buraya eklendi
    inspectionDetails: {'Taşıyıcı Sistem': 'Kutu Kiriş', 'Üst Yapı': 'Asfalt'},
  ),
  Bridge(
    name: 'Nilüfer Deresi Üzeri Köprüsü',
    buildDate: '1998',
    location: '40.2451, 29.0145',
    district: 'Nilüfer',
    inspectionDetails: {
      'Taşıyıcı Sistem': 'Çelik Kiriş',
      'Üst Yapı': 'Betonarme',
    },
  ),
];
