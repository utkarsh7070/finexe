

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PdReject {
  final String id;

  final String imageUrl;
  final String name;
  final String address;
  final String? date;

  PdReject(
      {required this.id,
      required this.imageUrl,
      required this.name,
      required this.address,
      this.date});
}

final pdrejectViewModel = Provider<List<PdReject>>((ref) {
  return [
    PdReject(
      date: '12/10/2024',
      id: 'LOCAI1007',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
      name: 'Ajay Pal S/O Ramprasad ',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
    ),
    PdReject(
      date: null,
      id: 'LOCAI1007',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
      name: 'Ajay Pal S/O Ramprasad ',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
    ),
    PdReject(
      date: '10/10/2024',
      id: 'LOCAI1007',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
      name: 'Ajay Pal S/O Ramprasad ',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
    ),
    PdReject(
      date: null,
      id: 'LOCAI1007',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
      name: 'Ajay Pal S/O Ramprasad ',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
    ),
    PdReject(
      date: '08/10/2024',
      id: 'LOCAI1007',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
      name: 'Ajay Pal S/O Ramprasad ',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
    ),
    // Add more items as needed
  ];
});
