import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayVideo extends StatefulWidget {
  const PlayVideo({Key? key, required this.videoUrl}) : super(key: key);
  final String videoUrl;

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  late VideoPlayerController _videoPlayerController1;

  ChewieController? _chewieController;
  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: toggleVideo,
            iconData: Icons.live_tv_sharp,
            title: 'Toggle Video Src',
          ),
        ];
      },
    );
  }

  int currPlayIndex = 0;

  Future<void> toggleVideo() async {
    await _videoPlayerController1.pause();
    currPlayIndex = currPlayIndex == 0 ? 1 : 0;
    await initializePlayer();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(widget.videoUrl);

    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController1.dispose();
    _chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff9C27B0), Color(0xffBA68C8)],
              stops: [0.5, 1.0],
            ),
          ),
        ),
        title:  Text(
            AppLocalizations.of(context)!.playVideo,style: TextStyle(fontSize: 25),
        ),
      ),
      body: Center(
        child: _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? Chewie(
                controller: _chewieController!,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(AppLocalizations.of(context)!.loading,style: TextStyle(fontSize: 24),),
                ],
              ),
      ),
    );
  }
}
