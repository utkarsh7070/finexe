import 'package:flutter_riverpod/flutter_riverpod.dart';

class Applicant {
  final String name;
  final String id;
  final String address;
  final String imageUrl;
  final String? date;

  Applicant({
    this.date,
    required this.name,
    required this.id,
    required this.address,
    required this.imageUrl,
  });
}

final applicantProvider = Provider<List<Applicant>>((ref) {
  return [
    Applicant(
      date: '07/10/2024',
      name: 'Ajay Pal',
      id: 'LOCAI1007',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
    ),
    Applicant(
      date: null, // No date for this applicant
      name: 'Mohit Verma',
      id: 'LOCAI1008',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
    ),
    Applicant(
      date: '08/10/2024',
      name: 'Utkarsh',
      id: 'LOCAI1009',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
    ),
    Applicant(
      date: null, // Another entry with no date
      name: 'Manish Patidar',
      id: 'LOCAI1010',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
    ),
    Applicant(
      date: '09/10/2024',
      name: 'Akshay Kumar',
      id: 'LOCAI1011',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
    ),
    // Add more applicants as needed
  ];
});
