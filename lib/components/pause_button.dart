import 'package:flutter/material.dart';
import 'package:mini_game/overlays/pause_menu.dart';
import 'package:mini_game/space_fighter.dart';

class PauseButton extends StatelessWidget {
  static const String Id ="PauseButton";
  final SpaceFighter gameRef;
  const PauseButton({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: TextButton(
        onPressed: () {gameRef.pauseEngine();
        gameRef.overlays.add(PauseMenu.Id);
        gameRef.overlays.remove(PauseButton.Id);
        },
        child: Icon(
          Icons.pause_rounded,
          color: Colors.white,
        )
      )
    );
  }
}