import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:visualizer/core/sorting_algorithm.dart';
import 'package:visualizer/screens/home_screen.dart';
import 'package:visualizer/widgets/PageView-Horizontal.dart';
import 'package:visualizer/widgets/buttons.dart';
import 'package:visualizer/widgets/dropDownMenu.dart';
import 'package:visualizer/widgets/text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/bar_visualization.dart';

class SelectionSortScreen extends StatefulWidget {
  const SelectionSortScreen({super.key});

  @override
  State<SelectionSortScreen> createState() => _SelectionSortState();
}

class _SelectionSortState extends State<SelectionSortScreen> {

  // ==================== Variables =======================
  bool isPause = false;
  late List<int> numbers;
  late List<Color> barColors;
  late Completer<void> completer;
  late int animationSpeed = 400;
  String dropDownValue = "Normal";
  bool isResetClicked = false;
  int time=0;
  Timer? timer;
  bool isTimerPaused= true;

  late List<int> numbersWorking = List<int>.from(numbers);
  late List<Color> barColorsWorking = List<Color>.from(barColors);

  List<String> Steps = [
    "Start with the first element as the minimum.",
    "Compare the minimum element with the rest of the array.",
    "If a smaller element is found, update the minimum.",
    "After traversing the array, swap the minimum with the first element.",
    "Move to the next index and repeat the process for the remaining elements.",
    "Continue until the entire array is sorted."
  ];

  // ==================/////////////==================================

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic>? data = Get.arguments;
    numbers = (data?["numbers"] as List<int>?) ?? [];
    barColors = (data?["barColors"] as List<Color>?) ?? [];
  }



  @override
  Widget build(BuildContext context) {

    // =============== Variables ==============================

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Color firstColor = Color(0xFFaffc41);
    Color secondColor = Color(0xFFaffc41);

    // ==================/////////////==================================


    // ================= Utilities ================================
    void repeatAnimations() {

      setState(() {
        isResetClicked = true;
        isPause = false;
        for (int i = 0; i < numbersWorking.length; i++) {
          numbersWorking[i] = numbers[i];
          barColorsWorking[i] = Colors.white;
        }
      });
    }

    void dropDownCallback(String selectedValue) {
      setState(() {
        dropDownValue = selectedValue;
        switch(dropDownValue){
          case "Normal":{animationSpeed = 400;break;}
          case "Slow":{animationSpeed = 600;break;}
          case "Fast":{animationSpeed = 200;break;}}
      });
    }

    // ==================/////////////==================================

    //================= Timer and Pause functionality ====================


    void starTimer(){
      if(!isPause){
      timer = Timer.periodic(Duration(milliseconds: 1), (val){
        setState(() {
          time++;
          isTimerPaused  = false;
        });;
      });
      }
    }

      void resumeTimer(){
      if(isTimerPaused && timer!=null){
        starTimer();
      }
    }

    void pauseTimer(){
      if( timer!=null){
        timer!.cancel();
      }
      setState(() {
        isTimerPaused = true;
      });

    }

    void resetTimer(){
      if(time!=null)
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

    // ==================/////////////==================================

    //=================Sorting Logic ==================================

    Future<void> selectionSort(
        List<int> numbers, List<Color> barColors, Function updateState) async {
      for (int i = 0; i < numbers.length; i++) {

        if(isResetClicked) break;

        for (int j = i + 1; j < numbers.length; j++) {

          if(isResetClicked) {
            updateState(() {
              barColors[j] = Colors.white;
              barColors[j] = Colors.white;
            });
            break;
          }

          updateState(() {
            barColors[i] = firstColor;
            barColors[j] = secondColor;
          });

          if (numbers[j] < numbers[i]) {
            //Swap
            int temp = numbers[j];
            numbers[j] = numbers[i];
            numbers[i] = temp;

            if(isPause){
              completer = Completer<void>();
              await completer!.future;
            }


            await Future.delayed(Duration(milliseconds: animationSpeed));
          }
          updateState(() {
            barColors[j] = Colors.white;
            barColors[j] = Colors.white;
          });
          // Delay between each step for visualization
          await Future.delayed(Duration(milliseconds: 100));
        }
        updateState(() {
          barColors[i] = Colors.white;
        });
      }

      pauseTimer();

    }

    Future<void> startSelectionSorting() async {

      setState(() {
        isResetClicked=false;
      });

      if(!isPause) {
        selectionSort(numbersWorking, barColorsWorking, (updateState) {
          setState(() {
            updateState();
          });
        });
      }
    }

    // ==================/////////////==================================




    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.05,),

              Center(
                  child: MText(input: "Selection Sort",fontSize: 0.055,color: Colors.white)),

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
                      isResetClicked = false;
                    });
                    starTimer();
                    startSelectionSorting();
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
                        onPressed:(){
                          resetTimer();
                          repeatAnimations();
                          } ,
                        label: MText(input: "Reset", fontSize: 0.03, color: Colors.white),icon: Icon(Icons.arrow_back,size: 30)
                    ),


                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(screenWidth * 0.4, screenHeight * 0.075),
                          foregroundColor: Colors.white,
                          backgroundColor:isPause ? Color(0xffe5383b) : Color(0xffe5383b),),
                        onPressed: (){
                          pauseTimer();
                          pause();
                          },
                        label: isPause?MText(input: "Play", fontSize: 0.03, color: Colors.white):MText(input: "Pause", fontSize: 0.03, color: Colors.white),
                        icon: isPause? Icon(Icons.play_arrow,size: 30): Icon(Icons.pause,size: 30,))]
              ),

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

                      MText(input: "${time.toString()} ms", fontSize: 0.023, color: Colors.white)
                    ],
                  ),
                ),
              ),


              SizedBox(height: screenHeight * 0.073),

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
