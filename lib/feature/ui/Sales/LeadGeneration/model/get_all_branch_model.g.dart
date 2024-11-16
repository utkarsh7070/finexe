// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllBranchModel _$GetAllBranchModelFromJson(Map<String, dynamic> json) =>
    GetAllBranchModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => Branch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllBranchModelToJson(GetAllBranchModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Branch _$BranchFromJson(Map<String, dynamic> json) => Branch(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      id: json['_id'] as String,
      companyId: $enumDecode(_$CompanyIdEnumMap, json['companyId']),
      name: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      state: $enumDecode(_$StateEnumMap, json['state']),
      pincode: json['pincode'] as String,
      type: $enumDecode(_$RegionalBranchIdTypeEnumMap, json['type']),
      regional: json['regional'] as bool,
      regionalBranchId: json['regionalBranchId'] == null
          ? null
          : RegionalBranchId.fromJson(
              json['regionalBranchId'] as Map<String, dynamic>),
      status: $enumDecode(_$StatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
      isActive: json['isActive'] as bool,
      createdBy: CreatedBy.fromJson(json['createdBy'] as Map<String, dynamic>),
      updatedBy: json['updatedBy'],
    );

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      'location': instance.location,
      '_id': instance.id,
      'companyId': _$CompanyIdEnumMap[instance.companyId]!,
      'name': instance.name,
      'address': instance.address,
      'city': instance.city,
      'state': _$StateEnumMap[instance.state]!,
      'pincode': instance.pincode,
      'type': _$RegionalBranchIdTypeEnumMap[instance.type]!,
      'regional': instance.regional,
      'regionalBranchId': instance.regionalBranchId,
      'status': _$StatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
      'isActive': instance.isActive,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
    };

const _$CompanyIdEnumMap = {
  CompanyId.THE_66850_B3_D374425_E937114129: '66850b3d374425e937114129',
};

const _$StateEnumMap = {
  State.MADHYA_PRADESH: 'Madhya Pradesh',
  State.MP: 'MP',
};

const _$RegionalBranchIdTypeEnumMap = {
  RegionalBranchIdType.CORPORATE_OFFICE: 'Corporate Office',
  RegionalBranchIdType.REGIONAL_OFFICE: 'Regional Office',
};

const _$StatusEnumMap = {
  Status.PENDING: 'pending',
};

CreatedBy _$CreatedByFromJson(Map<String, dynamic> json) => CreatedBy(
      id: $enumDecode(_$IdEnumMap, json['_id']),
      employeName: $enumDecode(_$EmployeNameEnumMap, json['employeName']),
    );

Map<String, dynamic> _$CreatedByToJson(CreatedBy instance) => <String, dynamic>{
      '_id': _$IdEnumMap[instance.id]!,
      'employeName': _$EmployeNameEnumMap[instance.employeName]!,
    };

const _$IdEnumMap = {
  Id.THE_66850_F7_D374425_E937114180: '66850f7d374425e937114180',
  Id.THE_66_C9_A4_B86222536724_D3_E7_BF: '66c9a4b86222536724d3e7bf',
};

const _$EmployeNameEnumMap = {
  EmployeName.JIYAAA: 'jiyaaa',
  EmployeName.NIKIT_SIR: 'nikit Sir',
};

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      type: $enumDecode(_$LocationTypeEnumMap, json['type']),
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'type': _$LocationTypeEnumMap[instance.type]!,
      'coordinates': instance.coordinates,
    };

const _$LocationTypeEnumMap = {
  LocationType.POINT: 'Point',
};

RegionalBranchId _$RegionalBranchIdFromJson(Map<String, dynamic> json) =>
    RegionalBranchId(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      id: json['_id'] as String,
      companyId: $enumDecode(_$CompanyIdEnumMap, json['companyId']),
      name: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      state: $enumDecode(_$StateEnumMap, json['state']),
      pincode: json['pincode'] as String,
      type: $enumDecode(_$RegionalBranchIdTypeEnumMap, json['type']),
      regional: json['regional'] as bool,
      regionalBranchId: json['regionalBranchId'],
      status: $enumDecode(_$StatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
      isActive: json['isActive'] as bool,
      createdBy: $enumDecode(_$IdEnumMap, json['createdBy']),
      updatedBy: json['updatedBy'],
    );

Map<String, dynamic> _$RegionalBranchIdToJson(RegionalBranchId instance) =>
    <String, dynamic>{
      'location': instance.location,
      '_id': instance.id,
      'companyId': _$CompanyIdEnumMap[instance.companyId]!,
      'name': instance.name,
      'address': instance.address,
      'city': instance.city,
      'state': _$StateEnumMap[instance.state]!,
      'pincode': instance.pincode,
      'type': _$RegionalBranchIdTypeEnumMap[instance.type]!,
      'regional': instance.regional,
      'regionalBranchId': instance.regionalBranchId,
      'status': _$StatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
      'isActive': instance.isActive,
      'createdBy': _$IdEnumMap[instance.createdBy]!,
      'updatedBy': instance.updatedBy,
    };
