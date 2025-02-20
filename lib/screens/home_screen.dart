
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visualizer/core/array_generator.dart';
import 'package:visualizer/core/bar_visualization.dart';
import 'package:visualizer/screens/bubbleSort.dart';
import 'package:visualizer/screens/quickSort.dart';
import 'package:visualizer/screens/selectionSort.dart';
import 'package:visualizer/widgets/buttons.dart';
import 'package:visualizer/widgets/text.dart';

import 'insertionSort.dart';
import 'mergeSort.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variables
  List<int> numbers = [];
  List<int> bubbleArray= [];
  List<int> insertionArray= [];
  List<int> selectionArray= [];
  List<int> mergeArray= [];
  List<int> countArray= [];
  List<int> quickArray= [];


  late List<Color> barColors;
  late List<Color> barColorsBubble;
  late List<Color> barColorsInsertion;
  late List<Color> barColorsSelection;
  late List<Color> barColorsMerge;
  late List<Color> barColorsCount;
  late List<Color> barColorsQuick;



  late String selectedOption;

  @override
  void initState() {
    super.initState();
    generateArray();
    bubbleArray = numbers;
    insertionArray = numbers;
    insertionArray = numbers;
    selectionArray = numbers;
    mergeArray = numbers;
    countArray = numbers;
    quickArray = numbers;
    barColors = List.generate(numbers.length, (index) => Color(0xff403d39));
    barColorsBubble = barColors;
    barColorsInsertion = barColors;
    barColorsSelection = barColors;
    barColorsMerge = barColors;
    barColorsCount = barColors;
    barColorsQuick = barColors;
  }

  // For generating a random array
  void generateArray() {
    setState(() {
      numbers = ArrayGenerator.generateRandomArray(10, 50);
      bubbleArray = numbers;
      insertionArray = numbers;
      insertionArray = numbers;
      selectionArray = numbers;
      mergeArray = numbers;
      countArray = numbers;
      quickArray = numbers;
      barColors = List.generate(numbers.length, (index) => Color(0xff403d39));
      barColorsBubble = barColors;
      barColorsInsertion = barColors;
      barColorsSelection = barColors;
      barColorsMerge = barColors;
      barColorsCount = barColors;
      barColorsQuick = barColors;
    });
  }

  // For shuffling the array
  void shuffle() {
    setState(() {
      numbers = ArrayGenerator.shuffleArray(numbers);
      bubbleArray = numbers;
      insertionArray = numbers;
      insertionArray = numbers;
      selectionArray = numbers;
      mergeArray = numbers;
      countArray = numbers;
      quickArray = numbers;
      barColors = List.generate(numbers.length, (index) => Color(0xff403d39));
      barColorsBubble = barColors;
      barColorsInsertion = barColors;
      barColorsSelection = barColors;
      barColorsMerge = barColors;
      barColorsCount = barColors;
      barColorsQuick = barColors;
    });
  }

  Future<void> startBubbleSort() async {
    Get.to(()=>BubbleSortScreen(),transition:Transition.circularReveal,duration: Duration(milliseconds: 1000) ,arguments: {
      "numbers" : bubbleArray,
      "barColors": barColorsBubble,
    });
  }

  Future<void> startSelectionSort() async {

    Get.to(()=>SelectionSortScreen(),transition:Transition.circularReveal,duration: Duration(milliseconds: 300) ,arguments: {
      "numbers" : bubbleArray,
      "barColors": barColorsBubble,
    });
  }

  Future<void> startInsertionSort() async {

    Get.to(()=>InsertionSortScreen(),transition:Transition.circularReveal,duration: Duration(milliseconds: 1000) ,arguments: {
      "numbers" : bubbleArray,
      "barColors": barColorsBubble,
    });
  }

  Future<void> startMergeSort() async {

    Get.to(MergeSortScreen(),transition:Transition.circularReveal,duration: Duration(milliseconds: 1000) ,arguments: {
      "numbers" : bubbleArray,
      "barColors": barColorsBubble,
    });
  }

  Future<void> startQuickSort() async {

    Get.to(QuickSortScreen(),transition:Transition.circularReveal,duration: Duration(milliseconds: 1000) ,arguments: {
      "numbers" : bubbleArray,
      "barColors": barColorsBubble,
    });
  }
  @override
  Widget build(BuildContext context) {
    // Screen size variables
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    Color primaryColor = Theme.of(context).colorScheme.primary;
    Color surfaceColor = Theme.of(context).colorScheme.surface;


    // Font variables
    double appBarFontSize = screenHeight * 0.03;

    void _showBottomSheet() {

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        transitionAnimationController: AnimationController(
          vsync: Navigator.of(context),
          duration: Duration(milliseconds: 200),
        ),
        builder: (context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.2,
            maxChildSize: 0.6,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Color(0xff353535),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down, color: Colors.white,size: 50,),
                          onPressed: () => Navigator.pop(context), // Close on tap
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Center(child: MText(input: "Settings", fontSize: 0.05, color: Colors.white)),

                            SizedBox(height: screenHeight * 0.03),



                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    }


    return Scaffold(
      backgroundColor: surfaceColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.055,
              ),
              Container(
                height: screenHeight*0.2,
                width: screenWidth*0.95,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [



                      Flexible(
                        child: MText(
                            input: "Sorting Visualizer",
                            fontSize: 0.065,
                            color: secondaryColor),
                      ),

                      IconButton(onPressed: (){_showBottomSheet();}, icon: Icon(Icons.settings,size: 35,color: secondaryColor,),),


                    ],
                  ),
                ),
              ),

              SizedBox(
                height: screenHeight * 0.025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MElevatedButton("Bubble", Colors.white, primaryColor,
                      startBubbleSort, 0.025),
                  MElevatedButton("Selection", Colors.white, primaryColor,
                      startSelectionSort, 0.025),
                  MElevatedButton("Insertion", Colors.white, primaryColor,
                      startInsertionSort, 0.025),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MElevatedButton("Quick", Colors.white, primaryColor,
                      startQuickSort, 0.026),

                  MElevatedButton("Merge", Colors.white, primaryColor,
                      startMergeSort, 0.026),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MElevatedButton("New Array", Colors.white, Color(0xFF7209B7),
                      generateArray, 0.027),
                  MElevatedButton("Shuffle", Colors.white, Color(0xFFfb6f92),
                      shuffle, 0.03),
                ],
              ),
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.42,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: BarVisualization(
                        numbers: numbers, barColors: barColors)),
              )
            ],
          ),
        ),
      ),
    );
  }
}




