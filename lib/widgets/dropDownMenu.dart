import 'package:flutter/material.dart';
import 'package:visualizer/widgets/text.dart';

class MyDropDownMenu extends StatelessWidget {
  Color MenuClr;
  String dropDownValue;
  Function function;
  MyDropDownMenu({super.key,required this.dropDownValue,required this.MenuClr, required this.function});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth*0.45,
      height: screenHeight*0.07,
      decoration: BoxDecoration(
        color: MenuClr,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Center(
        child: DropdownButton(items: [
          DropdownMenuItem( child:MText(input: "Normal", fontSize: 0.025, color: Colors.white),value: "Normal"),
          DropdownMenuItem(child: MText(input: "Slow", fontSize: 0.025, color: Colors.white),value: "Slow",),
          DropdownMenuItem(child: MText(input: "Fast", fontSize: 0.025, color: Colors.white),value: "Fast",),
        ],
          hint: MText(input: "Speed", fontSize: 0.02, color: Colors.white),
          dropdownColor: Colors.black,
          value: dropDownValue,
          onChanged:(value)=>function(value),
          iconSize: 40,
          // icon: Icon(Icons.timelapse),
          iconEnabledColor: Colors.white,
          iconDisabledColor: Colors.grey,
          underline: SizedBox(),


        ),
      ),
    );
  }
}
