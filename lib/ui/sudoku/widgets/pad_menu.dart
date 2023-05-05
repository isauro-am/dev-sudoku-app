import 'package:flutter/material.dart';
import 'package:sudoku/constants/colors.dart';

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
    update() {
      setState(() {});
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Score: 0",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Mode: ${sudokuBoard.mode}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      "Errors: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "${sudokuBoard.error}",
                      style: TextStyle(
                        color: (sudokuBoard.error == 0)
                            ? Colors.white
                            : customColors.error,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NotesButton(
                update: update,
              ),
              CluesButton(
                update: update,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
