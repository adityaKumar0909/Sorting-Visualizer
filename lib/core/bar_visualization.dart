// import 'package:flutter/material.dart';
//
// class BarVisualization extends StatefulWidget {
//   final List<int> numbers;
//   final List<Color> barColors;
//
//   const BarVisualization(
//       {super.key, required this.numbers, required this.barColors});
//
//   @override
//   State<BarVisualization> createState() => _BarVisualizationState();
// }
//
// class _BarVisualizationState extends State<BarVisualization> {
//   @override
//   Widget build(BuildContext context) {
//     //screen height and width
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     //gap between bar and text
//     double SizedBoxMediumGap = screenHeight * 0.020;
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: widget.numbers
//           .asMap()
//           .map((index, num) {
//             return MapEntry(
//               index,
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     AnimatedContainer(
//                       curve: Curves.easeInOut,
//                       duration: Duration(microseconds: 500),
//                       // ,Container(
//                       height: num.toDouble() * screenHeight * 0.007,
//                       width: screenWidth * 0.065,
//                       // color: Colors.black,
//                       decoration: BoxDecoration(
//                         color: widget.barColors[index],
//                         borderRadius: BorderRadius.circular(0),
//                       ),
//                       // ),
//                     ),
//                     SizedBox(height: SizedBoxMediumGap),
//                     Text(
//                       '$num',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.bold,
//                         fontSize: screenWidth * 0.030,
//                       ),
//                     ),
//                     SizedBox(height: SizedBoxMediumGap),
//                   ],
//                 ),
//               ),
//             );
//           })
//           .values
//           .toList(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:visualizer/widgets/text.dart';

class BarVisualization extends StatefulWidget {
  List<int> numbers;
  List<Color> barColors;
  BarVisualization({super.key,required this.numbers,required this.barColors});

  @override
  State<BarVisualization> createState() => _BarVisualizationState();
}

class _BarVisualizationState extends State<BarVisualization> {


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for(var i = 0;i<widget.numbers.length;i++)
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      height: widget.numbers[i]*screenHeight*0.007,
                      width: screenWidth*0.06,
                      decoration: BoxDecoration(
                        color: widget.barColors[i],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    SizedBox(height: screenHeight*0.02,),

                    MText(input: "${widget.numbers[i]}", fontSize: 0.015, color: Colors.white),


                  ],
                ),
              )
      ],
    );
  }
}
