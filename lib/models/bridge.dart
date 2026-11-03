class Bridge {
  final String name;
  final String buildDate;
  final String location;
  final String district; // <-- İlçe alanı eklendi
  final Map<String, String> inspectionDetails;

  Bridge({
    required this.name,
    required this.buildDate,
    required this.location,
    required this.district,
    required this.inspectionDetails,
  });
}
