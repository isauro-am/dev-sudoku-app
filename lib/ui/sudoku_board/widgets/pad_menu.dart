import 'package:flutter/material.dart';
import 'package:sudoku/ui/sudoku_board/widgets/pad_menu_button_game_mode.dart';

import '../../../constants/colors.dart';
import '../../../domain/game_control.dart';
import '../../../domain/sudoku_model.dart';
import 'pad_menu_button_clues.dart';
import 'pad_menu_button_notes.dart';

class PadMenu extends StatefulWidget {
  const PadMenu({Key? key}) : super(key: key);

  @override
  State<PadMenu> createState() => _PadMenuState();
}

class _PadMenuState extends State<PadMenu> {
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (gameControl.completed) ? const SizedBox() : const GameModeButton(),
          (gameControl.completed)
              ? const SizedBox()
              : const CluesButton(),
          (gameControl.completed) ? const SizedBox() : const NotesButton(),
          (gameControl.completed)
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                    Text(
                      "Errors:",
                      style: TextStyle(
                        color: customColors.primary,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${sudokuBoard.error}",
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: (sudokuBoard.error == 0)
                            ? customColors.primary
                            : customColors.error,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
