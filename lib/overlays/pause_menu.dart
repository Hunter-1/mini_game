import 'package:flutter/material.dart';
import 'package:mini_game/components/pause_button.dart';
import 'package:mini_game/screens/main_menu.dart';

import '../space_fighter.dart';

class PauseMenu extends StatelessWidget {
  static const String Id ="PauseMenu";
  final SpaceFighter gameRef;
  const PauseMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Text("Paused",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 50, fontFamily: 'Power', color: Colors.white)),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  gameRef.resumeEngine();
                  gameRef.overlays.remove(PauseMenu.Id);
                  gameRef.overlays.add(PauseButton.Id);
                },
                child: Text('Resume'),
              )),
          SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  gameRef.overlays.remove(PauseMenu.Id);
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
                  gameRef.overlays.remove(PauseMenu.Id);
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
