import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minesweeper/bomb.dart';
import 'package:minesweeper/numberBox.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static int numberOfSquares = 9 * 9;
  int numberInEachRow = 9;
  var squareStatus = []; // [numbre of bombs around, revealed = true/false]
  bool bombsRevealed = false;
  Random r = new Random();

  final List<int> bombLocation = [
    //for(int i=0;i<=numberOfSquares;i++){}
    4,
    5,
    6,
    13,
    16,
    18,
    19,
    64,
    37,
    49,
    20,
    23,
    31,
  ];

  @override
  void initState() {
    super.initState();

    // başlangıçta tüm karelerin etrafında 0 bomba var ve açıklanmıyor
    for (int i = 0; i < numberOfSquares; i++) {
      squareStatus.add([0, false]);
    }
    scanBombs();
  }

  void revealBoxNumbers(int index) {
    if (squareStatus[index][0] != 0) {
      setState(() {
        squareStatus[index][1] = true;
      });
    } else if (squareStatus[index][0] == 0) {
      setState(() {
        // mevcut kutuyu göster
        squareStatus[index][1] = true;
        // en soldaki döşemede olmadıkça sol kutuyu göster
        if (index % numberInEachRow != 0) {
          if (squareStatus[index - 1][0] == 0 &&
              squareStatus[index - 1][1] == false) {
            revealBoxNumbers(index - 1);
          }
          squareStatus[index - 1][1] = true;
        }
        // sol üst kutuyu göster
        if (index % numberInEachRow != 0 && index >= numberInEachRow) {
          if (squareStatus[index - 1 - numberInEachRow][0] == 0 &&
              squareStatus[index - 1 - numberInEachRow][1] == false) {
            revealBoxNumbers(index - 1 - numberInEachRow);
          }
          squareStatus[index - 1 - numberInEachRow][1] = true;
        }
        // üst kutuyu göster
        if (index >= numberInEachRow) {
          if (squareStatus[index - numberInEachRow][0] == 0 &&
              squareStatus[index - numberInEachRow][1] == false) {
            revealBoxNumbers(index - numberInEachRow);
          }
          squareStatus[index - numberInEachRow][1] = true;
        }
        // sağ üst kutuyu göster
        if (index % numberInEachRow != numberInEachRow - 1 &&
            index >= numberInEachRow) {
          if (squareStatus[index - numberInEachRow + 1][0] == 0 &&
              squareStatus[index - numberInEachRow + 1][1] == false) {
            revealBoxNumbers(index - numberInEachRow + 1);
          }
          squareStatus[index - numberInEachRow + 1][1] = true;
        }
        // sağ kutuyu göster
        if (index % numberInEachRow != numberInEachRow - 1) {
          if (squareStatus[index + 1][0] == 0 &&
              squareStatus[index + 1][1] == false) {
            revealBoxNumbers(index + 1);
          }
          squareStatus[index + 1][1] = true;
        }
        // sağ alt kutuyu göster

        if (index % numberInEachRow != numberInEachRow - 1 &&
            index < numberOfSquares - numberInEachRow) {
          if (squareStatus[index + 1 + numberInEachRow][0] == 0 &&
              squareStatus[index + numberInEachRow + 1][1] == false) {
            revealBoxNumbers(index + 1 + numberInEachRow);
          }
          squareStatus[index + numberInEachRow + 1][1] = true;
        }
        // alttaki kutuyu göster
        if (index < numberOfSquares - numberInEachRow) {
          if (squareStatus[index + numberInEachRow][0] == 0 &&
              squareStatus[index + numberInEachRow][1] == false) {
            revealBoxNumbers(index + numberInEachRow);
          }
          squareStatus[index + numberInEachRow][1] = true;
        }
        // sol alt kutuyu göster
        if (index % numberInEachRow != 0 &&
            index < numberOfSquares - numberInEachRow) {
          if (squareStatus[index - 1 + numberInEachRow][0] == 0 &&
              squareStatus[index - 1 + numberInEachRow][1] == false) {
            revealBoxNumbers(index - 1 + numberInEachRow);
          }
          squareStatus[index - 1 + numberInEachRow][1] = true;
        }
      });
    }
  }

  void scanBombs() {
    for (int i = 0; i < numberOfSquares; i++) {
      int numberofBombsAround = 0;
      /* Check each square to see if there are bombs surrounding it
      There are 8 surrounding boxes to check
      */

      //soldaki kareyi kontrol et
      if (i % numberInEachRow != 0 && bombLocation.contains(i - 1)) {
        numberofBombsAround++;
      }
      // sol üstteki kareyi işaretleyin
      if (i % numberInEachRow != 0 &&
          i >= numberInEachRow &&
          bombLocation.contains(i - 1 - numberInEachRow)) {
        numberofBombsAround++;
      }

      //kareyi üste doğru kontrol et

      if (i >= numberInEachRow && bombLocation.contains(i - numberInEachRow)) {
        numberofBombsAround++;
      }
      //sağ üstteki kareyi kontrol et

      if (i % numberInEachRow != numberInEachRow - 1 &&
          i >= numberInEachRow &&
          bombLocation.contains(i + 1 - numberInEachRow)) {
        numberofBombsAround++;
      }
      //sağdaki kareyi kontrol et

      if (i % numberInEachRow != numberInEachRow - 1 &&
          bombLocation.contains(i + 1)) {
        numberofBombsAround++;
      }
      //sağ alttaki kareyi kontrol et

      if (i % numberInEachRow != numberInEachRow - 1 &&
          i < numberOfSquares - numberInEachRow &&
          bombLocation.contains(i + 1 + numberInEachRow)) {
        numberofBombsAround++;
      }
      //
      // kareyi aşağıdan yukarıya doğru kontrol et

      if (i < numberOfSquares - numberInEachRow &&
          bombLocation.contains(i + numberInEachRow)) {
        numberofBombsAround++;
      }
      //sol alttaki kareyi kontrol et
      if (i % numberInEachRow != 0 &&
          i < numberOfSquares - numberInEachRow &&
          bombLocation.contains(i - 1 + numberInEachRow)) {
        numberofBombsAround++;
      }
      setState(() {
        squareStatus[i][0] = numberofBombsAround;
      });
    }
  }

  void playerLost() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.purple.shade800,
            title: const Center(
              child: Text(
                'KAYBETTİNİZ',
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              Center(
                child: MaterialButton(
                  onPressed: () {
                    restartGame();
                    Navigator.pop(context);
                  },
                  color: Colors.purple.shade100,
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          );
        });
  }

  void playerWon() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.purple.shade800,
            title: const Center(
              child: Text(
                'KAZANDINIZ',
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              Center(
                child: MaterialButton(
                  onPressed: () {
                    restartGame();
                    Navigator.pop(context);
                  },
                  color: Colors.purple.shade100,
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          );
        });
  }

  void restartGame() {
    setState(() {
      bombsRevealed = false;
      for (int i = 0; i < numberOfSquares; i++) {
        squareStatus[i][1] = false;
      }
    });
  }

  void checkWinner() {
    int unRevealedBoxes = 0;
    for (int i = 0; i < numberOfSquares; i++) {
      if (squareStatus[i][1] == false) {
        unRevealedBoxes++;
      }
    }
    if (unRevealedBoxes == bombLocation.length) {
      playerWon();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade200,
      body: Column(
        children: [
          // game stats and menu
          Container(
            height: 150,
            // color: Colors.purple,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      bombLocation.length.toString(),
                      style: const TextStyle(fontSize: 40),
                    ),
                    const Text('BOMBA'),
                  ],
                ),
                GestureDetector(
                  onTap: restartGame,
                  child: Card(
                    color: Colors.purple[700],
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      '0',
                      style: TextStyle(fontSize: 40),
                    ),
                    Text('SÜRE'),
                  ],
                ),
              ],
            ),
          ),

          // Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: numberInEachRow,
              ),
              itemCount: numberOfSquares,
              itemBuilder: (BuildContext context, int index) {
                if (bombLocation.contains(index)) {
                  return MyBomb(
                    child: index,
                    revealed: bombsRevealed,
                    function: () {
                      //player tapped the bomb, they lose
                      setState(() {
                        bombsRevealed = true;
                      });
                      playerLost();
                    },
                  );
                } else {
                  return MyNumberBox(
                    child: squareStatus[index][0],
                    revealed: squareStatus[index][1],
                    function: () {
                      // reveal current box
                      revealBoxNumbers(index);
                      checkWinner();
                    },
                  );
                }
              },
            ),
          ),

          // Branding
          const Padding(
            padding: EdgeInsets.only(bottom: 40.0),
            child: Text('M A Y I N  T A R L A S I'),
          )
        ],
      ),
    );
  }
}
