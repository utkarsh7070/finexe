import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/upload_box.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/property_form_model.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/property_vmodel.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/samagra_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Common Widgets/simple_dropdown.dart';

class Propertycollateral extends ConsumerStatefulWidget {
  const Propertycollateral({super.key});

  @override
  ConsumerState<Propertycollateral> createState() => _PropertycollateralState();
}

class _PropertycollateralState extends ConsumerState<Propertycollateral> {
  TextEditingController incomeSourceTypecontroller = TextEditingController();
  TextEditingController devlopmentOfSurroundingArea = TextEditingController();

  TextEditingController localityClass = TextEditingController();
  //property colateral
  TextEditingController propertyDetailForm_bankHolderName =
      TextEditingController();
  TextEditingController propertyDetailForm_selectStatusofPropety =
      TextEditingController();
  TextEditingController propertyDetailForm_relationApplicant =
      TextEditingController();
  TextEditingController propertyDetailForm_fatherName = TextEditingController();
  TextEditingController propertyDetailForm_villageName =
      TextEditingController();
  TextEditingController propertyDetailForm_panchayatName =
      TextEditingController();
  // location Details
  TextEditingController propertyDetailForm_stateName = TextEditingController();
  TextEditingController propertyDetailForm_districtName =
      TextEditingController();
  TextEditingController propertyDetailForm_tehsilName = TextEditingController();
  TextEditingController propertyDetailForm_patwariNo = TextEditingController();
  TextEditingController propertyDetailForm_wardNo = TextEditingController();
  TextEditingController propertyDetailForm_surveyNo = TextEditingController();
  // property boundaries
  TextEditingController propertyDetailForm_houseNo = TextEditingController();
  TextEditingController propertyDetailForm_eastName = TextEditingController();
  TextEditingController propertyDetailForm_westName = TextEditingController();
  TextEditingController propertyDetailForm_northName = TextEditingController();
  TextEditingController propertyDetailForm_southName = TextEditingController();
  // property documentation
  TextEditingController propertyDetailForm_documentProvided =
      TextEditingController();
  TextEditingController propertyDetailForm_boundariesPatta =
      TextEditingController();
  TextEditingController propertyDetailForm_propertyAddress =
      TextEditingController();
  TextEditingController propertyDetailForm_docHolderName =
      TextEditingController();
  // property coordinates & features
  TextEditingController propertyDetailForm_propertyLatitude =
      TextEditingController();
  TextEditingController propertyDetailForm_propertyLongitude =
      TextEditingController();
  TextEditingController propertyDetailForm_doorAndWindow =
      TextEditingController();
  TextEditingController propertyDetailForm_kitchenAndLat =
      TextEditingController();
  TextEditingController propertyDetailForm_assetResidence =
      TextEditingController();

  // Surrounding area and tansport
  TextEditingController propertyDetailForm_landMark = TextEditingController();
  TextEditingController propertyDetailForm_locaZone = TextEditingController();
  TextEditingController propertyDetailForm_localTransport =
      TextEditingController();
  TextEditingController propertyDetailForm_localityClass =
      TextEditingController();
  TextEditingController propertyDetailForm_localityType =
      TextEditingController();

  // Property Status
  TextEditingController propertyDetailForm_landflatStatus =
      TextEditingController();
  TextEditingController propertyDetailForm_propertyType =
      TextEditingController();
  TextEditingController propertyDetailForm_groundfloor =
      TextEditingController();
  TextEditingController propertyDetailForm_firstfloor = TextEditingController();
  TextEditingController propertyDetailForm_usagesType = TextEditingController();

  // structural Details
  TextEditingController propertyDetailForm_structureType =
      TextEditingController();
  TextEditingController propertyDetailForm_plotLocation =
      TextEditingController();
  TextEditingController propertyDetailForm_builtUpArea =
      TextEditingController();
  TextEditingController propertyDetailForm_structureOccupancy =
      TextEditingController();
  TextEditingController propertyDetailForm_electricityAndGas =
      TextEditingController();

