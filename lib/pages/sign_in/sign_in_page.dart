import 'package:classes/base/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class SignInPage extends BasePage{

  var data = ["aaaaa","cajnfoa","hhokgo"];

  @override
  Widget buildWidget(BuildContext context) {
    return LiquidSwipe(
      pages: [],
    );
  }

  Widget chooseIdentity(){
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text("你是"),
          Text("教师"),
          Text("or"),
          Text("学生")
        ],
      ),
    );
  }

  Widget chooseSchool(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("你来自哪所学校？"),
        Autocomplete(
          optionsBuilder: (TextEditingValue value) async{
            if(value.text.isEmpty){
              return const Iterable<String>.empty();
            }else{
              return data.where((element) => element.contains(value.text));
            }
          },
          fieldViewBuilder: (context,textEditingController, focusNode, onFieldSubmitted){
            return SizedBox(
              height: 34,
              child: TextFormField(
                controller: textEditingController,
                onFieldSubmitted: (value) => onFieldSubmitted,
              ),
            );
          },
          // optionsViewBuilder: (context, onSelected, options) => null,
          onSelected: (selection) => print(selection),
        ),
      ],
    );
  }

  Widget completeAccount(){
    return Container();
  }
}