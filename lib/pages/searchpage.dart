import 'dart:convert';
import 'package:dsa_mini_project/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
String query = "";

// ignore: must_be_immutable
class Searchpage extends StatefulWidget {
   Searchpage({super.key});

  @override
  State<Searchpage> createState() => _MainAppState();
}

class _MainAppState extends State<Searchpage> {
 final TextEditingController mycontroller = TextEditingController();

var image_url;
var song_name;
var artist_name;
var songLink;
var dur;
bool flag = false;

Widget searchresults(){
   if(flag==true){
    Future getId() async {
    final yt= YoutubeExplode();
    final result = (await yt.search.search(query)).first;
    final videoId = result.id.value;
    dur = result.duration;
    var streamManifest = await yt.videos.streamsClient.getManifest(videoId);
    var audioUrl = streamManifest.audioOnly.first.url;
    songLink = audioUrl.toString();
    var response = await http.get(Uri.https('v1.nocodeapi.com','/raghamusic/spotify/xfXPNsxqoASdSNAQ/search',{'q':query,'type':'track','perPage':'1'}));
    var jsondata = jsonDecode(response.body);
    image_url = jsondata['tracks']['items'][0]['album']['images'][0]['url'];
    song_name = jsondata['tracks']['items'][0]['name'];
    artist_name = jsondata['tracks']['items'][0]['artists'][0]['name'];
  }
  return FutureBuilder(
                  future: getId(), 
                  builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    return ListTile(
                      leading: Image(image: NetworkImage(image_url)),
                      title: Text(
                        song_name,
                        style:GoogleFonts.bebasNeue(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          ),
                        ),
                      subtitle: Text(
                        artist_name,
                        style:GoogleFonts.roboto(
                          fontWeight: FontWeight.w100,
                          fontSize: 10,
                          ),
                        ),
                        trailing: IconButton(onPressed: ()=>setState(() {
                          myPlaylist.addSongToEnd(song_name, artist_name, image_url, songLink, dur);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));                 
                          }), 
                          icon: const Icon(Icons.add)
                      ),
                    );
                  }
                  else {
                    return const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              );
           }
           else{
            return Container(height: 1);
           }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 275,
                      child: SearchBar(
                        controller: mycontroller,
                      ),
                    ),
                    IconButton(
                      onPressed:(){
                        setState((){
                          query=mycontroller.text;
                          flag=true;
                          mycontroller.text="";
                        });
                      },
                      icon: Icon(Icons.search),
                    )
                  ],
                ),
                searchresults()
            ],
          ),
        )
      ),
    );
  }
}