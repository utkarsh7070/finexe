
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomableImageWidget extends StatefulWidget {
  String? ImageUrl;

  ZoomableImageWidget({super.key, required this.ImageUrl});

  @override
  _ZoomableImageWidgetState createState() => _ZoomableImageWidgetState();
}

class _ZoomableImageWidgetState extends State<ZoomableImageWidget> {
  bool isZoomedIn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onDoubleTap: _closeZoomView, // Close on double tap
              child: Container(
                color: Colors.black, // Background color for zoom view
                child: PhotoView(
                  // imageProvider: FileImage(
                  //     File(widget.imageFile!.path)), // Use FileImage here
                  imageProvider: NetworkImage(widget.ImageUrl ?? ''),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _closeZoomView() {
    setState(() {
      isZoomedIn = false; // Close the zoomable view
    });
  }
}
