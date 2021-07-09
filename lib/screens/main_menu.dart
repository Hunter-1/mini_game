import 'package:flutter/material.dart';

import 'game_play.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Text("Space Fighter",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: 50, fontFamily: 'Power', color: Colors.white)),
      ),
      SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const GamePlay(),
          ));
        },
        child: Text('Play'),
      )),
    ])));
  }
}
