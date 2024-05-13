class LandDetails {
  final String docId;
  final String from;
  final String status;
  final String to;
  final String area;
  final String khata;
  final String location;
  final String ownerName;
  final String ownership;
  final String plotNumber;

  LandDetails({
    required this.docId,
    required this.from,
    required this.status,
    required this.to,
    required this.area,
    required this.khata,
    required this.location,
    required this.ownerName,
    required this.ownership,
    required this.plotNumber,
  });

  factory LandDetails.fromJson(Map<String, dynamic> json, String docId) {
    return LandDetails(
      docId: docId,
      from: json['From'] ?? '',
      status: json['Status'] ?? '',
      to: json['To'] ?? '',
      area: json['area'] ?? '',
      khata: json['khata'] ?? '',
      location: json['location'] ?? '',
      ownerName: json['ownerName'] ?? '',
      ownership: json['ownership'] ?? '',
      plotNumber: json['plotNumber'] ?? '',
    );
  }
}
