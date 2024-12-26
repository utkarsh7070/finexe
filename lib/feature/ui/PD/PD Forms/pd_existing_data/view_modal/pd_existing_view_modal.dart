import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/service/session_service.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_existing_data/modal/pd_existing_modal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../modal/pd_existing_modal.dart';

// -----------loan Deatail -----------
final loanDetailsProvider = FutureProvider.autoDispose
    .family<LoanDetails, String>((ref, customerId) async {
  final token = await SessionService.getToken();
  final viewModel = LoanDetailsProvider();
  return await viewModel.fetchLoanDetails(token, customerId);
});


class LoanDetailsProvider {
  final Dio _dio = Dio();

  Future<LoanDetails> fetchLoanDetails(String? token,String customerId) async {
    try {
      final response = await _dio.get(
        // '${Api.getApplicantFormDetails}/66dec7b50084c9b822d403d1',
        '${Api.getApplicantFormDetails}/$customerId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['items'];
        return LoanDetails.fromJson(data);
      } else {
        throw Exception("Failed to load loan details data");
      }
    } catch (e) {
      print("Error fetching loan details: $e");
      throw Exception("Error fetching loan details: $e");
    }
  }
}

// ----------Applicant details api ------------

final applicationDetailsProvider =
    FutureProvider.autoDispose.family<ApplicationDetails,String>((ref,customerId) async {
  final viewModel = ApplicationDetailsProvider();
  return await viewModel.fetchApplicationDetails(customerId);
});

class ApplicationDetailsProvider {
  final Dio _dio = Dio();

  Future<ApplicationDetails> fetchApplicationDetails(String customerId) async {
    try {
      final response = await _dio
          .get('${Api.getApplicantFormDetails}/$customerId');
      // print('Response: ${response.data['items']}');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['items'];

        if (data is Map<String, dynamic>) {
          final details = ApplicationDetails.fromJson(data);
          // print("Parsed ApplicationDetails: ${details.toString()}");
          return details;
        } else if (data is List) {
          final details = ApplicationDetails.fromJson(data.first);
          print("Parsed ApplicationDetails from List: ${details.toString()}");
          return details;
        } else {
          throw Exception("Unexpected data format");
        }
      } else {
        throw Exception("Failed to load application data");
      }
    } catch (e) {
      print("Error fetching application data: $e");
      throw Exception("Error fetching application data: $e");
    }
  }
}

// final applicationDetailsProvider = FutureProvider.autoDispose.family<ApplicationDetails, String>((ref, customerId) async {
//   final viewModel = ApplicationDetailsProvider();
//   return await viewModel.fetchApplicationDetails(customerId);
// });
// class ApplicationDetailsProvider {
//   final Dio _dio = Dio();
//
//   Future<ApplicationDetails> fetchApplicationDetails(String customerId) async {
//     try {
//       final response = await _dio.get(
//         '${Api.getApplicantFormDetails}/$customerId', // Adjust the endpoint accordingly
//       );
//
//       if (response.statusCode == 200 && response.data != null) {
//         final data = response.data['items'];
//         return ApplicationDetails.fromJson(data);
//       } else {
//         throw Exception("Failed to load application data");
//       }
//     } catch (e) {
//       print("Error fetching application data: $e");
//       throw Exception("Error fetching application data: $e");
//     }
//   }
// }

//   --------------- Applicant form details ----------------

// ---------------- Co applicant api ----------

final coApplicantExistingProvider =
    FutureProvider.autoDispose.family<List<CoApplicantDetails>,String>((ref,custId) async {
  final viewModel = CoApplicantProvider();
  return await viewModel.fetchCoApplicants(custId);
});

class CoApplicantProvider {
  final Dio _dio = Dio();

  Future<List<CoApplicantDetails>> fetchCoApplicants(String customerId) async {
    try {
      final response = await _dio
          .get('${Api.getCoApplicantFormDetails}/$customerId');
      // print(' Co-applicantResponse---: ${response.data['items']}');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['items'] as List;

        // Convert the fetched data into CoApplicantDetails objects
        List<CoApplicantDetails> coApplicants =
            data.map((item) => CoApplicantDetails.fromJson(item)).toList();

        // Ensure we have at least two CoApplicants, adding empty ones if necessary.
        while (coApplicants.length < 2) {
          coApplicants
              .add(CoApplicantDetails.fromJson({})); // Add empty CoApplicant
        }

        return coApplicants;
      } else {
        throw Exception("Failed to load co-applicant data");
      }
    } catch (e) {
      print("Error fetching co-applicant data: $e");
      throw Exception("Error fetching co-applicant data: $e");
    }
  }
}

// ----------- GuarantorDetailsViewModel -----------
final guarantorDetailsProvider =
    FutureProvider.autoDispose.family<GuarantorDetails,String>((ref,customerId) async {
  final viewModel = GuarantorDetailsProvider();
  return await viewModel.fetchGuarantorDetails(customerId);
});

class GuarantorDetailsProvider {
  final Dio _dio = Dio();

  Future<GuarantorDetails> fetchGuarantorDetails(String customerId) async {
    try {
      final response = await _dio
          .get('${Api.getGuarantorFormDetails}/66dec7b50084c9b822d403d1');
      // print('Response: ${response.data['items']}');

      if (response.statusCode == 200 && response.data != null) {
        return GuarantorDetails.fromJson(response.data['items']);
      } else {
        throw Exception("Failed to load guarantor data");
      }
    } catch (e) {
      print("Error fetching guarantor data: $e");
      throw Exception("Error fetching guarantor data: $e");
    }
  }
}

// ---------------- Cibil detail ------------

final cibilDetailsProvider =
    FutureProvider.autoDispose.family<CibilDetails,String>((ref,custId) async {
  final token = await SessionService.getToken();
  final viewModel = CibilDetailsProvider();
  return await viewModel.fetchCibilDetails(token,custId);
});

class CibilDetailsProvider {
  final Dio _dio = Dio();

  Future<CibilDetails> fetchCibilDetails(String? token,String custId) async {
    try {
      // final customerId = '';
      final response = await _dio.get(
        '${Api.getCibilDetails}/$custId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print('CibilDetails Response: ${response.data['items']}');

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data.containsKey('items')) {
        return CibilDetails.fromJson(response.data['items']);
      } else {
        throw Exception("Failed to load CIBIL data");
      }
    } catch (e) {
      print("Error fetching CIBIL data: $e");
      throw Exception("Error fetching CIBIL data: $e");
    }
  }
}
