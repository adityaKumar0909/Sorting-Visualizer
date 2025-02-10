import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:visualizer/widgets/dropDownMenu.dart';
import 'package:visualizer/widgets/text.dart';
import '../core/bar_visualization.dart';
import '../widgets/PageView-Horizontal.dart';

class BubbleSortScreen extends StatefulWidget {
  const BubbleSortScreen({super.key});

  @override
  State<BubbleSortScreen> createState() => _BubbleSortState();
}

class _BubbleSortState extends State<BubbleSortScreen> {

  //====================Variables========================

  bool isPause = false;
  late List<int> numbers;
  late List<Color> barColors;
  late Completer<void> completer;
  late int animationSpeed = 400;
  String dropDownValue = "Normal";
  int time=0;
  Timer? timer = null ;
  bool isResetClicked = false;
  bool isTimerPaused = true;
  bool isSorted=false;

  late List<int> numbersWorking = List<int>.from(numbers);
  late List<Color> barColorsWorking = List<Color>.from(barColors);


  List<String> Steps = [
    "Start at the beginning of the array.",
    "Compare the first two elements.",
    "If the first element is greater than the second, swap them.",
    "Move to the next pair of elements and repeat the comparison.",
    "Continue this process until the last element.",
    "After the first pass, the largest element is placed at the end.",
    "Repeat the process for the remaining unsorted part of the array.",
    "Continue until no swaps are needed, meaning the array is sorted."
  ];

