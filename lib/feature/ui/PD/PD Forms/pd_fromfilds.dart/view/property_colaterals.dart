
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/property_form_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/co-applicant_form.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/property_vmodel.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/samagra_details_viewmodel.dart';
// import 'package:finexe/feature/ui/PD/view/common%20imagePicker/dynamic_listing_images.dart';
// import 'package:finexe/feature/ui/PD/view/common%20imagePicker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Common Widgets/simple_dropdown.dart';
import '../../../common imagePicker/dynamic_listing_images.dart';
import '../../../common imagePicker/image_picker.dart';
import '../model/Submit Data Models/property_form_model.dart';
import '../view_model.dart/property_vmodel.dart';
import 'co-applicant_form.dart';

final isExpPropertyCollProvider = StateProvider<bool>((ref) => false);

class Propertycollateral extends ConsumerStatefulWidget {
  // const Propertycollateral({super.key});
  final String customerId;
  const Propertycollateral({super.key, required this.customerId});
  @override
  ConsumerState<Propertycollateral> createState() => _PropertycollateralState();
}

class _PropertycollateralState extends ConsumerState<Propertycollateral> {
  // Initialize all controllers
  late TextEditingController incomeSourceTypecontroller;
  late TextEditingController devlopmentOfSurroundingArea;
  late TextEditingController localityClass;

  // Property collateral
  late TextEditingController propertyDetailForm_documentHolderName;
  late TextEditingController propertyDetailForm_selectStatusofPropety;
  late TextEditingController propertyDetailForm_relationApplicant;
  late TextEditingController propertyDetailForm_fatherName;
  late TextEditingController propertyDetailForm_villageName;
  late TextEditingController propertyDetailForm_panchayatName;

  // Location details
  late TextEditingController propertyDetailForm_stateName;
  late TextEditingController propertyDetailForm_districtName;
  late TextEditingController propertyDetailForm_tehsilName;
  late TextEditingController propertyDetailForm_patwariNo;
  late TextEditingController propertyDetailForm_wardNo;
  late TextEditingController propertyDetailForm_surveyNo;

  // Property boundaries
  late TextEditingController propertyDetailForm_houseNo;
  late TextEditingController propertyDetailForm_eastName;
  late TextEditingController propertyDetailForm_westName;
  late TextEditingController propertyDetailForm_northName;
  late TextEditingController propertyDetailForm_southName;

  // Property documentation
  late TextEditingController propertyDetailForm_documentProvided;
  late TextEditingController propertyDetailForm_boundariesPatta;
  late TextEditingController propertyDetailForm_propertyAddress;
  late TextEditingController propertyDetailForm_docHolderName;

  // Property coordinates & features
  late TextEditingController propertyDetailForm_propertyLatitude;
  late TextEditingController propertyDetailForm_propertyLongitude;
  late TextEditingController propertyDetailForm_doorAndWindow;
  late TextEditingController propertyDetailForm_kitchenAndLat;
  late TextEditingController propertyDetailForm_assetResidence;

  // Surrounding area and transport
  late TextEditingController propertyDetailForm_landMark;
  late TextEditingController propertyDetailForm_locaZone;
  late TextEditingController propertyDetailForm_localTransport;
  late TextEditingController propertyDetailForm_localityClass;
  late TextEditingController propertyDetailForm_localityType;
  late TextEditingController typeOfPropertyPaper;

  // Property Status
  late TextEditingController propertyDetailForm_landflatStatus;
  late TextEditingController propertyDetailForm_propertyType;
  late TextEditingController propertyDetailForm_groundfloor;
  late TextEditingController propertyDetailForm_firstfloor;
  late TextEditingController propertyDetailForm_usagesType;

  // Structural Details
  late TextEditingController propertyDetailForm_structureType;
  late TextEditingController propertyDetailForm_plotLocation;
  late TextEditingController propertyDetailForm_builtUpArea;
  late TextEditingController propertyDetailForm_structureOccupancy;
  late TextEditingController propertyDetailForm_electricityAndGas;
  late TextEditingController actualUsageoFProperty;
  // Area Development
  late TextEditingController propertyDetailForm_surroundingAreaDevelopment;
  late TextEditingController propertyDetailForm_totalBuiltUpArea;
  late TextEditingController propertyDetailForm_qualityConstruction;
  late TextEditingController propertyDetailForm_propertyAge;
  late TextEditingController propertyDetailForm_projectLifeYear;

  // Valuation and construction
  late TextEditingController propertyDetailForm_propertyMaintain;
  late TextEditingController propertyDetailForm_constructionType;
  late TextEditingController propertyDetailForm_landRate;
  late TextEditingController propertyDetailForm_totalCons;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final propertyDetails =
            await ref.read(propertyFormDitailsProvider(widget.customerId).future);