  // Area Development
  TextEditingController propertyDetailForm_surroundingAreaDevelopment =
      TextEditingController();
  TextEditingController propertyDetailForm_totalBuiltUpArea =
      TextEditingController();
  TextEditingController propertyDetailForm_qualityConstruction =
      TextEditingController();
  TextEditingController propertyDetailForm_propertyAge =
      TextEditingController();
  TextEditingController propertyDetailForm_projectLifeYear =
      TextEditingController();
  // valuation and constrction
  TextEditingController propertyDetailForm_propertyMaintain =
      TextEditingController();
  TextEditingController propertyDetailForm_constructionType =
      TextEditingController();
  TextEditingController propertyDetailForm_landRate = TextEditingController();
  TextEditingController propertyDetailForm_totalCons = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  SizedBox sizedBoxWithContext(BuildContext context, double heightFactor) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * heightFactor,
    );
  }

  String selfieWithCustUrl = '';
  String photoWithLatLong = '';
  String frontImage = '';

  String mainRoad = '';

  @override
  Widget build(BuildContext context) {
    // final uploadselfie = ref.watch(sssMidimageProvider);
    final images = ref.watch(imageCollectionProvider);
    // final selfieWith = ref.watch(selfieWithCustomerUrlProvider);

    final appState = ref.watch(pdsubmitpropertyFormProvider);
    return ExpansionTile(
      backgroundColor: Colors.white,
      childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
      shape: const BeveledRectangleBorder(side: BorderSide.none),
      title: const Text('Property - Collaterals'),
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Business and Banking Information',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF475467))),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: 'Doucment Holder Name',
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_bankHolderName,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: 'Relation With Applicant',
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_relationApplicant,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Father's Name",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_fatherName,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Village Name",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_villageName,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Gram Panchayat",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_panchayatName,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),

              //   location details
              sizedBoxWithContext(context, 0.03),
              Text('Location Details',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF475467))),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CustomTextFormField(
                        inerHint: 'State',
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: propertyDetailForm_stateName,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CustomTextFormField(
                        inerHint: 'District',
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: propertyDetailForm_districtName,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                      ),
                    ),
                  ],
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Tehsil",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_tehsilName,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CustomTextFormField(
                        inerHint: 'Patwari Halka No.',
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: propertyDetailForm_patwariNo,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CustomTextFormField(
                        inerHint: 'Ward No.',
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: propertyDetailForm_wardNo,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                      ),
                    ),
                  ],
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Survey No.",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_surveyNo,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                ),
              ),

              // Property Boundaries
              sizedBoxWithContext(context, 0.03),
              Text('Property Boundaries',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF475467))),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "House No.",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_houseNo,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "East",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_eastName,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "West",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_westName,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "North",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_northName,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "South",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_southName,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),

              // Property Documentation
              sizedBoxWithContext(context, 0.03),
              Text('Property Documentation',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF475467))),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Document Provided",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_documentProvided,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Boundaries Matching With Patta",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_boundariesPatta,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Property Address",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_propertyAddress,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Document Holder Name",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_docHolderName,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),

              // Property Coordination & features
              sizedBoxWithContext(context, 0.03),
              Text('Property Coordination & features',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF475467))),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Property Latitude",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_propertyLatitude,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Property Longitude",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_propertyLongitude,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Doors & Windows Availability",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_doorAndWindow,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Kitchen & Lat/Bath Availability",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_kitchenAndLat,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),

              // dropdown asset seen at Residence
              Padding(
                padding: const EdgeInsets.only(right: 18),
                child: CustomDropDownTextField(
                  labelText: 'Income Source Type',
                  items: [
                    DropDownValueModel(name: 'Option 1', value: '1'),
                    DropDownValueModel(name: 'Option 2', value: '2'),
                    DropDownValueModel(name: 'Option 3', value: '3'),
                    DropDownValueModel(name: 'Option 4', value: '4'),
                    DropDownValueModel(name: 'Option 5', value: '5'),
                  ],
                  controller: incomeSourceTypecontroller,
                ),
              ),
              // Surrounding Area & Transport
              sizedBoxWithContext(context, 0.03),
              Text('Surrounding Area & Transport',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF475467))),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Landmark",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_landMark,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),

              // dropdown asset seen at Residence
              Padding(
                padding: const EdgeInsets.only(right: 18),
                child: CustomDropDownTextField(
                  labelText: 'Select Status of the land/flat',
                  items: [
                    DropDownValueModel(name: 'Owned', value: 'Owned'),
                    DropDownValueModel(name: 'Rented', value: 'Rented'),
                    DropDownValueModel(name: 'Leased', value: 'Leased'),
                    DropDownValueModel(
                        name: 'Under Cunstruction',
                        value: 'Under Cunstruction'),
                    DropDownValueModel(
                        name: 'Ready to move', value: 'Ready to move'),
                    DropDownValueModel(
                        name: 'Under Litigation', value: 'Under Litigation'),
                    DropDownValueModel(name: 'Mortgaged', value: 'Mortgaged'),
                    DropDownValueModel(name: 'Occupied', value: 'Occupied'),
                    DropDownValueModel(name: 'Vacant', value: 'Vacant'),
                  ],
                  controller: propertyDetailForm_selectStatusofPropety,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Location/Zone",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_locaZone,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Availability Local Transport",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_localTransport,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              // dropdown locality class
              Padding(
                padding: const EdgeInsets.only(right: 18),
                child: CustomDropDownTextField(
                  controller: localityClass,
                  labelText: 'Locality class',
                  items: [
                    DropDownValueModel(name: 'Rural', value: '1'),
                    DropDownValueModel(name: 'Urban', value: '2'),
                    DropDownValueModel(name: 'Semi Urban', value: '3'),
                  ],
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Locality Type",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_localityType,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),

              // Property Status
              sizedBoxWithContext(context, 0.03),
              Text('Property Status',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF475467))),
              sizedBoxWithContext(context, 0.03),
              // dropdown locality class
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Property Type",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_propertyType,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Ground Floor",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_groundfloor,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "First Floor",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_firstfloor,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              // Actual usage drawer

              // Structural Details
              sizedBoxWithContext(context, 0.03),
              Text('Structural Details',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF475467))),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Structure Type",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_structureType,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Plot Type",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_plotLocation,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Built Up Area (SFT)",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_builtUpArea,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Occupancy",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_structureOccupancy,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              // dropdown for electricity

              //Area Development & Maintenance
              sizedBoxWithContext(context, 0.03),
              Text('Area Development & Maintenance',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF475467))),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Surrounding Area Development",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_surroundingAreaDevelopment,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Total Built Up Area",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_totalBuiltUpArea,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Quality of Construction",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_qualityConstruction,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CustomTextFormField(
                        inerHint: 'Property Age',
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: propertyDetailForm_propertyAge,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CustomTextFormField(
                        inerHint: 'Projected Life Year',
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: propertyDetailForm_projectLifeYear,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                      ),
                    ),
                  ],
                ),
              ),

              //Valuation & Construction
              sizedBoxWithContext(context, 0.03),
              Text('Valuation & Construction',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF475467))),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Property Maintenance",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_propertyMaintain,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),

              Padding(
                padding: const EdgeInsets.only(right: 18),
                child: CustomDropDownTextField(
                  labelText: 'Construction Type',
                  items: [
                    DropDownValueModel(name: 'Kachha', value: 'Kachha'),
                    DropDownValueModel(name: 'Pakka', value: 'Pakka'),
                    DropDownValueModel(name: 'RCC', value: 'RCC'),
                  ],
                  controller: propertyDetailForm_constructionType,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CustomTextFormField(
                        inerHint: 'Land Rate Per SQ FT',
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: propertyDetailForm_landRate,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CustomTextFormField(
                        inerHint: 'Total Cons. Area SQ FT',
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: propertyDetailForm_totalCons,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                      ),
                    ),
                  ],
                ),
              ),
              sizedBoxWithContext(context, 0.03),

              Padding(
                padding: const EdgeInsets.only(right: 18),
                child: CustomDropDownTextField(
                  labelText: 'Development of surrounding area',
                  items: [
                    DropDownValueModel(name: '10-20%', value: '10-20%'),
                    DropDownValueModel(name: '20-30%', value: '20-30%'),
                    DropDownValueModel(name: '30-40%', value: '30-40%'),
                    DropDownValueModel(name: '40-50%', value: '40-50%'),
                    DropDownValueModel(name: '50-60%', value: '50-60%'),
                    DropDownValueModel(name: '60-70%', value: '60-70%'),
                    DropDownValueModel(name: '70-80%', value: '70-80%'),
                    DropDownValueModel(name: '80-90%', value: '80-90%'),
                    DropDownValueModel(name: '90-100%', value: '90-100%'),
                  ],
                  controller: devlopmentOfSurroundingArea,
                ),
              ),
              //Customer Documentation
              sizedBoxWithContext(context, 0.03),
              Text('Customer Documentation',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF475467))),
              sizedBoxWithContext(context, 0.03),
              // Text('Selfie With Customer'),
