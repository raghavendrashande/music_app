import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dsa_mini_project/components/neu_box.dart';
import 'package:dsa_mini_project/models/list_implement.dart';
import 'package:dsa_mini_project/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

bool playpause = false;


class SongPage extends StatefulWidget {
   const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {

  Music? nullhandler (){
    if(myPlaylist.getLength() == 0){
      return Music(
        songname: "", 
        artistname: "", 
        imageurl: "https://community.mp3tag.de/uploads/default/original/2X/a/acf3edeb055e7b77114f9e393d1edeeda37e50c9.png", 
        spotifylink: 'https://www2.cs.uic.edu/~i101/SoundFiles/BabyElephantWalk60.wav',
        duration: const Duration(minutes: 0, seconds:0)
      );
    }
    else{
      return myPlaylist.playing;
    }
  }

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    player.onPlayerComplete.listen((event) {
      // Play the next song when the current song completes
      setState(() {
        player.stop();
        myPlaylist.playNext();
        player.play(UrlSource(nullhandler()!.spotifylink));
      });
    });
  }

  @override
  Widget build(BuildContext context) {

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                NeuBox(
                  child:Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                          fit: BoxFit.contain,
                          width: 250,
                          height: 250,
                          image: NetworkImage(nullhandler()!.imageurl),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        nullhandler()!.songname,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      Text(
                        nullhandler()!.artistname,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.inversePrimary
                        ),
                      )
                    ],
                  ) 
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 25),
                  child: StreamBuilder(
                    stream: player.onPositionChanged, 
                    builder: (context,data){
                      return ProgressBar(
                      progressBarColor: Theme.of(context).colorScheme.inversePrimary,
                      progress:data.data??const Duration(minutes: 0, seconds:0), 
                      total: nullhandler()!.duration ?? const Duration(minutes:4),
                      baseBarColor: Theme.of(context).colorScheme.primary,
                      thumbColor: Theme.of(context).colorScheme.inversePrimary,
                      onSeek: (duratn){
                        player.seek(duratn);
                      },
                    );
                  })
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          if(myPlaylist.playing!.previous!=null){
                            setState(() {
                            player.stop();
                            myPlaylist.playPrev();
                            playpause=!playpause;
                            player.play(UrlSource(nullhandler()!.spotifylink));
                          });
                          }
                        },
                        child: const NeuBox(
                          child: Icon(Icons.skip_previous_rounded),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            playpause=!playpause;
                            if(playpause){
                              if(isPlaying){
                                player.resume();
                              }
                              else{
                                player.play(UrlSource(nullhandler()!.spotifylink));
                                isPlaying=true;
                              }
                            }
                            else {
                              player.pause();
                            }
                          });
                        },
                        child: NeuBox(
                          child: Icon(
                            playpause? Icons.pause:Icons.play_arrow
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          if(myPlaylist.playing!.next!=null){
                            setState(() {
                            player.stop();
                            myPlaylist.playNext();
                            player.play(UrlSource(nullhandler()!.spotifylink));
                          });
                          }
                        },
                        child: const NeuBox(
                          child: Icon(Icons.skip_next_rounded),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
