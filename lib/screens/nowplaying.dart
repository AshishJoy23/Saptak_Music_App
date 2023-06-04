import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:saptak_music_app/database/models/db_all_models.dart';
import 'package:saptak_music_app/screens/favorites/add_fav_from_now.dart';
import 'package:saptak_music_app/screens/playlists/add_from_now.dart';

class ScreenNowPlaying extends StatefulWidget {
  int index;

  ScreenNowPlaying({required this.index, super.key});
  @override
  State<ScreenNowPlaying> createState() => _ScreenNowPlayingState();
}

class _ScreenNowPlayingState extends State<ScreenNowPlaying> {
  bool isRepeat = false;
  late List<AllSongs> allDbSongs;
  final box = AllSongsBox.getInstance();
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId("0");

  @override
  void initState() {
    setState(() {});
    allDbSongs = box.values.toList();
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    final heightDsp = MediaQuery.of(context).size.height;
    final widthDsp = MediaQuery.of(context).size.width;
    return audioPlayer.builderCurrent(builder: (context, playing) {
      return Stack(
        children: [
          SizedBox(
            height: heightDsp,
            width: widthDsp,
            child: QueryArtworkWidget(
              artworkFit: BoxFit.cover,
              id: int.parse(playing.audio.audio.metas.id!),
              //id: allDbSongs[widget.index].id!,
              type: ArtworkType.AUDIO,
              artworkQuality: FilterQuality.high,
              size: 2000,
              quality: 100,
              artworkBorder: BorderRadius.circular(20),
              nullArtworkWidget: Container(
                width: widthDsp * 0.134,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/logo_foreground.png')),
                ),
                //child: Icon(Icons.abc),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              height: heightDsp,
              width: widthDsp,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(1),
                  ])),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: heightDsp * 0.06,
                          horizontal: widthDsp * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: 28,
                                color: Colors.white,
                              )),
                          AddPlstFromNow(songIndex:allDbSongs.indexWhere((element) =>
                                    element.id == int.parse(playing.audio.audio.metas.id!)))
                        ],
                      ),
                    ),
                    //const Spacer(),
                    Container(
                      height: heightDsp * 0.4,
                      width: widthDsp * 0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // image: DecorationImage(
                        //   image: AssetImage(widget.nowPlayingSong!.id.toString()),
                      ),
                      child: QueryArtworkWidget(
                        artworkFit: BoxFit.cover,
                        id: int.parse(playing.audio.audio.metas.id!),
                        //id: allDbSongs[widget.index].id!,
                        type: ArtworkType.AUDIO,
                        artworkQuality: FilterQuality.high,
                        size: 2000,
                        quality: 100,
                        artworkBorder: BorderRadius.circular(20),
                        nullArtworkWidget: Container(
                          width: widthDsp * 0.134,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/images/saptak_icon.png')),
                          ),
                          //child: Icon(Icons.abc),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(heightDsp * 0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: widthDsp * 0.75,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(0.0),
                              title: Marquee(
                                  animationDuration:
                                      const Duration(milliseconds: 5500),
                                  directionMarguee:
                                      DirectionMarguee.oneDirection,
                                  pauseDuration:
                                      const Duration(milliseconds: 1000),
                                  child: Text(
                                    audioPlayer.getCurrentAudioTitle,
                                    //allDbSongs[widget.index].songname!,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              subtitle: Text(
                                audioPlayer.getCurrentAudioArtist == '<unknown>'
                                    ? 'Unknown Artist'
                                    : audioPlayer.getCurrentAudioArtist,
                                //allDbSongs[widget.index].artist!,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: AddFavFromNow(index: allDbSongs.indexWhere((element) =>
                                    element.id == int.parse(playing.audio.audio.metas.id!))),
                            ),
                          ),
                          SizedBox(
                            height: heightDsp * 0.018,
                          ),
                          SizedBox(
                            width: widthDsp * 0.75,
                            child: PlayerBuilder.realtimePlayingInfos(
                              player: audioPlayer,
                              builder: (context, realtimePlayingInfos) {
                                final duration = realtimePlayingInfos
                                    .current!.audio.duration;
                                final position =
                                    realtimePlayingInfos.currentPosition;
                                return ProgressBar(
                                  progress: position,
                                  total: duration,
                                  progressBarColor: Colors.white,
                                  baseBarColor: Colors.white.withOpacity(0.5),
                                  thumbColor:
                                      const Color.fromARGB(255, 152, 248, 72),
                                  barHeight: 3.0,
                                  thumbRadius: 7.0,
                                  timeLabelTextStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  onSeek: (duration) {
                                    audioPlayer.seek(duration);
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: heightDsp * 0.02,
                    ),
                    SizedBox(
                      width: widthDsp * 0.75,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              iconSize: 30,
                              onPressed: () {
                                setState(() {
                                  isRepeat = !isRepeat;
                                });
                                if (isRepeat) {
                                  audioPlayer.setLoopMode(LoopMode.single);
                                } else {
                                  audioPlayer.setLoopMode(LoopMode.none);
                                }
                              },
                              icon: isRepeat
                                  ? const Icon(Icons.repeat_on,
                                      color: Colors.white)
                                  : const Icon(
                                      Icons.repeat,
                                      color: Colors.white,
                                    ),
                            ),
                            IconButton(
                              iconSize: 30,
                              onPressed: () {
                                setState(() {});
                                audioPlayer.toggleShuffle();
                              },
                              icon: audioPlayer.isShuffling.value
                                  ? const Icon(
                                      Icons.shuffle_on_outlined,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.shuffle,
                                      color: Colors.white,
                                    ),
                            ),
                          ]),
                    ),
                    SizedBox(height: heightDsp * 0.02),
                    Container(
                      width: widthDsp * 0.85,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PlayerBuilder.isPlaying(
                              player: audioPlayer,
                              builder: (context, isPlaying) {
                                return IconButton(
                                  iconSize: 35,
                                  onPressed: playing.index == 0
                                      ? () {}
                                      : () async {
                                          await audioPlayer.previous();
                                          if (!isPlaying) {
                                            audioPlayer.pause();
                                            setState(() {});
                                          }
                                        },
                                  icon: playing.index == 0
                                      ? Icon(
                                          Icons.skip_previous,
                                          color: Colors.white.withOpacity(0.4),
                                          size: 35,
                                        )
                                      : const Icon(
                                          Icons.skip_previous,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                );
                              }),
                          IconButton(
                            iconSize: 35,
                            onPressed: () async {
                              audioPlayer.seekBy(const Duration(seconds: -10));
                            },
                            icon: const Icon(Icons.replay_10,
                                color: Colors.white, size: 35),
                          ),
                          PlayerBuilder.isPlaying(
                              player: audioPlayer,
                              builder: (context, isPlaying) {
                                return IconButton(
                                  iconSize: 55,
                                  onPressed: () {
                                    audioPlayer.playOrPause();
                                  },
                                  icon: Icon(
                                    isPlaying
                                        ? Icons.pause_circle
                                        : Icons.play_circle,
                                    color:
                                        const Color.fromARGB(255, 152, 248, 72),
                                    size: 55,
                                  ),
                                );
                              }),
                          IconButton(
                            iconSize: 35,
                            onPressed: () async {
                              audioPlayer.seekBy(const Duration(seconds: 10));
                            },
                            icon: const Icon(Icons.forward_10,
                                color: Colors.white, size: 35),
                          ),
                          PlayerBuilder.isPlaying(
                              player: audioPlayer,
                              builder: (context, isPlaying) {
                                return IconButton(
                                  iconSize: 35,
                                  onPressed: playing.index ==
                                          playing.playlist.audios.length - 1
                                      ? () {}
                                      : () async {
                                          await audioPlayer.next();
                                          if (!isPlaying) {
                                            audioPlayer.pause();
                                            setState(() {});
                                          }
                                        },
                                  icon: playing.index ==
                                          playing.playlist.audios.length - 1
                                      ? Icon(
                                          Icons.skip_next,
                                          color: Colors.white.withOpacity(0.4),
                                          size: 35,
                                        )
                                      : const Icon(
                                          Icons.skip_next,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                );
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
