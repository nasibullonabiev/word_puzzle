import 'package:flutter/material.dart';
import 'package:word_puzzle/utils/game.dart';
import 'package:word_puzzle/widgets/colors.dart';
import 'package:word_puzzle/widgets/figure_image.dart';
import 'package:word_puzzle/widgets/letter.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  bool isFilled = false;
  //choosing the game word
  String word = "Monte-Carloo".toUpperCase();
  int myCoins = 100;

  //Create a list that contains the Alphabet, or you can just copy and paste it
  List<String> alphabets = [];



  @override
  void initState() {
    iterate();
    addAdditionalLetters();
    super.initState();
  }

  void iterate(){
    alphabets = word.split('').map((e) => e.toUpperCase()).toList();

    // for(int i = 0 ; i< word.length;i++){
    //   alphabets.add(word[i]);
    //   print(i);
    // }
    alphabets.shuffle();
  }

  List<String> trashLetters = [
    'H','V','F','Y','U'
  ];

  void addAdditionalLetters(){
    alphabets = List.from(trashLetters)..addAll(alphabets);
  }


  void openOne() {
    String one = '';
    myCoins = myCoins - 10;
    List<String> list = word.split('');
    List.generate(list.length, (index) {
      final e = list[index];
      if (!Game.selectedChar.contains(e.toUpperCase()) && one.isEmpty) {
        one = e;
      }
      return index;
    });
    // list.map((e) {
    //   print('aa');
    //   print("aa"+Game.selectedChar.length.toString());
    //   if (!Game.selectedChar.contains(e.toUpperCase()) && one.isEmpty) {
    //     one = e;
    //   }
    // });
    setState(() {});
    print(one);
    Game.selectedChar.add(one);
    letter(one.toUpperCase(), false);
  }

  bool isCanOpen() => myCoins >= 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    myCoins.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: !isCanOpen()
                        ? null
                        : () {
                      openOne();
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Center(
                child: Stack(
                  children: [
                    //let's make the figure widget
                    //let's add the images to the asset folder
                    //Okey now we will create a Game class
                    //Now the figure will be built according to the number of tries
                    figureImage(Game.tries == 0, 3),
                    figureImage(Game.tries == 1, 2),
                    figureImage(Game.tries == 2, 1),
                    figureImage(Game.tries == 3, 0),
                  ],
                ),
              ),
              //Now we will build the Hidden word widget
              //now let's go back to the Game class and add
              // a new variable to store the selected character
              /* and check if it's on the word */
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: word
                    .split('')
                    .map((e) => letter(e.toUpperCase(),
                    !Game.selectedChar.contains(e.toUpperCase())))
                    .toList(),
              ),
              //Now let's build the Game keyboard
              SizedBox(
                width: double.infinity,
                height: 250.0,
                child: GridView.count(
                  crossAxisCount: 7,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  padding: const EdgeInsets.all(8.0),
                  children: alphabets.map((e) {
                    return RawMaterialButton(

                      onPressed: Game.selectedChar.contains(e)
                          ? null // we first check that we didn't selected the button before
                          : () {
                        setState(() {
                          Game.selectedChar.add(e);
                          print(Game.selectedChar);
                          if (!word.split('').contains(e.toUpperCase())) {
                            Game.tries++;
                          }
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        e,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      fillColor: Game.selectedChar.contains(e)
                          ? Colors.red
                          : Colors.blue,
                    );
                  }).toList(),
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}
