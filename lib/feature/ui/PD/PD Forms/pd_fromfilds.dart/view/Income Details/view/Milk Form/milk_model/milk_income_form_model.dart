class MilkBusinessModel {
  final String incomeSourceType;
  final MilkBusinessData data;

  MilkBusinessModel({
    required this.incomeSourceType,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
    'incomeSourceType': incomeSourceType,
    'data': data.toJson(),
  };
}

class MilkBusinessData {
  final String numberOfCattrels;
  final String noOfMilkGivingCattles;
  final String doingFromNoOfYears;
  final String totalMilkSupplyPerDay;
  final String nameOfDairy;
  final String dairyOwnerMobNo;
  final String dairyAddress;
  final String milkProvideFromSinceYear;
  final String expensesOfMilkBusiness;
  final String monthlyIncomeMilkBusiness;
  final List<String> milkPhotos;
  final List<String> animalPhotos;
  final String currentMilkUtilization;
  final List<String> breedOfCattles;
  final String ifCropDestroyedHowToPayEMI;
  final String observedDesignatedCattleTyingArea;

  MilkBusinessData({
    required this.numberOfCattrels,
    required this.noOfMilkGivingCattles,
    required this.doingFromNoOfYears,
    required this.totalMilkSupplyPerDay,
    required this.nameOfDairy,
    required this.dairyOwnerMobNo,
    required this.dairyAddress,
    required this.milkProvideFromSinceYear,
    required this.expensesOfMilkBusiness,
    required this.monthlyIncomeMilkBusiness,
    required this.milkPhotos,
    required this.animalPhotos,
    required this.currentMilkUtilization,
    required this.breedOfCattles,
    required this.ifCropDestroyedHowToPayEMI,
    required this.observedDesignatedCattleTyingArea,
  });

  // Add this factory constructor
  factory MilkBusinessData.fromJson(Map<String, dynamic> json) {
    return MilkBusinessData(
      numberOfCattrels: json['numberOfCattrels'] ?? '',
      noOfMilkGivingCattles: json['noOfMilkGivingCattles'] ?? '',
      doingFromNoOfYears: json['doingFromNoOfYears'] ?? '',
      totalMilkSupplyPerDay: json['totalMilkSupplyPerDay'] ?? '',
      nameOfDairy: json['nameOfDairy'] ?? '',
      dairyOwnerMobNo: json['dairyOwnerMobNo'] ?? '',
      dairyAddress: json['dairyAddress'] ?? '',
      milkProvideFromSinceYear: json['milkprovideFromSinceYear'] ?? '',
      expensesOfMilkBusiness: json['expensesOfMilkBusiness'] ?? '',
      monthlyIncomeMilkBusiness: json['monthlyIncomeMilkBusiness'] ?? '',
      milkPhotos: List<String>.from(json['milkPhotos'] ?? []),
      animalPhotos: List<String>.from(json['animalPhotos'] ?? []),
      currentMilkUtilization: json['currentMilkUtilization'] ?? '',
      breedOfCattles: List<String>.from(json['breedOfCattles'] ?? []),
      ifCropDestroyedHowToPayEMI: json['ifCropDestroyedHowToPayEMI'] ?? '',
      observedDesignatedCattleTyingArea: json['observedDesignatedCattleTyingArea'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'numberOfCattrels': numberOfCattrels,
    'noOfMilkGivingCattles': noOfMilkGivingCattles,
    'doingFromNoOfYears': doingFromNoOfYears,
    'totalMilkSupplyPerDay': totalMilkSupplyPerDay,
    'nameOfDairy': nameOfDairy,
    'dairyOwnerMobNo': dairyOwnerMobNo,
    'dairyAddress': dairyAddress,
    'milkprovideFromSinceYear': milkProvideFromSinceYear,
    'expensesOfMilkBusiness': expensesOfMilkBusiness,
    'monthlyIncomeMilkBusiness': monthlyIncomeMilkBusiness,
    'milkPhotos': milkPhotos,
    'animalPhotos': animalPhotos,
    'currentMilkUtilization': currentMilkUtilization,
    'breedOfCattles': breedOfCattles,
    'ifCropDestroyedHowToPayEMI': ifCropDestroyedHowToPayEMI,
    'observedDesignatedCattleTyingArea': observedDesignatedCattleTyingArea,
  };
}




