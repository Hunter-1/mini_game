import 'package:flutter/material.dart';
import 'package:mini_game/components/pause_button.dart';
import 'package:mini_game/screens/main_menu.dart';

import '../space_fighter.dart';

class GameOverMenu extends StatelessWidget {
  static const String Id ="GameOverMenu";
  final SpaceFighter gameRef;
  GameOverMenu({Key? key, required this.gameRef,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Text("Game Over",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 50, fontFamily: 'Power', color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text("High Score: ${gameRef.highScore}",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 20, fontFamily: 'Power', color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text("Score ${gameRef.score}",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 20, fontFamily: 'Power', color: Colors.white)),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  gameRef.overlays.remove(GameOverMenu.Id);
                  gameRef.overlays.add(PauseButton.Id);
                  gameRef.reset();
                  gameRef.resumeEngine();
                },
                child: Text('Restart'),
              )),
          SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  gameRef.overlays.remove(GameOverMenu.Id);
                  gameRef.reset();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const MainMenu()));
                },
                child: Text('Exit'),
              )),
        ],
      ),
    );
  }
}
