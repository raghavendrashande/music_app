import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Music{
  Music({
    required this.songname,
    required this.artistname,
    required this.imageurl,
    required this.spotifylink,
    required this.duration
  });
  String songname;
  String artistname;
  String imageurl;
  String spotifylink;
  Music? next;
  Music? previous;
  Duration? duration;
}

var player= AudioPlayer();

class Playlist {
  Music? head;
  Music? playing;

  // Add a song to the end of the playlist
  void addSongToEnd(String songName, String artistName, String imageUrl, String songUrl, Duration dur) {
    Music newNode = Music(songname: songName, artistname: artistName,imageurl: imageUrl, spotifylink: songUrl,duration: dur);
    if (head == null) {
      head = newNode;
      playing = head;
    } else {
      Music? current = head;
      while (current!.next != null) {
        current = current.next;
      }
      current.next = newNode;
      newNode.previous = current;
    }
  }

  void playNext(){
    if(playing!.next != null){
      playing=playing!.next;
    }
  }

  void playPrev(){
    if(playing!.previous != null){
      playing=playing!.previous;
  }
}

  // Get the length of the playlist
  int getLength() {
    int length = 0;
    Music? current = head;
    while (current != null) {
      length++;
      current = current.next;
    }
    return length;
  }

  Widget displayPlaylist() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: getLength(),
      itemBuilder: (BuildContext context, int index) {
        Music? current = getNodeAtIndex(index);
        return GestureDetector(
          onTap: (){
            player.stop();
            playing=current;  
            player.play(UrlSource(playing!.spotifylink));
          },
          child: ListTile(
            title: Text(current!.songname,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style:GoogleFonts.bebasNeue(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            ),
                          ),
            subtitle: Text(current.artistname,
            style:GoogleFonts.roboto(
                            fontWeight: FontWeight.w100,
                            fontSize: 10,
                            ),
                          ),
            leading: Image(image: NetworkImage(current.imageurl)),
          ),
        );
      },
    );
  }

  // Get the node at a specific index
  Music? getNodeAtIndex(int index) {
    if (index < 0 || index >= getLength()) {
      return null;
    }

    Music? current = head;
    for (int i = 0; i < index; i++) {
      current = current!.next;
    }
    return current;
  }
}
