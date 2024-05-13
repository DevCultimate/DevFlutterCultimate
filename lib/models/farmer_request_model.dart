class FarmerRequest {
  final String name;
  final String status;
  final String logoUrl;
  final String docId;
  final String fromDate; // Added fromDate property
  final String toDate;   // Added toDate property
  final String plotNo;   // Added plotNo property
  final String khata;    // Added khata property

  FarmerRequest(
    this.name,
    this.status,
    this.logoUrl,
    this.docId,
    this.fromDate,
    this.toDate,
    this.plotNo,
    this.khata,
  );
}
