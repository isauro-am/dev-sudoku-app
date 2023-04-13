import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:sudoku/constants/game_tags.dart';
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
          (gameControl.completed || gameControl.errorLimit == sudokuBoard.error) ? const SizedBox() : const GameModeButton(),
          (gameControl.completed || gameControl.errorLimit == sudokuBoard.error)
              ? const SizedBox()
              : const CluesButton(),
          (gameControl.completed || gameControl.errorLimit == sudokuBoard.error) ? const SizedBox() : const NotesButton(),
          (gameControl.completed || gameControl.errorLimit == sudokuBoard.error)
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                    Text(
                      gameTags.gcErrors,
                      style: TextStyle(
                        color: customColors.primary,
                        fontSize: 0.8.rem,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${sudokuBoard.error}",
                      style: TextStyle(
                        fontSize: 0.9.rem,
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