        print('propertyDetails init: $propertyDetails');
      } catch (e) {
        print('Error fetching details: $e');
      }
    });
    incomeSourceTypecontroller = TextEditingController();
    devlopmentOfSurroundingArea = TextEditingController();
    localityClass = TextEditingController();
    propertyDetailForm_documentHolderName = TextEditingController();
    propertyDetailForm_selectStatusofPropety = TextEditingController();
    propertyDetailForm_relationApplicant = TextEditingController();
    propertyDetailForm_fatherName = TextEditingController();
    propertyDetailForm_villageName = TextEditingController();
    propertyDetailForm_panchayatName = TextEditingController();
    propertyDetailForm_stateName = TextEditingController();
    propertyDetailForm_districtName = TextEditingController();
    propertyDetailForm_tehsilName = TextEditingController();
    propertyDetailForm_patwariNo = TextEditingController();
    propertyDetailForm_wardNo = TextEditingController();
    propertyDetailForm_surveyNo = TextEditingController();
    propertyDetailForm_houseNo = TextEditingController();
    propertyDetailForm_eastName = TextEditingController();
    propertyDetailForm_westName = TextEditingController();
    propertyDetailForm_northName = TextEditingController();
    propertyDetailForm_southName = TextEditingController();
    propertyDetailForm_documentProvided = TextEditingController();
    propertyDetailForm_boundariesPatta = TextEditingController();
    propertyDetailForm_propertyAddress = TextEditingController();
    propertyDetailForm_docHolderName = TextEditingController();
    propertyDetailForm_propertyLatitude = TextEditingController();
    propertyDetailForm_propertyLongitude = TextEditingController();
    propertyDetailForm_doorAndWindow = TextEditingController();
    propertyDetailForm_kitchenAndLat = TextEditingController();
    propertyDetailForm_assetResidence = TextEditingController();
    propertyDetailForm_landMark = TextEditingController();
    propertyDetailForm_locaZone = TextEditingController();
    propertyDetailForm_localTransport = TextEditingController();
    propertyDetailForm_localityClass = TextEditingController();
    propertyDetailForm_localityType = TextEditingController();
    propertyDetailForm_landflatStatus = TextEditingController();
    propertyDetailForm_propertyType = TextEditingController();
    propertyDetailForm_groundfloor = TextEditingController();
    propertyDetailForm_firstfloor = TextEditingController();
    propertyDetailForm_usagesType = TextEditingController();
    propertyDetailForm_structureType = TextEditingController();
    propertyDetailForm_plotLocation = TextEditingController();
    propertyDetailForm_builtUpArea = TextEditingController();
    propertyDetailForm_structureOccupancy = TextEditingController();
    propertyDetailForm_electricityAndGas = TextEditingController();
    propertyDetailForm_surroundingAreaDevelopment = TextEditingController();
    propertyDetailForm_totalBuiltUpArea = TextEditingController();
    propertyDetailForm_qualityConstruction = TextEditingController();
    propertyDetailForm_propertyAge = TextEditingController();
    propertyDetailForm_projectLifeYear = TextEditingController();
    propertyDetailForm_propertyMaintain = TextEditingController();
    propertyDetailForm_constructionType = TextEditingController();
    propertyDetailForm_landRate = TextEditingController();
    propertyDetailForm_totalCons = TextEditingController();
    typeOfPropertyPaper= TextEditingController();
    actualUsageoFProperty= TextEditingController();
  }

  @override
  void dispose() {
    incomeSourceTypecontroller.dispose();
    devlopmentOfSurroundingArea.dispose();
    localityClass.dispose();
    propertyDetailForm_documentHolderName.dispose();
    propertyDetailForm_selectStatusofPropety.dispose();
    propertyDetailForm_relationApplicant.dispose();
    propertyDetailForm_fatherName.dispose();
    propertyDetailForm_villageName.dispose();
    propertyDetailForm_panchayatName.dispose();
    propertyDetailForm_stateName.dispose();
    propertyDetailForm_districtName.dispose();
    propertyDetailForm_tehsilName.dispose();
    propertyDetailForm_patwariNo.dispose();
    propertyDetailForm_wardNo.dispose();
    propertyDetailForm_surveyNo.dispose();
    propertyDetailForm_houseNo.dispose();
    propertyDetailForm_eastName.dispose();
    propertyDetailForm_westName.dispose();
    propertyDetailForm_northName.dispose();
    propertyDetailForm_southName.dispose();
    propertyDetailForm_documentProvided.dispose();
    propertyDetailForm_boundariesPatta.dispose();
    propertyDetailForm_propertyAddress.dispose();
    propertyDetailForm_docHolderName.dispose();
    propertyDetailForm_propertyLatitude.dispose();
    propertyDetailForm_propertyLongitude.dispose();
    propertyDetailForm_doorAndWindow.dispose();
    propertyDetailForm_kitchenAndLat.dispose();
    propertyDetailForm_assetResidence.dispose();
    propertyDetailForm_landMark.dispose();
    propertyDetailForm_locaZone.dispose();
    propertyDetailForm_localTransport.dispose();
    propertyDetailForm_localityClass.dispose();
    propertyDetailForm_localityType.dispose();
    propertyDetailForm_landflatStatus.dispose();
    propertyDetailForm_propertyType.dispose();
    propertyDetailForm_groundfloor.dispose();
    propertyDetailForm_firstfloor.dispose();
    propertyDetailForm_usagesType.dispose();
    propertyDetailForm_structureType.dispose();
    propertyDetailForm_plotLocation.dispose();
    propertyDetailForm_builtUpArea.dispose();
    propertyDetailForm_structureOccupancy.dispose();
    propertyDetailForm_electricityAndGas.dispose();
    propertyDetailForm_surroundingAreaDevelopment.dispose();
    propertyDetailForm_totalBuiltUpArea.dispose();
    propertyDetailForm_qualityConstruction.dispose();
    propertyDetailForm_propertyAge.dispose();
    propertyDetailForm_projectLifeYear.dispose();
    propertyDetailForm_propertyMaintain.dispose();
    propertyDetailForm_constructionType.dispose();
    propertyDetailForm_landRate.dispose();
    propertyDetailForm_totalCons.dispose();
    typeOfPropertyPaper.dispose();
    actualUsageoFProperty.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  SizedBox sizedBoxWithContext(BuildContext context, double heightFactor) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * heightFactor,
    );
  }

  String selfieWithCustUrl = '';
  String photoWithLatLongUrl = '';
  String frontImageUrl = '';
  String mainRoadUrl = '';
  String leftsideImagUrl = '';
  String rightsideUrl = '';
  String interirorUrl = '';
  String approachRoadImgUrl = '';
  String otherPhotosUrl = '';

  @override
  Widget build(BuildContext context) {
    // final uploadselfie = ref.watch(sssMidimageProvider);
    // final images = ref.watch(imageCollectionProvider);
    final propertyForm = ref.watch(propertyFormDitailsProvider(widget.customerId));
    // final fetchImages = ref.watch(propertyFormImageDetailsProvider);
    //frontImageProvider
    final otherPhotos = ref.watch(photoWithLatLongProvider);

    final isExpanded = ref.watch(isExpPropertyCollProvider);
    final imageNotifier = ref.read(otherPhototsimageUploadProvider.notifier);

    final appState = ref.watch(pdsubmitpropertyFormProvider);
    return ExpansionTile(
          backgroundColor: Colors.white,
          childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
          shape: const BeveledRectangleBorder(side: BorderSide.none),
          title: const Text('Property - Collaterals'),
          onExpansionChanged: (expanded) {
            ref.read(isExpPropertyCollProvider.notifier).state = expanded;
            if (expanded) {
              // Trigger data fetch when the tile is expanded
              ref.refresh(propertyFormDitailsProvider(widget.customerId));
            }
          },
          initiallyExpanded: isExpanded,
          children: <Widget>[
            propertyForm.when(
                data: (propertyFormData) {

                  if (propertyDetailForm_documentHolderName.text.isEmpty) {
                    //outside
                    // typeOfPropertyPaper.text=propertyFormData.property. ?? '';
                    propertyDetailForm_landRate.text =
                        propertyFormData.property!.landRatePerSQFT ?? '';
                    propertyDetailForm_propertyMaintain.text =
                        propertyFormData.property!.maintenanceOfTheProperty ?? '';
                    propertyDetailForm_constructionType.text =
                        propertyFormData.property!.typeOfContruction ?? '';
                    propertyDetailForm_totalCons.text =
                        propertyFormData.property!.totalConstruction ?? '';
                    propertyDetailForm_totalBuiltUpArea.text =
                        propertyFormData.property!.totalBuilUpArea ?? '';

                    propertyDetailForm_landRate.text =
                        propertyFormData.property!.landRatePerSQFT ?? '';
                    propertyDetailForm_projectLifeYear.text =
                        propertyFormData.property!.projectedLifeYear ?? '';
                    propertyDetailForm_propertyAge.text =
                        propertyFormData.property!.ageOfProperty ?? '';
                    propertyDetailForm_tehsilName.text =
                        propertyFormData.property!.tehsil ?? '';
                    propertyDetailForm_relationApplicant.text =
                        propertyFormData.property!.relationWithApplicant ?? '';
                    propertyDetailForm_fatherName.text =
                        propertyFormData.property!.fatherName ?? '';
                    propertyDetailForm_villageName.text =
                        propertyFormData.property!.villageName ?? '';
                    propertyDetailForm_panchayatName.text =
                        propertyFormData.property!.gramPanchayat ?? '';
                    propertyDetailForm_patwariNo.text =
                        propertyFormData.property!.patwariHalkaNo ?? '';
                    propertyDetailForm_stateName.text =
                        propertyFormData.property!.state ?? '';
                    propertyDetailForm_districtName.text =
                        propertyFormData.property!.district ?? '';
                    propertyDetailForm_districtName.text =
                        propertyFormData.property!.district ?? '';
                    propertyDetailForm_houseNo.text =
                        propertyFormData.property!.houseNo ?? '';
                    propertyDetailForm_surveyNo.text =
                        propertyFormData.property!.surveyNo ?? '';
                    propertyDetailForm_wardNo.text =
                        propertyFormData.property!.wardNo ?? '';
                    propertyDetailForm_doorAndWindow.text =
                        propertyFormData.property!.doorsAndWindowsAreAvailable ?? '';
                    propertyDetailForm_kitchenAndLat.text =
                        propertyFormData.property!.kitchenAndLatBathAvailable ?? '';
                    propertyDetailForm_propertyLatitude.text =
                        propertyFormData.property!.latitudeOfTheProrty ?? '';
                    propertyDetailForm_fatherName.text =
                        propertyFormData.property!.fatherName ?? '';
                    //property-colaterall details
                    propertyDetailForm_documentHolderName.text = propertyFormData
                        .property!.collateralsDetails?.nameOfTheDocumentHolder ??
                        '';
                    propertyDetailForm_propertyType.text =
                        propertyFormData.property!.collateralsDetails?.typeOfProperty ??
                            '';
                    //       propertyDetailForm_.text =
                    // propertyFormData.collateralsDetails?. ??
                    //     '';
                    propertyDetailForm_boundariesPatta.text = propertyFormData
                        .property!.collateralsDetails?.boundariesMatching ??
                        '';
                    propertyDetailForm_eastName.text =
                        propertyFormData.property!.collateralsDetails?.boundariesEast ??
                            '';
                    propertyDetailForm_westName.text =
                        propertyFormData.property!.collateralsDetails?.boundariesWest ??
                            '';
                    propertyDetailForm_northName.text =
                        propertyFormData.property!.collateralsDetails!.boundariesNorth ??
                            '';
                    propertyDetailForm_southName.text =
                        propertyFormData.property!.collateralsDetails!.boundariesSouth ??
                            '';
                    propertyDetailForm_landMark.text =
                        propertyFormData.property!.collateralsDetails!.landmark ?? '';
                    propertyDetailForm_documentProvided.text = propertyFormData
                        .property!.collateralsDetails!.documentsProvided ??
                        '';
                    propertyDetailForm_propertyAddress.text =
                        propertyFormData.property!.collateralsDetails!.propertyAddress ??
                            '';
                    propertyDetailForm_locaZone.text =
                        propertyFormData.property!.collateralsDetails!.locationZone ?? '';
                    propertyDetailForm_localTransport.text = propertyFormData
                        .property!.collateralsDetails!.availabilityOfLocalTransport ??
                        '';
                    propertyDetailForm_localityClass.text =
                        propertyFormData.property!.collateralsDetails!.classOfLocality ??
                            '';
                    propertyDetailForm_localityType.text =
                        propertyFormData.property!.collateralsDetails!.typeOfLocality ??
                            '';
                    propertyDetailForm_landflatStatus.text = propertyFormData
                        .property!.collateralsDetails!.statusOfTheLandFlat ??
                        '';
                    //  propertyDetailForm_pers.text =
                    // propertyFormData.collateralsDetails!.asPerSite ?? '';
                    propertyDetailForm_landflatStatus.text = propertyFormData
                        .property!.collateralsDetails!.statusOfTheLandFlat ??
                        '';

                    //*************accommodationDetails***************** */
                    //  propertyDetailForm_ua.text =
                    // propertyFormData.accommodationDetails!.actualUsageOfProperty ?? '';
                    propertyDetailForm_builtUpArea.text =
                        propertyFormData.property!.accommodationDetails!.builtUpAreaSft ??
                            '';
                    propertyDetailForm_surroundingAreaDevelopment.text = propertyFormData
                        .property!
                        .accommodationDetails!
                        .developmentOfSurroundingArea ??
                        '';
                    propertyDetailForm_electricityAndGas.text = propertyFormData.property!
                        .accommodationDetails!.electricityAndGasConnection ??
                        '';
                    propertyDetailForm_groundfloor.text =
                        propertyFormData.property!.accommodationDetails!.groundFloor ??
                            '';
                    propertyDetailForm_firstfloor.text =
                        propertyFormData.property!.accommodationDetails!.firstFloor ?? '';
                    propertyDetailForm_structureOccupancy.text =
                        propertyFormData.property!.accommodationDetails!.occupancy ?? '';
                    propertyDetailForm_structureType.text = propertyFormData
                        .property!.accommodationDetails!.typeOfStructure ??
                        '';
                  }
                  return  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Business and Banking Information',
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
                            controller: propertyDetailForm_documentHolderName,
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
                        const Text('Location Details',
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
                        const Text('Property Boundaries',
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
                        const Text('Property Documentation',
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
                        const Text('Property Coordination & features',
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
                        // sizedBoxWithContext(context, 0.03),
                        //
                        // // dropdown asset seen at Residence
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 18),
                        //   child: CustomDropDownTextField(
                        //     labelText: 'Income Source Type',
                        //     items: [
                        //       DropDownValueModel(name: 'Option 1', value: '1'),
                        //       DropDownValueModel(name: 'Option 2', value: '2'),
                        //       DropDownValueModel(name: 'Option 3', value: '3'),
                        //       DropDownValueModel(name: 'Option 4', value: '4'),
                        //       DropDownValueModel(name: 'Option 5', value: '5'),
                        //     ],
                        //     controller: incomeSourceTypecontroller,
                        //   ),
                        // ),
                        // Surrounding Area & Transport
                        sizedBoxWithContext(context, 0.03),
                        const Text('Surrounding Area & Transport',
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
                            items: const [
                              DropDownValueModel(name: 'Owned', value: 'Owned'),
                              DropDownValueModel(name: 'Rented', value: 'Rented'),
                              DropDownValueModel(name: 'Leased', value: 'Leased'),
                              DropDownValueModel(
                                  name: 'Under Cunstruction',
                                  value: 'Under Cunstruction'),
                              DropDownValueModel(
                                  name: 'Ready to move', value: 'Ready to move'),
                              DropDownValueModel(
                                  name: 'Under Litigation',
                                  value: 'Under Litigation'),
                              DropDownValueModel(
                                  name: 'Mortgaged', value: 'Mortgaged'),
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
                            items: const [
                              DropDownValueModel(name: 'Rural', value: '1'),
                              DropDownValueModel(name: 'Urban', value: '2'),
                              DropDownValueModel(name: 'Semi Urban', value: '3'),
                            ],
                          ),
                        ),
                        sizedBoxWithContext(context, 0.03),
                        // dropdown locality class
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: CustomDropDownTextField(
                            controller: typeOfPropertyPaper,
                            labelText: 'Type of property paper',
                            items: const [
                              DropDownValueModel(name: 'Patta', value: 'Patta'),
                              DropDownValueModel(name: 'Registry', value: 'Registry'),
                              DropDownValueModel(name: 'Co-ownership', value: 'Co-ownership'),
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
                        const Text('Property Status',
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
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: CustomDropDownTextField(
                            controller: actualUsageoFProperty,
                            labelText: 'Actual usage of property',
                            items: const [
                              DropDownValueModel(name: 'Residential', value: 'Residential'),
                              DropDownValueModel(name: 'Commercial', value: 'Commercial'),
                              DropDownValueModel(name: 'Agriculture', value: 'Agriculture'),

                              DropDownValueModel(name: 'Industrial', value: 'Industrial'),
                              DropDownValueModel(name: 'Rental Property', value: 'Rental Property'),
                              // DropDownValueModel(name: 'Agriculture', value: '3'),
                            ],
                          ),
                        ),
                        // Structural Details

                        sizedBoxWithContext(context, 0.03),
                        const Text('Structural Details',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF475467))),
                        sizedBoxWithContext(context, 0.03),
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: CustomDropDownTextField(
                            controller: localityClass,
                            labelText: 'Type of structure',
                            items: const [
                              DropDownValueModel(name: 'RCC', value: 'RCC'),
                              DropDownValueModel(name: 'Teen set', value: 'Teen set'),
                              DropDownValueModel(name: 'Kacca', value: 'Kacca'),

                              // DropDownValueModel(name: 'Agriculture', value: '3'),
                            ],
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
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 15),
                        //   child: CustomTextFormField(
                        //     inerHint: "Occupancy",
                        //     onValidate: (value) {
                        //       if (value!.trim().isEmpty) {
                        //         return "This is a required field";
                        //       }
                        //       return null;
                        //     },
                        //     controller: propertyDetailForm_structureOccupancy,
                        //     textInputAction: TextInputAction.next,
                        //     textInputType: TextInputType.name,
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: CustomDropDownTextField(
                            controller: propertyDetailForm_structureOccupancy,
                            labelText: 'Type of structure',
                            items: const [
                              DropDownValueModel(name: 'Occupied', value: 'Occupied'),
                              DropDownValueModel(name: 'Un Occupied', value: 'Un Occupied'),
                              // DropDownValueModel(name: 'Kacca', value: 'Kacca'),

                              // DropDownValueModel(name: 'Agriculture', value: '3'),
                            ],
                          ),
                        ),
                        // dropdown for electricity

                        //Area Development & Maintenance
                        sizedBoxWithContext(context, 0.03),
                        const Text('Area Development & Maintenance',
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
                                  textInputType: TextInputType.number,
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
                        const Text('Valuation & Construction',
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
                            items: const [
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
                            items: const [
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
                        const Text('Customer Documentation',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF475467))),
                        sizedBoxWithContext(context, 0.03),

                        const Text('SELFI WITH CUSTOMER'),
                        CommonImagePicker(
                          applicantImage: propertyFormData.selfiWithCustomer ?? '',
                          onImageUploaded: (imageUrl) {
                            setState(() {
                              propertyFormData.selfiWithCustomer!.isNotEmpty
                                  ? propertyFormData.selfiWithCustomer = imageUrl
                                  : // Update the image URL
                              selfieWithCustUrl = imageUrl;
                              print('selfieWithCustUrl:: $selfieWithCustUrl');
                            });
                          },
                        ),
                        sizedBoxWithContext(context, 0.03),
                        const Text('PHOTO WITH LAT LONG'),
                        CommonImagePicker(
                          applicantImage: propertyFormData.photoWithLatLong ?? '',
                          onImageUploaded: (imageUrl) {
                            setState(() {
                              propertyFormData.photoWithLatLong!.isNotEmpty
                                  ? propertyFormData.photoWithLatLong = imageUrl
                                  : // Update the image URL
                              photoWithLatLongUrl = imageUrl;
                              print('photoWithLatLongUrl:: $photoWithLatLongUrl');
                            });
                          },
                        ),
                        sizedBoxWithContext(context, 0.03),
                        const Text('FRONT'),
                        CommonImagePicker(
                          applicantImage: propertyFormData.front ?? '',
                          onImageUploaded: (imageUrl) {
                            setState(() {
                              propertyFormData.front!.isNotEmpty
                                  ? propertyFormData.front = imageUrl
                                  : // Update the image URL
                              frontImageUrl = imageUrl;
                              print('frontImageUrl:: $frontImageUrl');
                            });
                          },
                        ),
                        sizedBoxWithContext(context, 0.03),
                        const Text('LEFT SIDE'),
                        CommonImagePicker(
                          applicantImage: propertyFormData.leftSide ?? '',
                          onImageUploaded: (imageUrl) {
                            setState(() {
                              propertyFormData.leftSide!.isNotEmpty
                                  ? propertyFormData.leftSide = imageUrl
                                  : // Update the image URL
                              leftsideImagUrl = imageUrl;
                              print('leftsideImagUrl:: $leftsideImagUrl');
                            });
                          },
                        ),
                        sizedBoxWithContext(context, 0.03),
                        const Text('RIGHT SIDE'),
                        CommonImagePicker(
                          applicantImage: propertyFormData.rightSide ?? '',
                          onImageUploaded: (imageUrl) {
                            setState(() {
                              propertyFormData.rightSide!.isNotEmpty
                                  ? propertyFormData.rightSide = imageUrl
                                  : // Update the image URL
                              rightsideUrl = imageUrl;
                              print('rightsideUrl:: $rightsideUrl');
                            });
                          },
                        ),
                        sizedBoxWithContext(context, 0.03),
                        const Text('APPROACH ROAD'),
                        CommonImagePicker(
                          applicantImage: propertyFormData.approachRoad ?? '',
                          onImageUploaded: (imageUrl) {
                            setState(() {
                              propertyFormData.approachRoad!.isNotEmpty
                                  ? propertyFormData.approachRoad = imageUrl
                                  : // Update the image URL
                              approachRoadImgUrl = imageUrl;
                              print('approachRoadImgUrl:: $approachRoadImgUrl');
                            });
                          },
                        ),
                        sizedBoxWithContext(context, 0.03),
                        const Text('MAIN SIDE'),
                        CommonImagePicker(
                          applicantImage: propertyFormData.mainRoad ?? '',
                          onImageUploaded: (imageUrl) {
                            setState(() {
                              propertyFormData.mainRoad!.isNotEmpty
                                  ? propertyFormData.mainRoad = imageUrl
                                  : // Update the image URL
                              mainRoadUrl = imageUrl;
                              print('mainRoadUrl:: $mainRoadUrl');
                            });
                          },
                        ),
                        sizedBoxWithContext(context, 0.03),
                        const Text('INTERIOR SIDE'),
                        CommonImagePicker(
                          applicantImage: propertyFormData.interiorRoad ?? '',
                          onImageUploaded: (imageUrl) {
                            setState(() {
                              propertyFormData.interiorRoad!.isNotEmpty
                                  ? propertyFormData.interiorRoad = imageUrl
                                  : // Update the image URL
                              interirorUrl = imageUrl;
                              print('interirorUrl:: $interirorUrl');
                            });
                          },
                        ),
                        sizedBoxWithContext(context, 0.03),
                        const Text('OTHER PHOTOS'),
                        // ...propertyFormData.propertyOtherPhotos!
                        //     .asMap()
                        //     .entries
                        //     .map((entry) {
                        //   final int index = entry.key;
                        //   final String image = entry.value;
                        //   print(
                        //       'propertyFormData.propertyOtherPhotos from server:: ${propertyFormData.propertyOtherPhotos!.length}');
                        //   print('image:: $image');
                        //   return Stack(
                        //     children: [
                        //       Padding(l
                        //         padding: const EdgeInsets.symmetric(vertical: 10),
                        //         child: Container(
                        //           height: MediaQuery.of(context).size.height * 0.2,
                        //           width: MediaQuery.of(context).size.width * 0.8,
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(12),
                        //             border: Border.all(
                        //               color: Colors.grey,
                        //               width: 1,
                        //             ),
                        //           ),
                        //           child: CachedNetworkImage(
                        //             imageUrl:
                        //                 //  workPhotosList.length == 0
                        //                 //     ? '${Api.baseUrl}${agriAndWorkImages.workPhotos![index]}':
                        //                 '${Api.baseUrl}${image}',
                        //             height: displayHeight(context) * 0.16,
                        //             width: displayWidth(context) * 0.91,
                        //             fit: BoxFit.cover,
                        //             placeholder: (context, url) =>
                        //                 Center(child: CircularProgressIndicator()),
                        //             errorWidget: (context, url, error) => Image.asset(
                        //               'assets/images/no_internet.jpg',
                        //               height: 150,
                        //               width: double.infinity,
                        //               fit: BoxFit.cover,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Positioned(
                        //         right: -2,
                        //         child: GestureDetector(
                        //           onTap: () {
                        //             setState(() {
                        //               propertyFormData.propertyOtherPhotos!
                        //                   .removeAt(index);
                        //               print(
                        //                   'workPhotosList:: ${propertyFormData.propertyOtherPhotos!.length}');
                        //             });
                        //           },
                        //           child: Image.asset(
                        //             'assets/images/remove.png',
                        //             height: 20,
                        //             width: 20,
                        //             fit: BoxFit.cover,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   );
                        // }).toList(),

                        ImageListWidget(
                          imageUrls: propertyFormData.propertyOtherPhotos ?? [],
                          onRemove: (index) {
                            setState(() {
                              if (propertyFormData.propertyOtherPhotos != null) {
                                propertyFormData.propertyOtherPhotos?.removeAt(index);
                              }
                            });
                          },
                          onAddImage: () async {
                            // Add new image logic (e.g., open image picker)
                            // String newImage = await uploadImage(); // Replace with your upload logic
                            // if (newImage.isNotEmpty) {
                            //   addImage(newImage);
                            // }
                            imageNotifier.pickImage().then(
                                  (value) {
                                imageNotifier.uploadImage(value).then(
                                      (value) {
                                    setState(() {
                                      // print('workphotoUrl: $value');
                                      // workPhotosList.add(value);
                                      propertyFormData.propertyOtherPhotos
                                          ?.add(value);
                                      // print(
                                      //     'workPhotosList url length:: ${workPhotosList.length}');
                                      print(
                                          'propertyFormData.propertyOtherPhotos:: ${propertyFormData.propertyOtherPhotos!.length}');
                                    });
                                  },
                                );
                              },
                            );
                          },
                        ),
                        constSizedbox(context),
                        const Text('HOUSE INSIDE PHOTOS'),

                        ImageListWidget(
                          imageUrls: propertyFormData.houseInsidePhoto ?? [],
                          onRemove: (index) {
                            setState(() {
                              if (propertyFormData.houseInsidePhoto != null) {
                                propertyFormData.houseInsidePhoto?.removeAt(index);
                              }
                            });
                          },
                          onAddImage: () async {
                            // Add new image logic (e.g., open image picker)
                            // String newImage = await uploadImage(); // Replace with your upload logic
                            // if (newImage.isNotEmpty) {
                            //   addImage(newImage);
                            // }
                            imageNotifier.pickImage().then(
                                  (value) {
                                imageNotifier.uploadImage(value).then(
                                      (value) {
                                    setState(() {
                                      // print('workphotoUrl: $value');
                                      // workPhotosList.add(value);
                                      propertyFormData.houseInsidePhoto?.add(value);
                                      // print(
                                      //     'workPhotosList url length:: ${workPhotosList.length}');
                                      print(
                                          'propertyFormData.houseInsidePhoto:: ${propertyFormData.houseInsidePhoto!.length}');
                                    });
                                  },
                                );
                              },
                            );
                          },
                        ),
                        constSizedbox(context),
                        appState.isLoading == true
                            ? const SizedBox(
                          width: 24, // Specify the width
                          height: 24, // Specify the height
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                            strokeWidth: 5,
                            key: ValueKey(
                                'loading'), // Key for progress indicator
                          ),
                        )
                            : ElevatedButton(
                          onPressed: () {
                            // Create an instance of Property and populate it with the required details
                            // if (_formKey.currentState!.validate()) {
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(
                            //       backgroundColor: AppColors.red,
                            //       content: Text(
                            //         'Please fill all required details!',
                            //         style: AppStyles.whiteText16,
                            //       ),
                            //     ),
                            //   );
                            // }
                            Property propertyDetails = Property(
                              // propertyOwnerName: 'John Doe',
                              relationWithApplicant:
                              propertyDetailForm_relationApplicant.text,
                              villageName: propertyDetailForm_villageName.text,
                              gramPanchayat:
                              propertyDetailForm_panchayatName.text,
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
                              ageOfProperty:
                              propertyDetailForm_propertyAge.text,
                              maintenanceOfTheProperty:
                              propertyDetailForm_propertyMaintain.text,
                              projectedLifeYear:
                              propertyDetailForm_projectLifeYear.text,
                              typeOfContruction:
                              propertyDetailForm_constructionType.text,
                              landRatePerSQFT: propertyDetailForm_landRate.text,
                              totalConstruction:
                              propertyDetailForm_totalCons.text,
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
                                propertyDetailForm_docHolderName.text,
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
                                boundariesEast:
                                propertyDetailForm_eastName.text,
                                boundariesWest:
                                propertyDetailForm_westName.text,
                                boundariesNorth:
                                propertyDetailForm_northName.text,
                                boundariesSouth:
                                propertyDetailForm_southName.text,
                              ),
                              accommodationDetails: AccommodationDetails(
                                groundFloor:
                                propertyDetailForm_groundfloor.text,
                                firstFloor: propertyDetailForm_firstfloor.text,
                                // actualUsageOfProperty: propertyDetailForm_prop.text,
                                typeOfStructure:
                                propertyDetailForm_structureType.text,
                                locationOfPlot:
                                propertyDetailForm_plotLocation.text,
                                builtUpAreaSft:
                                propertyDetailForm_builtUpArea.text,
                                occupancy:
                                propertyDetailForm_structureOccupancy.text,
                                electricityAndGasConnection: 'Available',
                                developmentOfSurroundingArea:
                                propertyDetailForm_surroundingAreaDevelopment
                                    .text,
                              ),
                            );
                            print('frontImageUrl: $frontImageUrl');
                            print('selfieWithCustUrl: $selfieWithCustUrl');
                            print('photoWithLatLongUrl: $photoWithLatLongUrl');
                            print('mainRoadUrl: $mainRoadUrl');
                            ref
                                .read(pdsubmitpropertyFormProvider.notifier)
                                .submitpdpropertyForm(
                                customerId:  widget.customerId,
                                pdType: 'creditPd',
                                properttyItems: propertyDetails,
                                selfiWCust: selfieWithCustUrl.isNotEmpty
                                    ? selfieWithCustUrl
                                    : propertyFormData.selfiWithCustomer
                                    .toString(),
                                front: frontImageUrl.isNotEmpty
                                    ? frontImageUrl
                                    : propertyFormData.front.toString(),
                                photoWLat: photoWithLatLongUrl.isNotEmpty
                                    ? photoWithLatLongUrl
                                    : propertyFormData.photoWithLatLong
                                    .toString(),
                                mainRoadImage: mainRoadUrl.isNotEmpty
                                    ? mainRoadUrl
                                    : propertyFormData.mainRoad.toString(),
                                approachRoadImage:
                                approachRoadImgUrl.isNotEmpty
                                    ? approachRoadImgUrl
                                    : propertyFormData.approachRoad
                                    .toString(),
                                interiorRoadImage: interirorUrl.isNotEmpty
                                    ? interirorUrl
                                    : propertyFormData.interiorRoad
                                    .toString(),
                                leftImage: leftsideImagUrl.isNotEmpty
                                    ? leftsideImagUrl
                                    : propertyFormData.leftSide.toString(),
                                rightImage: rightsideUrl.isNotEmpty
                                    ? rightsideUrl
                                    : propertyFormData.rightSide.toString(),
                                otherPhotos:
                                propertyFormData.propertyOtherPhotos,
                                houseInsidephotos:
                                propertyFormData.houseInsidePhoto)
                                .then((value) {
                              if (value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
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
                                  const SnackBar(
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
                            // PropertyItems propertyItems = PropertyItems(
                            //     front: frontImageUrl,
                            //     selfiWithCustomer: selfieWithCustUrl,
                            //     photoWithLatLong: photoWithLatLongUrl,
                            //     mainRoad: mainRoadUrl,
                            //     property: propertyDetails);
                            // Call the provider method with the populated Property object
                          },
                          child: Text(
                            'Next',
                            style: AppStyles.whiteText16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              loading: () => const Center(child: CircularProgressIndicator()),
              //  error: (error, stackTrace) => Center(child: Text('Error: $error')),
              error: (error, stackTrace) {
                print('Error fetching Colaterall: $error');
                return const Center(child: Text('faild to get data please try again'));
              },
            )

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