//               ListView.builder(
//                 shrinkWrap: true, // Prevents ListView from taking infinite height
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: images.length,
//                 itemBuilder: (context, index) {
//                   print('images: ${images.length}');
//                   final imagesList = images[index];

//                   return imagesList.file == null
//                       ? GestureDetector(
//                           // onTap: () => ref
//                           //     .read(imageCollectionProvider.notifier)
//                           //     .pickImage(imagesList.title!),
//                                 onTap: () async {
//   try {
//     // Step 1: Pick the image
//     final pickedFile = await ref
//         .read(imageCollectionProvider.notifier)
//         .pickImage(imagesList.title!);

//     if (pickedFile != null) {
//       // Step 2: Get the image path
//       String? imagePath = pickedFile.path;
//       print('Picked image path: $imagePath');

//       // Step 3: Upload the image and get the URL
//       final uploadedUrl = await ref
//           .read(selfieWithCustomerUrlProvider.notifier)
//           .uploadImage(imagePath);

//       // Step 4: Store the uploaded URL
//       setState(() {
//         photoWithLatLong = uploadedUrl; // Store the image URL
//       });

//       print('Uploaded image URL: $photoWithLatLong');
//     } else {
//       print('No image selected.');
//     }
//   } catch (error) {
//     print('Error during image selection/upload: $error');
//   }
// },

