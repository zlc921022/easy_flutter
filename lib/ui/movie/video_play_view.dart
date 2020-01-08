import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_app_bar.dart';
import 'package:flutter_movie/util/screen.dart';
import 'package:video_player/video_player.dart';

class VideoPlayView extends StatefulWidget {
  final String url;
  final String title;
  VideoPlayView({@required this.url,this.title});

  @override
  State<StatefulWidget> createState() {
    return new VideoPlayViewState();
  }
}

class VideoPlayViewState extends State<VideoPlayView> {
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = new VideoPlayerController.network(widget.url);
    chewieController = new ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      aspectRatio: 3 / 2,
      looping: true,
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.black,
        leading: GestureDetector(
          onTap: (){
            AppNavigator.back(context);
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 0, 0),
            child: Image.asset('images/icon_arrow_back_white.png'),
          ),
        ),
      ),
      body: Container(
        color: AppColor.black,
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }
}
