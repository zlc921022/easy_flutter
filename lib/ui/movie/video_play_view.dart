import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/common_title_view.dart';
import 'package:video_player/video_player.dart';

class VideoPlayView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new VideoPlayViewState();
  }
}

class VideoPlayViewState extends State<VideoPlayView> {
  String url = "http://vt1.doubanio.com/202001052046/8809c21648b5285cdcb557863191927c/view/movie/M/302570352.mp4";
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = new VideoPlayerController.network(url);
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
      appBar: CommonAppBar(context,'视频播放'),
      body: Container(
        color: AppColor.black,
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }
}