  //===================Variables End========================

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic>? data = Get.arguments;
    numbers = (data?["numbers"] as List<int>?) ?? [];
    barColors = (data?["barColors"] as List<Color>?) ?? [];

  }


  @override
  Widget build(BuildContext context) {


    // ================ Variables ==========================
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Color firstColor = Color(0xFFaffc41);
    Color secondColor = Color(0xFFaffc41);

    // =============  //////////////  =======================

    // ============= Utilities ===========================
    void repeatAnimations() {

      setState(() {
        isSorted = false;
        isResetClicked = true;
        isPause = false;
        for (int i = 0; i < numbersWorking.length; i++) {
          numbersWorking[i] = numbers[i];
          barColorsWorking[i] = Colors.white;
        }

      });
    };

    void dropDownCallback(String selectedValue) {
      setState(() {
        dropDownValue = selectedValue;
        switch(dropDownValue){
          case "Normal":{animationSpeed = 400;break;}
          case "Slow":{animationSpeed = 600;break;}
          case "Fast":{animationSpeed = 300;break;}}
      });
    }

    //=================///////////========================

    // ============ Pause & Timer functionality ============


    void pauseTimer(){
      print("inside pause timer");
      if(timer!=null){
        timer!.cancel();
        setState(() {
          isTimerPaused = true;
        });
      }

    }

    void startTimer(){
      if(!isPause) {
        timer = Timer.periodic(Duration(milliseconds: 1), (val) {
          setState(() {
            time++;
            isTimerPaused = false;
          });
        });
      }
    }

    void resumeTimer(){
      if(isTimerPaused && timer!=null)
        startTimer();
    }

    void resetTimer(){
      if(timer!=null)
        timer!.cancel();

      setState(() {
        time = 0;
        isTimerPaused = true;
      });
    }

    void pause() {

      setState(() {

        isPause = !isPause;
        if (!isPause) {
          completer.complete();
          resumeTimer();
        }
      });
    }

    // ============ //////////////////////// ==================


    //============= Sorting Logic =============================

    Future<void> bubbleSort(
        List<int> numbers, List<Color> barColors, Function updateState) async {
      for (int i = 0; i < numbers.length - 1; i++) {

        if(isResetClicked) break;


        for (int j = 0; j < numbers.length - i - 1; j++) {


          //See if the pause button is not clicked
          while (isPause) {
            // await Future.delayed(Duration(milliseconds: 100));
            completer = Completer<void>();
            await completer!.future;
          }

          if(isResetClicked) break;


          //The bars which are being compared is marked with a different color
          //for highlighting
          updateState(() {
            barColors[j] = firstColor;
            barColors[j + 1] = secondColor;
          });
          if (numbers[j] > numbers[j + 1]) {
            // Swap
            int temp = numbers[j];
            numbers[j] = numbers[j + 1];
            numbers[j + 1] = temp;

            // Delay for animation
            await Future.delayed(Duration(milliseconds: animationSpeed));
          }
          //After comparing and swapping ends , Make the bars color back to
          //black
          updateState(() {
            barColors[j] = Colors.white;
            barColors[j + 1] = Colors.white;
          });

          // Delay between each step for visualization
          await Future.delayed(Duration(milliseconds: 50));
        }
      }

      pauseTimer();

    }

    Future<void> startBubbleSorting() async {

      setState(() {
        isSorted = false;
        isResetClicked = false;
      });

        await bubbleSort(numbersWorking, barColorsWorking, (updateState) {
          setState(() {
            updateState();
          });
        });

    }

    //============= ////////////////////// =============================




    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.05,),

              Center(
                  child: MText(input: "Bubble Sort",fontSize: 0.067,color: Colors.white)),

              SizedBox(height: screenHeight * 0.02,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(child: Divider(thickness: 1.5,color: Colors.white))),

              SizedBox(width: screenWidth,height: screenHeight * 0.43,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: BarVisualization(numbers: numbersWorking,barColors: barColorsWorking))),

              SizedBox(height: screenHeight*0.05,),

              Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(width:screenWidth*0.35 ,height: screenHeight*0.07,child: ElevatedButton(onPressed: (){
                     setState(() {
                       if(isTimerPaused )
                         startTimer();
                       isResetClicked = false;
                     });
                    startBubbleSorting();
                    }
                      ,style: ElevatedButton.styleFrom(backgroundColor: Color(0xff495057)), child: MText(input: "Sort", fontSize: 0.04, color: Colors.white))),

                  MyDropDownMenu(dropDownValue: dropDownValue,MenuClr: Color(0xff495057),function: dropDownCallback),

                ],
              ),

              SizedBox(height: screenHeight * 0.02,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth * 0.4, screenHeight * 0.075),
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xff495057)),
                    onPressed: (){
                      resetTimer();
                      repeatAnimations();
                      setState(() {});
                      },

                    label: MText(input: "Reset", fontSize: 0.03, color: Colors.white),icon: Icon(Icons.arrow_back,size: 30)),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth * 0.4, screenHeight * 0.075),
                      foregroundColor: Colors.white,
                      backgroundColor:isPause ? Color(0xffe5383b) : Color(0xffe5383b),),
                    onPressed: (){
                      pauseTimer();
                      pause();},
                    label: isPause?MText(input: "Play", fontSize: 0.03, color: Colors.white):MText(input: "Pause", fontSize: 0.03, color: Colors.white),
                    icon: isPause? Icon(Icons.play_arrow,size: 30): Icon(Icons.pause,size: 30,))]),

              SizedBox(height: screenHeight * 0.05),

              Container(
                width: screenWidth*0.85,
                height: screenHeight*0.07,
                decoration:BoxDecoration(
                  color: Color(0xffff4d6d),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth*0.025),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MText(input: "Time elapsed : ", fontSize: 0.025, color: Colors.white),

                      MText(input: "${time} ms", fontSize: 0.023, color: Colors.white)
                    ],
                  ),
                ),
              ),


              SizedBox(height: screenHeight * 0.063),

              MText(input: "How It's Done ?", fontSize: 0.05, color: Colors.white),

              SizedBox(height: screenHeight * 0.03),

              PageViewHorizontal(Item: Steps),

              SizedBox(height: screenHeight * 0.03),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal :screenWidth*0.08),
                    child: MText(input: "Time Complexity : ", fontSize: 0.025, color: Colors.white),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal :screenWidth*0.08),
                    child: MText(input: "O(N^2)", fontSize: 0.025, color: Colors.white),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.05),
              


            ],
          ),
        ),
      ),
    );
  }
}
