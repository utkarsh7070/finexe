import 'package:dio/dio.dart';
import 'package:finexe/feature/Eod/AddBOD_dialogue/AddBOD_dialogue/view/add_bod._dialogue.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:finexe/feature/ui/PD/Model/add_bodstatus_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/pd_request_list_model.dart';

class Item {
  final String imageUrl;
  final String title;
  final String subtitle;

  Item({required this.imageUrl, required this.title, required this.subtitle});
}

class GridItem {
  final String backImage;
  final String iconImage;
  final String title;
  final String subtitle;

  GridItem({
    required this.backImage,
    required this.iconImage,
    required this.title,
    required this.subtitle,
  });
}

class PdItem {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String initialPd;

  PdItem({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.initialPd,
  });
}

final itemProvider = Provider<List<Item>>((ref) {
  return [
    Item(
      imageUrl:
          'https://media.istockphoto.com/id/1437816897/photo/business-woman-manager-or-human-resources-portrait-for-career-success-company-we-are-hiring.jpg?s=612x612&w=0&k=20&c=tyLvtzutRh22j9GqSGI33Z4HpIwv9vL_MZw_xOE19NQ=',
      title: 'Item 1',
      subtitle: 'Subtitle 1',
    ),
    Item(
      imageUrl:
          'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?cs=srgb&dl=pexels-sulimansallehi-1704488.jpg&fm=jpg',
      title: 'Item 2',
      subtitle: 'Subtitle 2',
    ),
    Item(
      imageUrl:
          'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?cs=srgb&dl=pexels-sulimansallehi-1704488.jpg&fm=jpg',
      title: 'Item 3',
      subtitle: 'Subtitle 3',
    ),
    // Add more items as needed
  ];
});

final griditemProvider = Provider<List<GridItem>>((ref) {
  return [
    GridItem(
      backImage: 'assets/images/green_back.png',
      iconImage: 'assets/images/right.png',
      title: 'Approved PD',
      subtitle: 'Case 180+ Now ',
    ),
    GridItem(
      backImage: 'assets/images/yellow_back.png',
      iconImage: 'assets/images/watch.png',
      title: 'Pending PD',
      subtitle: 'Case 180+ Now ',
    ),
    GridItem(
      backImage: 'assets/images/red_back.png',
      iconImage: 'assets/images/cross_red.png',
      title: 'Rejected PD',
      subtitle: 'Case 180+ Now ',
    ),
    GridItem(
      backImage: 'assets/images/blue_back.png',
      iconImage: 'assets/images/caurt.png',
      title: 'Completed PD',
      subtitle: 'Case 180+ Now ',
    ),
    // Add more items as needed
  ];
});

final pdItemsProvider = Provider<List<PdItem>>((ref) {
  return [
    PdItem(
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
      title: 'Robert Fox',
      subtitle: 'LOC1007',
      initialPd: 'Initiate PD',
    ),
    PdItem(
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
      title: 'Wade Warren',
      subtitle: 'LOC1007',
      initialPd: 'Initiate PD',
    ),
    PdItem(
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
      title: 'Robert Fox',
      subtitle: 'LOC1007',
      initialPd: 'Initiate PD',
    ),
    PdItem(
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
      title: 'Robert Fox',
      subtitle: 'LOC1007',
      initialPd: 'Initiate PD',
    ),
    // Add more items as needed
  ];
});

final bodStatusNotifierProvider =
    StateNotifierProvider<BodStatusNotifier, AsyncValue<BodStatusResponse?>>(
  (ref) => BodStatusNotifier(ref.read(dioProvider)),
);

class BodStatusNotifier extends StateNotifier<AsyncValue<BodStatusResponse?>> {
  final Dio dio;
  bool? isLoading = false;

  BodStatusNotifier(this.dio) : super(const AsyncValue.data(null));

  /// Fetch BOD Status
  Future<void> checkBodStatus(BuildContext context, WidgetRef ref) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    isLoading = true;
    state = const AsyncValue.loading();

    final headers = {"token": token};

    print("Authorization Token: $token");
    print("API Endpoint: ${Api.checkBodStatus}");

    try {
      final response = await dio.get(
        Api.checkBodStatus,
        options: Options(
          headers: headers,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200) {
        final bodStatusResponse = BodStatusResponse.fromJson(response.data);
        state = AsyncValue.data(bodStatusResponse);

        if (bodStatusResponse.data == true) {
          if (kDebugMode) {
            print('BOD is already added.');
          }
        } else if (bodStatusResponse.data == false) {
          if (kDebugMode) {
            print('Add BOD');
          }
          AddBodDialog().addAlbumDialog(context);
        } else {
          print('Data is null or invalid');
        }
      } else if (response.statusCode == 401) {
        print("401 Unauthorized: ${response.data}");
        state = AsyncValue.error(
          "Unauthorized: Token might be invalid or expired.",
          StackTrace.current,
        );
        showCustomSnackBar(context, 'Unauthorized access.', AppColors.red);
      } else {
        print("Unexpected Error: ${response.statusCode} ${response.data}");
        state = AsyncValue.error(
          "Error ${response.statusCode}: ${response.data}",
          StackTrace.current,
        );
      }
    } catch (error, stackTrace) {
      print("Exception occurred in check BOD: ${error.toString()}");
      state = AsyncValue.error(error, stackTrace);
    } finally {
      isLoading = false;
    }
  }

}


final fetchPdRequestListProvider =
FutureProvider.autoDispose<List<PDReqItems>>((ref) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString('token');
  // final String token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
  final Map<String, String> queryParam = {"status": "WIP", "searchQuery": ""};
  final dio = ref.read(dioProvider);
  print('Api.getReqRefP:: ${Api.getReqRefP}');
  print('token:: ${token}');

  final response = await dio.get(Api.getReqRefP,
      queryParameters: queryParam, options: Options(headers: {"token": token}));
  print(response.statusMessage);
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.data);
    List<dynamic> responseList = response.data['items'] ?? [];

    // Map the list of dynamic objects to List<PDReqItems>
    List<PDReqItems> apiResponseList =
    responseList.map((item) => PDReqItems.fromJson(item)).toList();
    print('PDReqItems ${apiResponseList.length}');
    return apiResponseList;
  } else {
    throw Exception('Failed to load data');
  }
});