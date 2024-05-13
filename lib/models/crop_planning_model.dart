class CropPlanning {
  final String selectedCrop;
  final String selectedYear;
  final String selectedSeason;
  final String selectedSeedType;
  final int seedQuantity;
  final String selectedFertilizerType;
  final int fertilizerQuantity;
  final String selectedPesticideType;
  final int pesticideQuantity;
  final bool wantCredit;
  final bool insurance;
  final bool marketingSupport;
  final String remarks;

  CropPlanning({
    required this.selectedCrop,
    required this.selectedYear,
    required this.selectedSeason,
    required this.selectedSeedType,
    required this.seedQuantity,
    required this.selectedFertilizerType,
    required this.fertilizerQuantity,
    required this.selectedPesticideType,
    required this.pesticideQuantity,
    required this.wantCredit,
    required this.insurance,
    required this.marketingSupport,
    required this.remarks,
  });

  Map<String, dynamic> toMap() {
    return {
      'selectedCrop': selectedCrop,
      'selectedYear': selectedYear,
      'selectedSeason': selectedSeason,
      'selectedSeedType': selectedSeedType,
      'seedQuantity': seedQuantity,
      'selectedFertilizerType': selectedFertilizerType,
      'fertilizerQuantity': fertilizerQuantity,
      'selectedPesticideType': selectedPesticideType,
      'pesticideQuantity': pesticideQuantity,
      'wantCredit': wantCredit,
      'insurance': insurance,
      'marketingSupport': marketingSupport,
      'remarks': remarks,
    };
  }
}
