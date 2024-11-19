import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/ui/PD/common_textfield.dart';
import 'package:finexe/feature/ui/PD/pd_fromfilds.dart/Common%20Dropdown/common_dropdown.dart';
import 'package:flutter/material.dart';

class Propertycollateral extends StatefulWidget {
  const Propertycollateral({super.key});

  @override
  State<Propertycollateral> createState() => _PropertycollateralState();
}

class _PropertycollateralState extends State<Propertycollateral> {
  TextEditingController propertyDetailForm_bankHolderName =
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
  TextEditingController propertyDetailForm_transportLocation =
      TextEditingController();
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

  @override
  Widget build(BuildContext context) {
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
                  controller: propertyDetailForm_tehsilName,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
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
                  textInputType: TextInputType.name,
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

              // dropdown asset Residence
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
                  controller: propertyDetailForm_transportLocation,
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
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: "Construction Type",
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: propertyDetailForm_constructionType,
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

              //Customer Documentation
              sizedBoxWithContext(context, 0.03),
              Text('Customer Documentation',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF475467))),
              sizedBoxWithContext(context, 0.03),

              // next Button
              sizedBoxWithContext(context, 0.03),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              'Form submitted successfully!',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            )),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Please fill all required details!',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            )),
                      );
                    }
                  },
                  child: InkWell(
                    onTap: () {
                      print('inter');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => CustomerDetail()),
                      // );
                    },
                    child: Text('Next'),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
