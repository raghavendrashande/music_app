import 'package:dsa_mini_project/components/my_drawer.dart';
import 'package:dsa_mini_project/models/list_implement.dart';
import 'package:dsa_mini_project/pages/nav_page.dart';
import 'package:dsa_mini_project/pages/searchpage.dart';
import 'package:flutter/material.dart';

   Playlist myPlaylist = Playlist();


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("M Y T U N E S"),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Searchpage()
              ),
            );
          }, 
          icon: const Icon(Icons.search)
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: MyHomePage()
    );
  }
}

