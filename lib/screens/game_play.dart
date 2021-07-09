import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mini_game/components/pause_button.dart';
import 'package:mini_game/overlays/game_over.dart';
import 'package:mini_game/overlays/pause_menu.dart';

import '../space_fighter.dart';

SpaceFighter spaceFighterGame = SpaceFighter();

class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          onWillPop: () async => false,
          child: GameWidget(
            game: spaceFighterGame,
            initialActiveOverlays: [PauseButton.Id],
            overlayBuilderMap: {
              PauseButton.Id: (BuildContext context, SpaceFighter gameRef) =>
                  PauseButton(gameRef: gameRef),
              PauseMenu.Id: (BuildContext context, SpaceFighter gameRef) =>
                  PauseMenu(gameRef: gameRef),
              GameOverMenu.Id: (BuildContext context, SpaceFighter gameRef,) =>
                  GameOverMenu(gameRef: gameRef),
          },
          )),
    );
  }
}
