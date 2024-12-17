import 'dart:io';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:finexe/feature/base/utils/widget/upload_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:video_player/video_player.dart';

import '../../../base/service/session_service.dart';

class CommonVideoPicker extends StatefulWidget {
  final String
      gettingVideoUrlFromServer; // Current applicant image URL //giving response url getting after uploading image in database
  final Function(String imageUrl)
      onImageUploaded; // Callback to pass uploaded image URL // getting url from uploadimage api

  const CommonVideoPicker({
    Key? key,
    // this.applicantImage,
    required this.gettingVideoUrlFromServer,
    required this.onImageUploaded,
  }) : super(key: key);

  @override
  _CommonVideoPickerState createState() => _CommonVideoPickerState();
}

class _CommonVideoPickerState extends State<CommonVideoPicker> {
  XFile? _selectedVideo;
  String _uploadedImageUrl = '';
  bool _isLoading = false; // Track loading state
  VideoPlayerController? _videoController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.gettingVideoUrlFromServer.isNotEmpty) {
      // String gotUrlFromserver = Api.baseUrl + widget.applicantImage;
      // print('gotUrlFromserver: $gotUrlFromserver');
      initializeVideoPlayer(widget.gettingVideoUrlFromServer);
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final video = await picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      setState(() {
        _isLoading = true; // Start loading when video is picked
        _selectedVideo = video;
        print('video.path: ${video.path}');
      });
      // await initializeVideoPlayer(video.path);
      await uploadImage(video.path);
    }
  }

  Future<void> initializeVideoPlayer(String videoPath) async {
    // Dispose of the previous controller if it exists
    // if (_videoController != null) {
    //   print('dispose controller');
    //   await _videoController!.dispose();
    // }

    // Construct the full video URL
    String fullVideoUrl = Api.baseUrl + videoPath;
    print('fullVideoUrl:: $fullVideoUrl');

    _videoController = VideoPlayerController.networkUrl(Uri.parse(fullVideoUrl))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        // Add a listener to detect when the video finishes playing
        _videoController!.addListener(() {
          if (_videoController!.value.position >=
              _videoController!.value.duration) {
            // Video is completed, trigger UI update
            setState(() {});
          }
        });
      });

    await _videoController!.initialize();
    setState(() {}); // Refresh the UI after initialization
  }

  Future<void> uploadImage(String imagePath) async {
    String? token = await SessionService.getToken();

    // String token =l
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY"; // Replace with your token logic or pass it as a parameter
    final dio = Dio();

    try {
      setState(() {
        _isLoading = true; // Stop loading on failure
        print('_isLoading: $_isLoading');
      });
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath,
            filename: imagePath.split('/').last),
      });

      final response = await dio.post(
        Api.uploadImageCollection, // Replace with your API endpoint
        data: formData,
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200) {
        final uploadedUrl = response.data['items']['image'];

        widget.onImageUploaded(uploadedUrl);
        setState(() {
          _uploadedImageUrl = uploadedUrl;

          _isLoading = false;
          print('uploadedUrl:: $uploadedUrl');
          initializeVideoPlayer(uploadedUrl);
        });
      } else {
        // _showSnackBar('Failed to upload image.');
        showCustomSnackBar(context, 'Failed to upload image.', AppColors.red);

        setState(() {
          _isLoading = false; // Stop loading on failure
          print('_isLoading false');
        });
      }
    } catch (e) {
      // _showSnackBar('An error occurred while uploading the image.');
      showCustomSnackBar(context,
          'An error occurred while uploading the image.', AppColors.red);

      setState(() {
        _isLoading = false; // Stop loading on failure
        print('_isLoading false');
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container(
            height: displayHeight(context) * 0.16,
            width: displayWidth(context) * 0.91,

            // color: Colors.black.withOpacity(0.5),
            child: const Center(child: CircularProgressIndicator()),
          )
        : widget.gettingVideoUrlFromServer.isEmpty && _uploadedImageUrl.isEmpty
            ? GestureDetector(
                onTap: pickImage,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: UploadBox(
                    height: displayHeight(context) * 0.16,
                    width: displayWidth(context) * 0.91,
                    color: AppColors.buttonBorderGray,
                    iconData: Icons.file_upload_outlined,
                    textColor: AppColors.gray5,
                    subTextColor: AppColors.primary,
                    title: 'Upload Video',
                    subTitle: '',
                  ),
                ),
              )
            : Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15, top: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child:
                            //  _selectedVideo != null
                            //     ?
                            _videoController != null &&
                                    _videoController!.value.isInitialized
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: displayHeight(context) * 0.21,
                                        width: displayWidth(context) * 0.9,
                                        child: AspectRatio(
                                          aspectRatio: _videoController!
                                              .value.aspectRatio,
                                          child: VideoPlayer(_videoController!),
                                        ),
                                      ),
                                      VideoProgressIndicator(
                                        _videoController!,
                                        allowScrubbing: true,
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    height: displayHeight(context) * 0.16,
                                    width: displayWidth(context) * 0.91,
                                    child: Center(
                                        child: CircularProgressIndicator()))),
                  ),
                  Positioned(
                    right: 10,
                    top: 3,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedVideo = null;
                          _uploadedImageUrl = '';
                          _videoController?.dispose();
                          _videoController = null;
                        });
                        widget.onImageUploaded(
                            ''); // Clear the uploaded image URL
                      },
                      child: Image.asset(
                        'assets/images/remove.png',
                        height: 25,
                        width: 25,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // GestureDetector(
                  //   onTap: () {
                  //     if (_videoController != null &&
                  //         _videoController!.value.isInitialized) {
                  //       setState(() {
                  //         _videoController!.value.isPlaying
                  //             ? _videoController!.pause()
                  //             : _videoController!.play();
                  //       });
                  //     }
                  //   },
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Center(
                  //         child: Container(
                  //           alignment: Alignment.center,
                  //           padding: EdgeInsets.all(14),
                  //           decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             color: Colors.grey.withOpacity(
                  //                 0.6), // Background color with transparency
                  //           ),
                  //           child: Icon(
                  //             _videoController != null &&
                  //                         _videoController!
                  //                             .value.isInitialized
                  //                 ? (_videoController!.value.isPlaying
                  //                     ? Icons.pause
                  //                     : Icons.play_arrow)
                  //                 : Icons
                  //                     .play_arrow, // Default icon when not initialized
                  //             size: 40,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Positioned(
                    top: displayHeight(context) * 0.07,
                    left: displayWidth(context) * 0.4,
                    child: GestureDetector(
                      onTap: () {
                        if (_videoController != null &&
                            _videoController!.value.isInitialized) {
                          setState(() {
                            if (_videoController!.value.isPlaying) {
                              _videoController!.pause();
                            } else {
                              // Restart video if it's completed
                              if (_videoController!.value.position ==
                                  _videoController!.value.duration) {
                                _videoController!.seekTo(Duration.zero);
                              }
                              _videoController!.play();
                            }
                          });
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(
                              0.6), // Background color with transparency
                        ),
                        child: Icon(
                          _videoController != null &&
                                  _videoController!.value.isInitialized
                              ? (_videoController!.value.isPlaying
                                  ? Icons.pause
                                  : _videoController!.value.position ==
                                          _videoController!.value.duration
                                      ? Icons
                                          .play_arrow // Show play icon if video is completed
                                      : Icons.play_arrow)
                              : Icons
                                  .play_arrow, // Default icon when not initialized
                          size: 40,
                        ),
                      ),
                    ),
                  )
                ],
              );
  }
}
