import 'package:chewie/chewie.dart';
import 'package:kake_autoparts/Constants/exports.dart';
import 'package:video_player/video_player.dart';

class ProductVideo extends StatefulWidget {
  final String videoUrl;
  const ProductVideo({super.key, required this.videoUrl});

  @override
  State<ProductVideo> createState() => _ProductVideoState();
}

class _ProductVideoState extends State<ProductVideo> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse('$imgPath/${widget.videoUrl}'),
    );
    videoPlayerController.initialize().then((_) {
      setState(() {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          aspectRatio: 16 / 9,
          autoPlay: true,
          looping: false,
        );
      });
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController.value.isInitialized) {
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 16 / 9,
        autoPlay: true,
        looping: false,
      );
      return Scaffold(
        appBar: AppBar(
          title: const Text("Watch the product's demo"),
        ),
        body: Chewie(controller: chewieController),
      );
    } else {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
