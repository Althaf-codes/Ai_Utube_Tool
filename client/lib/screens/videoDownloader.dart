import 'package:flutter/material.dart';

class VideoDownloaderScreen extends StatefulWidget {
  const VideoDownloaderScreen({Key? key}) : super(key: key);

  @override
  _VideoDownloaderScreenState createState() => _VideoDownloaderScreenState();
}

class _VideoDownloaderScreenState extends State<VideoDownloaderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {},
        child: Center(
          child: Container(
            child: Text('download',
                style: TextStyle(color: Colors.white, fontSize: 15)),
          ),
        ),
      ),
    );
  }
}
