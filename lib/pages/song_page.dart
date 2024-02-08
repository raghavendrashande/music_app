import 'package:flutter/material.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Song page'),
      ),
      body:Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: (){

                },
               icon: Icon(Icons.arrow_back))
            ],
          )
        ],
      )
    );
  }
}