//                           child: UploadBox(
//                             isImage: true,
//                             height: displayHeight(context) * 0.16,
//                             width: displayWidth(context) * 0.91,
//                             color: AppColors.buttonBorderGray,
//                             iconData: Icons.file_upload_outlined,
//                             textColor: AppColors.gray5,
//                             subTextColor: AppColors.primary,
//                             title: 'Support: JPG, PNG',
//                             subTitle: imagesList.title,
//                           ),
//                         )
//                       : Stack(
//                           children: [
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(right: 15, top: 10),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: Image.file(
//                                   File(imagesList.file!.path),
//                                   height: displayHeight(context) * 0.16,
//                                   width: displayWidth(context) * 0.91,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               right: 10,
//                               top: 3,
//                               child: GestureDetector(
//                                 onTap: () => ref
//                                     .read(imageCollectionProvider.notifier)
//                                     .removeImage(imagesList.title!),
//                                 child: Image.asset(
//                                   'assets/images/remove.png',
//                                   height: 25,
//                                   width: 25,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                 },
//               ),

              // next Button
              sizedBoxWithContext(context, 0.03),

              // Text('Selfie With Customer'),
              // photowithLatLong == null
              //     ? GestureDetector(
              //         onTap: () {
              //           // String? imagePath;

              //           ref
              //               .read(selfieWithCustomerUrlProvider.notifier)
              //               .pickSelfie()
              //               .then(
              //             (value) {
              //               if (value != null) {
              //                 String? imagePath = value.path;

              //                 //  paymentViewModel.updateTransactionImage(imagePath!);

              //                 print('imagepath of selfie ${imagePath}');
              //                 ref
              //                     .read(selfieWithCustomerUrlProvider.notifier)
              //                     .uploadImage(value.path)
              //                     .then(
              //                   (value) {
              //                     setState(() {
              //                       photoWithLatLong = value;
              //                       // imgeUrl.add(value);

              //                       print('photoWithLatLong:: $selfieWith');
              //                       // print(
              //                       //     'imgeUrl length:: ${imgeUrl.length}');
              //                     });
              //                   },
              //                 );
              //               } else {
              //                 print('elsepart');
              //               }
              //             },
              //           );
              //         },
              //         child:
              //             //  isUploading!
              //             //     ? SizedBox(
              //             //         height: displayHeight(context) * 0.16,
              //             //         width: displayWidth(context) * 0.91,
              //             //         child: Center(
              //             //           child: CupertinoActivityIndicator(),
              //             //         ))
              //             //     :
              //             Padding(
              //           padding: const EdgeInsets.only(right: 15),
              //           child: UploadBox(
              //             isImage: true,
              //             height: displayHeight(context) * 0.16,
              //             width: displayWidth(context) * 0.91,
              //             color: AppColors.buttonBorderGray,
              //             iconData: Icons.file_upload_outlined,
              //             textColor: AppColors.gray5,
              //             subTextColor: AppColors.primary,
              //             title: 'Support: JPG, PNG',
              //             subTitle: 'Photo with latlong',
              //           ),
              //         ),
              //       )
              //     : Stack(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(right: 15, top: 10),
              //             child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(12),
              //                 child:
              //                     // sssmidimage.image != null ||
              //                     //         sssmidimage.image?.path != null
              //                     // ?
              //                     Image.file(
              //                   File(uploadselfie.image!.path),
              //                   height: displayHeight(context) * 0.16,
              //                   width: displayWidth(context) * 0.91,
              //                   fit: BoxFit.cover,
              //                 )
              //                 // : CachedNetworkImage(
              //                 //     imageUrl:
              //                 //         '${Api.baseUrl}${samagradata.sSSMPhoto!}',
              //                 //     height: displayHeight(context) * 0.16,
              //                 //     width: displayWidth(context) * 0.91,
              //                 //     fit: BoxFit.cover,
              //                 //     placeholder: (context, url) => const Center(
              //                 //       child: CircularProgressIndicator(),
              //                 //     ),
              //                 //     errorWidget: (context, url, error) =>
              //                 //         Image.asset(
              //                 //       'assets/images/no_internet.jpg',
              //                 //       height: 56,
              //                 //       width: 56,
              //                 //       fit: BoxFit.cover,
              //                 //     ),
              //                 //   ),
              //                 ),
              //           ),
              //           Positioned(
              //             right: 10,
              //             top: 3,
              //             child: GestureDetector(
              //               onTap: () {
              //                 // Clear the samagradata.sSSMPhoto field and update UI
              //                 // if (samagradata.sSSMPhoto != null &&
              //                 //     samagradata.sSSMPhoto!.isNotEmpty) {
              //                 //   setState(() {
              //                 //     samagradata.sSSMPhoto =
              //                 //         ''; // Clear the locally stored URL if needed
              //                 //   });
              //                 // } else {
              //                 //   ref
              //                 //       .read(sssMidimageProvider.notifier)
              //                 //       .removeFirstImage();
              //                 // }
              //                 ref
              //                     .read(selfieWithCustomerUrlProvider.notifier)
              //                     .removeSecondImage();
              //               },
              //               child: Image.asset(
              //                 'assets/images/remove.png',
              //                 height: 25,
              //                 width: 25,
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),

              // next Button
              // sizedBoxWithContext(context, 0.03),

              // // Text('Photo with Lat Long'),
              // uploadselfie.image == null
              //     ? GestureDetector(
              //         onTap: () {
              //           // String? imagePath;

              //           ref
              //               .read(sssMidimageProvider.notifier)
              //               .pickFirstImage()
              //               .then(
              //             (value) {
              //               if (value != null) {
              //                 String? imagePath = value.path;

              //                 //  paymentViewModel.updateTransactionImage(imagePath!);

              //                 print('imagepath of selfie ${imagePath}');
              //                 ref
              //                     .read(sssMidimageProvider.notifier)
              //                     .uploadImage(value.path)
              //                     .then(
              //                   (value) {
              //                     setState(() {
              //                       photoWithLatLong = value;
              //                       // imgeUrl.add(value);

              //                       print(
              //                           'photoWithLatLongurl:: $photoWithLatLong');
              //                       // print(
              //                       //     'imgeUrl length:: ${imgeUrl.length}');
              //                     });
              //                   },
              //                 );
              //               } else {
              //                 print('elsepart');
              //               }
              //             },
              //           );
              //         },
              //         child:
              //             //  isUploading!
              //             //     ? SizedBox(
              //             //         height: displayHeight(context) * 0.16,
              //             //         width: displayWidth(context) * 0.91,
              //             //         child: Center(
              //             //           child: CupertinoActivityIndicator(),
              //             //         ))
              //             //     :
              //             Padding(
              //           padding: const EdgeInsets.only(right: 15),
              //           child: UploadBox(
              //             isImage: true,
              //             height: displayHeight(context) * 0.16,
              //             width: displayWidth(context) * 0.91,
              //             color: AppColors.buttonBorderGray,
              //             iconData: Icons.file_upload_outlined,
              //             textColor: AppColors.gray5,
              //             subTextColor: AppColors.primary,
              //             title: 'Support: JPG, PNG',
              //             subTitle: 'Click SSMID Image',
              //           ),
              //         ),
              //       )
              //     : Stack(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(right: 15, top: 10),
              //             child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(12),
              //                 child:
              //                     // sssmidimage.image != null ||
              //                     //         sssmidimage.image?.path != null
              //                     // ?
              //                     Image.file(
              //                   File(uploadselfie.image!.path),
              //                   height: displayHeight(context) * 0.16,
              //                   width: displayWidth(context) * 0.91,
              //                   fit: BoxFit.cover,
              //                 )
              //                 // : CachedNetworkImage(
              //                 //     imageUrl:
              //                 //         '${Api.baseUrl}${samagradata.sSSMPhoto!}',
              //                 //     height: displayHeight(context) * 0.16,
              //                 //     width: displayWidth(context) * 0.91,
              //                 //     fit: BoxFit.cover,
              //                 //     placeholder: (context, url) => const Center(
              //                 //       child: CircularProgressIndicator(),
              //                 //     ),
              //                 //     errorWidget: (context, url, error) =>
              //                 //         Image.asset(
              //                 //       'assets/images/no_internet.jpg',
              //                 //       height: 56,
              //                 //       width: 56,
              //                 //       fit: BoxFit.cover,
              //                 //     ),
              //                 //   ),
              //                 ),
              //           ),
              //           Positioned(
              //             right: 10,
              //             top: 3,
              //             child: GestureDetector(
              //               onTap: () {
              //                 // Clear the samagradata.sSSMPhoto field and update UI
              //                 // if (samagradata.sSSMPhoto != null &&
              //                 //     samagradata.sSSMPhoto!.isNotEmpty) {
              //                 //   setState(() {
              //                 //     samagradata.sSSMPhoto =
              //                 //         ''; // Clear the locally stored URL if needed
              //                 //   });
              //                 // } else {
              //                 //   ref
              //                 //       .read(sssMidimageProvider.notifier)
              //                 //       .removeFirstImage();
              //                 // }
              //                 ref
              //                     .read(sssMidimageProvider.notifier)
              //                     .removeFirstImage();
              //               },
              //               child: Image.asset(
              //                 'assets/images/remove.png',
              //                 height: 25,
              //                 width: 25,
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),

              // // next Button
              // sizedBoxWithContext(context, 0.03),
              // Text('Photo with Lat Long'),
              // uploadselfie.image == null
              //     ? GestureDetector(
              //         onTap: () {
              //           // String? imagePath;

              //           ref
              //               .read(sssMidimageProvider.notifier)
              //               .pickFirstImage()
              //               .then(
              //             (value) {
              //               if (value != null) {
              //                 String? imagePath = value.path;

              //                 //  paymentViewModel.updateTransactionImage(imagePath!);

              //                 print('imagepath of selfie ${imagePath}');
              //                 ref
              //                     .read(sssMidimageProvider.notifier)
              //                     .uploadImage(value.path)
              //                     .then(
              //                   (value) {
              //                     setState(() {
              //                       frontImage = value;
              //                       // imgeUrl.add(value);

              //                       print('frontImageurl:: $frontImage');
              //                       // print(
              //                       //     'imgeUrl length:: ${imgeUrl.length}');
              //                     });
              //                   },
              //                 );
              //               } else {
              //                 print('elsepart');
              //               }
              //             },
              //           );
              //         },
              //         child:
              //             //  isUploading!
              //             //     ? SizedBox(
              //             //         height: displayHeight(context) * 0.16,
              //             //         width: displayWidth(context) * 0.91,
              //             //         child: Center(
              //             //           child: CupertinoActivityIndicator(),
              //             //         ))
              //             //     :
              //             Padding(
              //           padding: const EdgeInsets.only(right: 15),
              //           child: UploadBox(
              //             isImage: true,
              //             height: displayHeight(context) * 0.16,
              //             width: displayWidth(context) * 0.91,
              //             color: AppColors.buttonBorderGray,
              //             iconData: Icons.file_upload_outlined,
              //             textColor: AppColors.gray5,
              //             subTextColor: AppColors.primary,
              //             title: 'Support: JPG, PNG',
              //             subTitle: 'Click SSMID Image',
              //           ),
              //         ),
              //       )
              //     : Stack(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(right: 15, top: 10),
              //             child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(12),
              //                 child:
              //                     // sssmidimage.image != null ||
              //                     //         sssmidimage.image?.path != null
              //                     // ?
              //                     Image.file(
              //                   File(uploadselfie.image!.path),
              //                   height: displayHeight(context) * 0.16,
              //                   width: displayWidth(context) * 0.91,
              //                   fit: BoxFit.cover,
              //                 )
              //                 // : CachedNetworkImage(
              //                 //     imageUrl:
              //                 //         '${Api.baseUrl}${samagradata.sSSMPhoto!}',
              //                 //     height: displayHeight(context) * 0.16,
              //                 //     width: displayWidth(context) * 0.91,
              //                 //     fit: BoxFit.cover,
              //                 //     placeholder: (context, url) => const Center(
              //                 //       child: CircularProgressIndicator(),
              //                 //     ),
              //                 //     errorWidget: (context, url, error) =>
              //                 //         Image.asset(
              //                 //       'assets/images/no_internet.jpg',
              //                 //       height: 56,
              //                 //       width: 56,
              //                 //       fit: BoxFit.cover,
              //                 //     ),
              //                 //   ),
              //                 ),
              //           ),
              //           Positioned(
              //             right: 10,
              //             top: 3,
              //             child: GestureDetector(
              //               onTap: () {
              //                 // Clear the samagradata.sSSMPhoto field and update UI
              //                 // if (samagradata.sSSMPhoto != null &&
              //                 //     samagradata.sSSMPhoto!.isNotEmpty) {
              //                 //   setState(() {
              //                 //     samagradata.sSSMPhoto =
              //                 //         ''; // Clear the locally stored URL if needed
              //                 //   });
              //                 // } else {
              //                 //   ref
              //                 //       .read(sssMidimageProvider.notifier)
              //                 //       .removeFirstImage();
              //                 // }
              //                 ref
              //                     .read(sssMidimageProvider.notifier)
              //                     .removeFirstImage();
              //               },
              //               child: Image.asset(
              //                 'assets/images/remove.png',
              //                 height: 25,
              //                 width: 25,
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),

              // // next Button
              // sizedBoxWithContext(context, 0.03),
              // Text('Photo with Lat Long'),
              // uploadselfie.image == null
              //     ? GestureDetector(
              //         onTap: () {
              //           // String? imagePath;

              //           ref
              //               .read(sssMidimageProvider.notifier)
              //               .pickFirstImage()
              //               .then(
              //             (value) {
              //               if (value != null) {
              //                 String? imagePath = value.path;

              //                 //  paymentViewModel.updateTransactionImage(imagePath!);

              //                 print('imagepath of selfie ${imagePath}');
              //                 ref
              //                     .read(sssMidimageProvider.notifier)
              //                     .uploadImage(value.path)
              //                     .then(
              //                   (value) {
              //                     setState(() {
              //                       leftSide = value;
              //                       // imgeUrl.add(value);

              //                       print('leftSideurl:: $leftSide');
              //                       // print(
              //                       //     'imgeUrl length:: ${imgeUrl.length}');
              //                     });
              //                   },
              //                 );
              //               } else {
              //                 print('elsepart');
              //               }
              //             },
              //           );
              //         },
              //         child:
              //             //  isUploading!
              //             //     ? SizedBox(
              //             //         height: displayHeight(context) * 0.16,
              //             //         width: displayWidth(context) * 0.91,
              //             //         child: Center(
              //             //           child: CupertinoActivityIndicator(),
              //             //         ))
              //             //     :
              //             Padding(
              //           padding: const EdgeInsets.only(right: 15),
              //           child: UploadBox(
              //             isImage: true,
              //             height: displayHeight(context) * 0.16,
              //             width: displayWidth(context) * 0.91,
              //             color: AppColors.buttonBorderGray,
              //             iconData: Icons.file_upload_outlined,
              //             textColor: AppColors.gray5,
              //             subTextColor: AppColors.primary,
              //             title: 'Support: JPG, PNG',
              //             subTitle: 'Click SSMID Image',
              //           ),
              //         ),
              //       )
              //     : Stack(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(right: 15, top: 10),
              //             child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(12),
              //                 child:
              //                     // sssmidimage.image != null ||
              //                     //         sssmidimage.image?.path != null
              //                     // ?
              //                     Image.file(
              //                   File(uploadselfie.image!.path),
              //                   height: displayHeight(context) * 0.16,
              //                   width: displayWidth(context) * 0.91,
              //                   fit: BoxFit.cover,
              //                 )
              //                 // : CachedNetworkImage(
              //                 //     imageUrl:
              //                 //         '${Api.baseUrl}${samagradata.sSSMPhoto!}',
              //                 //     height: displayHeight(context) * 0.16,
              //                 //     width: displayWidth(context) * 0.91,
              //                 //     fit: BoxFit.cover,
              //                 //     placeholder: (context, url) => const Center(
              //                 //       child: CircularProgressIndicator(),
              //                 //     ),
              //                 //     errorWidget: (context, url, error) =>
              //                 //         Image.asset(
              //                 //       'assets/images/no_internet.jpg',
              //                 //       height: 56,
              //                 //       width: 56,
              //                 //       fit: BoxFit.cover,
              //                 //     ),
              //                 //   ),
              //                 ),
              //           ),
              //           Positioned(
              //             right: 10,
              //             top: 3,
              //             child: GestureDetector(
              //               onTap: () {
              //                 // Clear the samagradata.sSSMPhoto field and update UI
              //                 // if (samagradata.sSSMPhoto != null &&
              //                 //     samagradata.sSSMPhoto!.isNotEmpty) {
              //                 //   setState(() {
              //                 //     samagradata.sSSMPhoto =
              //                 //         ''; // Clear the locally stored URL if needed
              //                 //   });
              //                 // } else {
              //                 //   ref
              //                 //       .read(sssMidimageProvider.notifier)
              //                 //       .removeFirstImage();
              //                 // }
              //                 ref
              //                     .read(sssMidimageProvider.notifier)
              //                     .removeFirstImage();
              //               },
              //               child: Image.asset(
              //                 'assets/images/remove.png',
              //                 height: 25,
              //                 width: 25,
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),

              // // next Button
              // sizedBoxWithContext(context, 0.03),
              // Text('Photo with Lat Long'),
              // uploadselfie.image == null
              //     ? GestureDetector(
              //         onTap: () {
              //           // String? imagePath;

              //           ref
              //               .read(sssMidimageProvider.notifier)
              //               .pickFirstImage()
              //               .then(
              //             (value) {
              //               if (value != null) {
              //                 String? imagePath = value.path;

              //                 //  paymentViewModel.updateTransactionImage(imagePath!);

              //                 print('imagepath of selfie ${imagePath}');
              //                 ref
              //                     .read(sssMidimageProvider.notifier)
              //                     .uploadImage(value.path)
              //                     .then(
              //                   (value) {
              //                     setState(() {
              //                       rightSide = value;
              //                       // imgeUrl.add(value);

              //                       print('rightSide:: $rightSide');
              //                       // print(
              //                       //     'imgeUrl length:: ${imgeUrl.length}');
              //                     });
              //                   },
              //                 );
              //               } else {
              //                 print('elsepart');
              //               }
              //             },
              //           );
              //         },
              //         child:
              //             //  isUploading!
              //             //     ? SizedBox(
              //             //         height: displayHeight(context) * 0.16,
              //             //         width: displayWidth(context) * 0.91,
              //             //         child: Center(
              //             //           child: CupertinoActivityIndicator(),
              //             //         ))
              //             //     :
              //             Padding(
              //           padding: const EdgeInsets.only(right: 15),
              //           child: UploadBox(
              //             isImage: true,
              //             height: displayHeight(context) * 0.16,
              //             width: displayWidth(context) * 0.91,
              //             color: AppColors.buttonBorderGray,
              //             iconData: Icons.file_upload_outlined,
              //             textColor: AppColors.gray5,
              //             subTextColor: AppColors.primary,
              //             title: 'Support: JPG, PNG',
              //             subTitle: 'Click SSMID Image',
              //           ),
              //         ),
              //       )
              //     : Stack(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(right: 15, top: 10),
              //             child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(12),
              //                 child:
              //                     // sssmidimage.image != null ||
              //                     //         sssmidimage.image?.path != null
              //                     // ?
              //                     Image.file(
              //                   File(uploadselfie.image!.path),
              //                   height: displayHeight(context) * 0.16,
              //                   width: displayWidth(context) * 0.91,
              //                   fit: BoxFit.cover,
              //                 )
              //                 // : CachedNetworkImage(
              //                 //     imageUrl:
              //                 //         '${Api.baseUrl}${samagradata.sSSMPhoto!}',
              //                 //     height: displayHeight(context) * 0.16,
              //                 //     width: displayWidth(context) * 0.91,
              //                 //     fit: BoxFit.cover,
              //                 //     placeholder: (context, url) => const Center(
              //                 //       child: CircularProgressIndicator(),
              //                 //     ),
              //                 //     errorWidget: (context, url, error) =>
              //                 //         Image.asset(
              //                 //       'assets/images/no_internet.jpg',
              //                 //       height: 56,
              //                 //       width: 56,
              //                 //       fit: BoxFit.cover,
              //                 //     ),
              //                 //   ),
              //                 ),
              //           ),
              //           Positioned(
              //             right: 10,
              //             top: 3,
              //             child: GestureDetector(
              //               onTap: () {
              //                 // Clear the samagradata.sSSMPhoto field and update UI
              //                 // if (samagradata.sSSMPhoto != null &&
              //                 //     samagradata.sSSMPhoto!.isNotEmpty) {
              //                 //   setState(() {
              //                 //     samagradata.sSSMPhoto =
              //                 //         ''; // Clear the locally stored URL if needed
              //                 //   });
              //                 // } else {
              //                 //   ref
              //                 //       .read(sssMidimageProvider.notifier)
              //                 //       .removeFirstImage();
              //                 // }
              //                 ref
              //                     .read(sssMidimageProvider.notifier)
              //                     .removeFirstImage();
              //               },
              //               child: Image.asset(
              //                 'assets/images/remove.png',
              //                 height: 25,
              //                 width: 25,
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),

              // // next Button
              // sizedBoxWithContext(context, 0.03),
              // Text('Photo with Lat Long'),
              // uploadselfie.image == null
              //     ? GestureDetector(
              //         onTap: () {
              //           // String? imagePath;

              //           ref
              //               .read(sssMidimageProvider.notifier)
              //               .pickFirstImage()
              //               .then(
              //             (value) {
              //               if (value != null) {
              //                 String? imagePath = value.path;

              //                 //  paymentViewModel.updateTransactionImage(imagePath!);

              //                 print('imagepath of selfie ${imagePath}');
              //                 ref
              //                     .read(sssMidimageProvider.notifier)
              //                     .uploadImage(value.path)
              //                     .then(
              //                   (value) {
              //                     setState(() {
              //                       approachRoad = value;
              //                       // imgeUrl.add(value);

              //                       print('approachRoad:: $approachRoad');
              //                       // print(
              //                       //     'imgeUrl length:: ${imgeUrl.length}');
              //                     });
              //                   },
              //                 );
              //               } else {
              //                 print('elsepart');
              //               }
              //             },
              //           );
              //         },
              //         child:
              //             //  isUploading!
              //             //     ? SizedBox(
              //             //         height: displayHeight(context) * 0.16,
              //             //         width: displayWidth(context) * 0.91,
              //             //         child: Center(
              //             //           child: CupertinoActivityIndicator(),
              //             //         ))
              //             //     :
              //             Padding(
              //           padding: const EdgeInsets.only(right: 15),
              //           child: UploadBox(
              //             isImage: true,
              //             height: displayHeight(context) * 0.16,
              //             width: displayWidth(context) * 0.91,
              //             color: AppColors.buttonBorderGray,
              //             iconData: Icons.file_upload_outlined,
              //             textColor: AppColors.gray5,
              //             subTextColor: AppColors.primary,
              //             title: 'Support: JPG, PNG',
              //             subTitle: 'Click SSMID Image',
              //           ),
              //         ),
              //       )
              //     : Stack(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(right: 15, top: 10),
              //             child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(12),
              //                 child:
              //                     // sssmidimage.image != null ||
              //                     //         sssmidimage.image?.path != null
              //                     // ?
              //                     Image.file(
              //                   File(uploadselfie.image!.path),
              //                   height: displayHeight(context) * 0.16,
              //                   width: displayWidth(context) * 0.91,
              //                   fit: BoxFit.cover,
              //                 )
              //                 // : CachedNetworkImage(
              //                 //     imageUrl:
              //                 //         '${Api.baseUrl}${samagradata.sSSMPhoto!}',
              //                 //     height: displayHeight(context) * 0.16,
              //                 //     width: displayWidth(context) * 0.91,
              //                 //     fit: BoxFit.cover,
              //                 //     placeholder: (context, url) => const Center(
              //                 //       child: CircularProgressIndicator(),
              //                 //     ),
              //                 //     errorWidget: (context, url, error) =>
              //                 //         Image.asset(
              //                 //       'assets/images/no_internet.jpg',
              //                 //       height: 56,
              //                 //       width: 56,
              //                 //       fit: BoxFit.cover,
              //                 //     ),
              //                 //   ),
              //                 ),
              //           ),
              //           Positioned(
              //             right: 10,
              //             top: 3,
              //             child: GestureDetector(
              //               onTap: () {
              //                 // Clear the samagradata.sSSMPhoto field and update UI
              //                 // if (samagradata.sSSMPhoto != null &&
              //                 //     samagradata.sSSMPhoto!.isNotEmpty) {
              //                 //   setState(() {
              //                 //     samagradata.sSSMPhoto =
              //                 //         ''; // Clear the locally stored URL if needed
              //                 //   });
              //                 // } else {
              //                 //   ref
              //                 //       .read(sssMidimageProvider.notifier)
              //                 //       .removeFirstImage();
              //                 // }
              //                 ref
              //                     .read(sssMidimageProvider.notifier)
              //                     .removeFirstImage();
              //               },
              //               child: Image.asset(
              //                 'assets/images/remove.png',
              //                 height: 25,
              //                 width: 25,
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),

              // // next Button
              // sizedBoxWithContext(context, 0.03),
              // Text('Photo with Lat Long'),
              // uploadselfie.image == null
              //     ? GestureDetector(
              //         onTap: () {
              //           // String? imagePath;

              //           ref
              //               .read(sssMidimageProvider.notifier)
              //               .pickFirstImage()
              //               .then(
              //             (value) {
              //               if (value != null) {
              //                 String? imagePath = value.path;

              //                 //  paymentViewModel.updateTransactionImage(imagePath!);

              //                 print('imagepath of selfie ${imagePath}');
              //                 ref
              //                     .read(sssMidimageProvider.notifier)
              //                     .uploadImage(value.path)
              //                     .then(
              //                   (value) {
              //                     setState(() {
              //                       mainRoad = value;
              //                       // imgeUrl.add(value);

              //                       print('selfieWithUrl:: $selfieWith');
              //                       // print(
              //                       //     'imgeUrl length:: ${imgeUrl.length}');
              //                     });
              //                   },
              //                 );
              //               } else {
              //                 print('elsepart');
              //               }
              //             },
              //           );
              //         },
              //         child:
              //             //  isUploading!
              //             //     ? SizedBox(
              //             //         height: displayHeight(context) * 0.16,
              //             //         width: displayWidth(context) * 0.91,
              //             //         child: Center(
              //             //           child: CupertinoActivityIndicator(),
              //             //         ))
              //             //     :
              //             Padding(
              //           padding: const EdgeInsets.only(right: 15),
              //           child: UploadBox(
              //             isImage: true,
              //             height: displayHeight(context) * 0.16,
              //             width: displayWidth(context) * 0.91,
              //             color: AppColors.buttonBorderGray,
              //             iconData: Icons.file_upload_outlined,
              //             textColor: AppColors.gray5,
              //             subTextColor: AppColors.primary,
              //             title: 'Support: JPG, PNG',
              //             subTitle: 'Click SSMID Image',
              //           ),
              //         ),
              //       )
              //     : Stack(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(right: 15, top: 10),
              //             child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(12),
              //                 child:
              //                     // sssmidimage.image != null ||
              //                     //         sssmidimage.image?.path != null
              //                     // ?
              //                     Image.file(
              //                   File(uploadselfie.image!.path),
              //                   height: displayHeight(context) * 0.16,
              //                   width: displayWidth(context) * 0.91,
              //                   fit: BoxFit.cover,
              //                 )
              //                 // : CachedNetworkImage(
              //                 //     imageUrl:
              //                 //         '${Api.baseUrl}${samagradata.sSSMPhoto!}',
              //                 //     height: displayHeight(context) * 0.16,
              //                 //     width: displayWidth(context) * 0.91,
              //                 //     fit: BoxFit.cover,
              //                 //     placeholder: (context, url) => const Center(
              //                 //       child: CircularProgressIndicator(),
              //                 //     ),
              //                 //     errorWidget: (context, url, error) =>
              //                 //         Image.asset(
              //                 //       'assets/images/no_internet.jpg',
              //                 //       height: 56,
              //                 //       width: 56,
              //                 //       fit: BoxFit.cover,
              //                 //     ),
              //                 //   ),
              //                 ),
              //           ),
              //           Positioned(
              //             right: 10,
              //             top: 3,
              //             child: GestureDetector(
              //               onTap: () {
              //                 // Clear the samagradata.sSSMPhoto field and update UI
              //                 // if (samagradata.sSSMPhoto != null &&
              //                 //     samagradata.sSSMPhoto!.isNotEmpty) {
              //                 //   setState(() {
              //                 //     samagradata.sSSMPhoto =
              //                 //         ''; // Clear the locally stored URL if needed
              //                 //   });
              //                 // } else {
              //                 //   ref
              //                 //       .read(sssMidimageProvider.notifier)
              //                 //       .removeFirstImage();
              //                 // }
              //                 ref
              //                     .read(sssMidimageProvider.notifier)
              //                     .removeFirstImage();
              //               },
              //               child: Image.asset(
              //                 'assets/images/remove.png',
              //                 height: 25,
              //                 width: 25,
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),

              // next Button
              sizedBoxWithContext(context, 0.03),

              appState.isLoading == true
                  ? const SizedBox(
                      width: 24, // Specify the width
                      height: 24, // Specify the height
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                        strokeWidth: 5,
                        key: ValueKey('loading'), // Key for progress indicator
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        // Create an instance of Property and populate it with the required details
                        Property propertyDetails = Property(
                          // propertyOwnerName: 'John Doe',
                          relationWithApplicant:
                              propertyDetailForm_relationApplicant.text,
                          villageName: propertyDetailForm_villageName.text,
                          gramPanchayat: propertyDetailForm_panchayatName.text,
                          patwariHalkaNo: propertyDetailForm_patwariNo.text,
                          state: propertyDetailForm_stateName.text,
                          district: propertyDetailForm_districtName.text,
                          tehsil: propertyDetailForm_tehsilName.text,
                          houseNo: propertyDetailForm_houseNo.text,
                          wardNo: propertyDetailForm_wardNo.text,
                          surveyNo: propertyDetailForm_surveyNo.text,
                          totalBuilUpArea:
                              propertyDetailForm_totalBuiltUpArea.text,
                          qualityOfConstruction:
                              propertyDetailForm_qualityConstruction.text,
                          ageOfProperty: propertyDetailForm_propertyAge.text,
                          maintenanceOfTheProperty:
                              propertyDetailForm_propertyMaintain.text,
                          projectedLifeYear:
                              propertyDetailForm_projectLifeYear.text,
                          typeOfContruction:
                              propertyDetailForm_constructionType.text,
                          landRatePerSQFT: propertyDetailForm_landRate.text,
                          totalConstruction: propertyDetailForm_totalCons.text,
                          fatherName: propertyDetailForm_fatherName.text,
                          latitudeOfTheProrty:
                              propertyDetailForm_propertyLatitude.text,
                          longitudeOfTheProrty:
                              propertyDetailForm_propertyLongitude.text,
                          doorsAndWindowsAreAvailable:
                              propertyDetailForm_doorAndWindow.text,
                          kitchenAndLatBathAvailable:
                              propertyDetailForm_kitchenAndLat.text,
                          // assetSeenAtResidence: ['Fan', 'Bed', 'Table'], // Example list
                          //assetSeenAtResidence: propertyDetailForm_assetResidence,
                          collateralsDetails: CollateralsDetails(
                            nameOfTheDocumentHolder:
                                propertyDetailForm_bankHolderName.text,
                            documentsProvided:
                                propertyDetailForm_documentProvided.text,
                            propertyAddress:
                                propertyDetailForm_propertyAddress.text,
                            landmark: propertyDetailForm_landMark.text,
                            locationZone: propertyDetailForm_locaZone.text,
                            availabilityOfLocalTransport:
                                propertyDetailForm_localTransport.text,
                            classOfLocality:
                                propertyDetailForm_localityClass.text,
                            typeOfLocality:
                                propertyDetailForm_localityType.text,
                            // asPerSite: propertyDetailForm_aspersite.text,
                            boundariesMatching:
                                propertyDetailForm_boundariesPatta.text,
                            statusOfTheLandFlat:
                                propertyDetailForm_landflatStatus.text,
                            typeOfProperty:
                                propertyDetailForm_propertyType.text,
                            boundariesEast: propertyDetailForm_eastName.text,
                            boundariesWest: propertyDetailForm_westName.text,
                            boundariesNorth: propertyDetailForm_northName.text,
                            boundariesSouth: propertyDetailForm_southName.text,
                          ),
                          accommodationDetails: AccommodationDetails(
                            groundFloor: propertyDetailForm_groundfloor.text,
                            firstFloor: propertyDetailForm_firstfloor.text,
                            // actualUsageOfProperty: propertyDetailForm_prop.text,
                            typeOfStructure:
                                propertyDetailForm_structureType.text,
                            locationOfPlot:
                                propertyDetailForm_plotLocation.text,
                            builtUpAreaSft: propertyDetailForm_builtUpArea.text,
                            occupancy:
                                propertyDetailForm_structureOccupancy.text,
                            electricityAndGasConnection: 'Available',
                            developmentOfSurroundingArea:
                                propertyDetailForm_surroundingAreaDevelopment
                                    .text,
                          ),
                        );

                        // Call the provider method with the populated Property object
                        ref
                            .read(pdsubmitpropertyFormProvider.notifier)
                            .submitpdpropertyForm(
                              customerId: '66f53ffbd7011eb65160f292',
                              pdType: 'creditPd',
                              propertty: propertyDetails,
                            )
                            .then((value) {
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  'Changes saved succesfully',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  'Form not saved please try again',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            );
                          }
                        });
                      },
                      child: Text(
                        'Next',
                        style: AppStyles.whiteText16,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

//  Widget _buildImagePreview(SssMidImageState imageState, StateNotifierProvider provider) {
//     return Stack(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(right: 15, top: 10),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Image.file(
//               File(imageState.image!.path),
//               height: displayHeight(context) * 0.16,
//               width: displayWidth(context) * 0.91,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Positioned(
//           right: 10,
//           top: 3,
//           child: GestureDetector(
//             onTap: () {
//               ref.read(provider.notifier).removeFirstImage();
//             },
//             child: Image.asset(
//               'assets/images/remove.png',
//               height: 25,
//               width: 25,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
}
