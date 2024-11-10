import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/presentation/blocs/videos/videos_bloc.dart';
import 'package:movieapp/presentation/journeys/watch_video/watch_video_arguments.dart';
import 'package:movieapp/presentation/journeys/watch_video/watch_video_screen.dart';
import 'package:movieapp/presentation/widgets/button.dart';

class VideosWidget extends StatelessWidget {
  const VideosWidget({super.key, required this.videosBloc});

  final VideosBloc videosBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: videosBloc,
      builder: (context, state) {
        if (state is VideosLoaded && state.videos.iterator.moveNext()) {
          final _videos = state.videos;
          return SizedBox(
            width: double.infinity,
            child: Button(
              title: TranslationConstants.watchTarilers.t(context),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WatchVideoScreen(
                      watchVideoArguments: WatchVideoArguments(
                        videos: _videos,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
