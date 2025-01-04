import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/upload_box.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'image_view.dart';

class ImageListWidget extends ConsumerWidget {
  final List<String> imageUrls; // List of image URLs
  final void Function(int index) onRemove; // Callback for removing image
  final VoidCallback onAddImage; // Callback for adding a new image

  const ImageListWidget({
    Key? key,
    required this.imageUrls,
    required this.onRemove,
    required this.onAddImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {



    bool _isLoading = false; // Track loading state

    return Column(
      children: [
        // Display all images in the list
        ...imageUrls.asMap().entries.map((entry) {
          final int index = entry.key;
          final String imageUrl = entry.value;

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 0, top: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GestureDetector(
                    onTap: () {
                      MaterialPageRoute(
                        builder: (context) => ZoomableImageWidget(
                          // ImageUrl: _uploadedImageUrl.isEmpty
                          //     ? '${Api.baseUrl}${widget.applicantImage}'
                          //     : '${Api.baseUrl}${_uploadedImageUrl}',
                          ImageUrl: '${Api.baseUrl}${imageUrl}',
                        ),
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: '${Api.baseUrl}${imageUrl}',
                      height: displayHeight(context) * 0.16,
                      width: displayWidth(context) * 0.91,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/no_internet.jpg'),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 3,
                top: 1,
                child: GestureDetector(
                  onTap: () => onRemove(index), // Remove image callback
                  child: Image.asset(
                    'assets/images/remove.png',
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          );
        }).toList(),
        // Button to add new image
        SizedBox(height: displayHeight(context) * 0.02),
        GestureDetector(
          onTap: onAddImage, // Add image callback
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),

            // child: Container(
            //   height: MediaQuery.of(context).size.height * 0.16,
            //   width: MediaQuery.of(context).size.width * 0.8,
            //   decoration: BoxDecoration(
            //     color: Colors.grey[300],
            //     borderRadius: BorderRadius.circular(12),
            //     border: Border.all(color: Colors.grey, width: 1),
            //   ),
            //   child: const Center(
            //     child: Icon(
            //       Icons.file_upload_outlined,
            //       size: 30,
            //       color: Colors.grey,
            //     ),
            //   ),
            // ),
            child: UploadBox(
              isImage: true,
              height: displayHeight(context) * 0.16,
              width: displayWidth(context) * 0.91,
              color: AppColors.buttonBorderGray,
              iconData: Icons.file_upload_outlined,
              textColor: AppColors.gray5,
              subTextColor: AppColors.primary,
              title: 'Support: JPG, PNG',
              subTitle: 'Click Image',
            ),
          ),
        ),
      ],
    );
  }
}
