import 'package:json_annotation/json_annotation.dart';
part 'get_all_branch_model.g.dart';

@JsonSerializable()
class GetAllBranchModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "error")
  String error;
  @JsonKey(name: "items")
  List<Branch> items;

  GetAllBranchModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory GetAllBranchModel.fromJson(Map<String, dynamic> json) => _$GetAllBranchModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllBranchModelToJson(this);
}

@JsonSerializable()
class Branch {
 /* @JsonKey(name: "location")
  Location location;*/
  @JsonKey(name: "_id")
  String id;
 /* @JsonKey(name: "companyId")
  CompanyId companyId;*/
  @JsonKey(name: "name")
  String name;
 /* @JsonKey(name: "address")
  String address;
  @JsonKey(name: "city")
  String city;
  @JsonKey(name: "state")
  State state;
  @JsonKey(name: "pincode")
  String pincode;
  @JsonKey(name: "type")
  RegionalBranchIdType type;
  @JsonKey(name: "regional")
  bool regional;
  @JsonKey(name: "regionalBranchId")
  RegionalBranchId? regionalBranchId;
  @JsonKey(name: "status")
  Status status;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;
  @JsonKey(name: "isActive")
  bool isActive;
  @JsonKey(name: "createdBy")
  CreatedBy createdBy;
  @JsonKey(name: "updatedBy")
  dynamic updatedBy;*/

  Branch({
   // required this.location,
    required this.id,
   // required this.companyId,
    required this.name,
    /*required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    required this.type,
    required this.regional,
    required this.regionalBranchId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,*/
  });

  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);

  Map<String, dynamic> toJson() => _$BranchToJson(this);
}

/*enum CompanyId {
  @JsonValue("66850b3d374425e937114129")
  THE_66850_B3_D374425_E937114129
}*/

/*
@JsonSerializable()
class CreatedBy {
  @JsonKey(name: "_id")
  Id id;
  @JsonKey(name: "employeName")
  EmployeName employeName;

  CreatedBy({
    required this.id,
    required this.employeName,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => _$CreatedByFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedByToJson(this);
}

enum EmployeName {
  @JsonValue("jiyaaa")
  JIYAAA,
  @JsonValue("nikit Sir")
  NIKIT_SIR
}

enum Id {
  @JsonValue("66850f7d374425e937114180")
  THE_66850_F7_D374425_E937114180,
  @JsonValue("66c9a4b86222536724d3e7bf")
  THE_66_C9_A4_B86222536724_D3_E7_BF
}

@JsonSerializable()
class Location {
  @JsonKey(name: "type")
  LocationType type;
  @JsonKey(name: "coordinates")
  List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

enum LocationType {
  @JsonValue("Point")
  POINT
}

@JsonSerializable()
class RegionalBranchId {
  @JsonKey(name: "location")
  Location location;
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "companyId")
  CompanyId companyId;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "address")
  String address;
  @JsonKey(name: "city")
  String city;
  @JsonKey(name: "state")
  State state;
  @JsonKey(name: "pincode")
  String pincode;
  @JsonKey(name: "type")
  RegionalBranchIdType type;
  @JsonKey(name: "regional")
  bool regional;
  @JsonKey(name: "regionalBranchId")
  dynamic regionalBranchId;
  @JsonKey(name: "status")
  Status status;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;
  @JsonKey(name: "isActive")
  bool isActive;
  @JsonKey(name: "createdBy")
  Id createdBy;
  @JsonKey(name: "updatedBy")
  dynamic updatedBy;

  RegionalBranchId({
    required this.location,
    required this.id,
    required this.companyId,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    required this.type,
    required this.regional,
    required this.regionalBranchId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
  });

  factory RegionalBranchId.fromJson(Map<String, dynamic> json) => _$RegionalBranchIdFromJson(json);

  Map<String, dynamic> toJson() => _$RegionalBranchIdToJson(this);
}

enum State {
  @JsonValue("Madhya Pradesh")
  MADHYA_PRADESH,
  @JsonValue("MP")
  MP
}

enum Status {
  @JsonValue("pending")
  PENDING
}

enum RegionalBranchIdType {
  @JsonValue("Corporate Office")
  CORPORATE_OFFICE,
  @JsonValue("Regional Office")
  REGIONAL_OFFICE
}
*/
