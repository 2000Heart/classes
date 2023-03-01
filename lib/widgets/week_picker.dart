import 'package:classes/res/utils.dart';
import 'package:flutter/material.dart';

class WeekPicker extends StatefulWidget {
  const WeekPicker({Key? key, required this.length}) : super(key: key);

  final int length;
  @override
  State<WeekPicker> createState() => _WeekPickerState();
}

class _WeekPickerState extends State<WeekPicker> {
  late List<int> weeks = List.generate(widget.length, (index) => index+1);
  late List<int> result = weeks;
  late List<bool> choose = List.generate(widget.length, (index) => true);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("取消"),
            Text("确认")
          ],
        ),
        Expanded(
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 6,
            shrinkWrap: true,
            childAspectRatio: 1,
            children: weeks.map((e) => item(e)).toList(),
          ),
        )
      ],
    );
  }

  Widget item(int text){
    return GestureDetector(
      onTap: (){
        setState(() {
          choose[text] = !choose[text];
          result.remove(text+1);
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: choose[text]?Colors.blue:Colors.grey,
        ),
        child: Text(text.toString())
      ),
    );
  }
}
