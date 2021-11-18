import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tic_tac/custom_dialogue.dart';

import 'game_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<GameButton> buttonsList;
  var player1;
  var player2;
  var activePlayer;

  void initState(){
    super.initState();
    buttonsList = doInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Tic Tac Toe"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(10.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 18.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: buttonsList.length,
                  itemBuilder: (context, i) => new SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: RaisedButton(
                        padding: EdgeInsets.all(8.0),
                        onPressed: buttonsList[i].enabled ? () => playGame(buttonsList[i]) : null,
                        child: Text(buttonsList[i].text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          ),
                        ),
                      color: buttonsList[i].bg,
                      disabledColor: buttonsList[i].bg,
                    ),
                  ),
              ),
          ),
          RaisedButton(
            onPressed: resetGame,
            child: Text("Reset",
            style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            ),
          ),
          color: Colors.red,
          padding: EdgeInsets.all(20.0),
          ),
        ],
      ),
    );
  }
  List<GameButton> doInit(){
    player1 = [];
    player2 = [];
    activePlayer = 1;

    var allGamesButton = [
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];
    return allGamesButton;
  }

  void playGame(GameButton gb){
    setState(() {
      if(activePlayer == 1){
        gb.text = "X";
        gb.bg = Colors.red;
        activePlayer = 2;
        player1.add(gb.id);
      }
      else{
        gb.text = "O";
        gb.bg = Colors.black;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;
      int winner = checkWinner();
      if(winner == -1){
        if(buttonsList.every((element) => element.text != "")){
          showDialog(
            context: context, 
            builder: (context) => CustomDialogue("Game Tied", 
                "Press the reset button to start again.", resetGame),
          );
        }
        else{
          activePlayer == 2 ? autoPlay() : null;
        }
      }
    });
  }

  int checkWinner() {
    var winner = -1;
    // row1
    if(player1.contains(1) && player1.contains(2) && player1.contains(3)){
      winner = 1;
    }
    if(player2.contains(1) && player2.contains(2) && player2.contains(3)){
      winner = 2;
    }
    // row2
    if(player1.contains(4) && player1.contains(5) && player1.contains(6)){
      winner = 1;
    }
    if(player2.contains(4) && player2.contains(5) && player2.contains(6)){
      winner = 2;
    }
    // row3
    if(player1.contains(7) && player1.contains(8) && player1.contains(9)){
      winner = 1;
    }
    if(player2.contains(7) && player2.contains(8) && player2.contains(9)){
      winner = 2;
    }
    // column1
    if(player1.contains(1) && player1.contains(4) && player1.contains(7)){
      winner = 1;
    }
    if(player2.contains(1) && player2.contains(4) && player2.contains(7)){
      winner = 2;
    }
    // column2
    if(player1.contains(2) && player1.contains(5) && player1.contains(8)){
      winner = 1;
    }
    if(player2.contains(2) && player2.contains(5) && player2.contains(8)){
      winner = 2;
    }
    // column3
    if(player1.contains(3) && player1.contains(6) && player1.contains(9)){
      winner = 1;
    }
    if(player2.contains(3) && player2.contains(6) && player2.contains(9)){
      winner = 2;
    }
    // diagonalLeft->Right
    if(player1.contains(1) && player1.contains(5) && player1.contains(9)){
      winner = 1;
    }
    if(player2.contains(1) && player2.contains(5) && player2.contains(9)){
      winner = 2;
    }
    // diagonalRight->Left
    if(player1.contains(3) && player1.contains(5) && player1.contains(7)){
      winner = 1;
    }
    if(player2.contains(3) && player2.contains(5) && player2.contains(7)){
      winner = 2;
    }

    if(winner != -1){
      if(winner == 1){
        showDialog(
            context: context,
            builder: (context) => CustomDialogue("Player 1 Won", "Press the reset button to start again.", resetGame),
        );
      }else{
        showDialog(
          context: context,
          builder: (context) => CustomDialogue("Player 2 Won", "Press the reset button to start again.", resetGame),
        );
      }
    }
    return winner;
  }
  
  void resetGame(){
    if(Navigator.canPop(context)){
      Navigator.pop(context);
      setState(() {
        buttonsList = doInit();
      });
    }else{
      setState(() {
        buttonsList = doInit();
      });
    }
  }

  autoPlay() {
    var emptyCells = [];
    var list = new List.generate(9, (index) => index + 1);
    for(var cellID in list){
      if(!(player1.contains(cellID) || (player2.contains(cellID)))){
        emptyCells.add(cellID);
      }
    }
    var r = new Random();
    var randIndex = r.nextInt(emptyCells.length-1);
    var cellID = emptyCells[randIndex];
    int i = buttonsList.indexWhere((element) => element.id == cellID);
    playGame(buttonsList[i]);
  }
  
}
