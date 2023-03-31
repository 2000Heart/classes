import 'package:classes/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseLogic extends GetxController{
  bool _first = true;
  TextEditingController _controller = TextEditingController();

  bool get first => _first;

  set first(bool value) {
    _first = value;
    update();
  }
  set text(String value){
    if(_first) _controller.text = value;
    _first = !_first;
    update();
  }
}

class ChooseText extends StatelessWidget {
  ChooseText({Key? key, required this.title, required this.data, this.onSelected, required this.horizontal, this.onChanged, this.text}) : super(key: key);

  final String title;
  final List<String> data;
  final String? text;
  final double horizontal;
  final Function(String)? onChanged;
  final AutocompleteOnSelected<String>? onSelected;
  late final logic;

  @override
  Widget build(BuildContext context) {
    late TextEditingController controller;
    return GetBuilder<ChooseLogic>(
      tag: title,
      initState: (state) => logic = Get.put(ChooseLogic(),tag: title),
      builder: (logic) {
        return Autocomplete(
          optionsMaxHeight: 100,
          optionsBuilder: (TextEditingValue value) async {
            if (value.text.isEmpty) {
              return const Iterable<String>.empty();
            } else {
              return data.where((element) => element.contains(value.text));
            }
          },
          fieldViewBuilder: (context, textEditingController, focusNode,
              onFieldSubmitted) {
            controller = textEditingController;
            if(logic.first) controller.text = text ?? "";
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              logic.first = false;
            });
              return SizedBox(
                height: 50,
                child: TextField(
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    labelText: title,
                    labelStyle: const TextStyle(
                        color: Color(0xff353535),
                        fontWeight: FontWeight.normal,
                        fontSize: 18.0),
                  ),
                  style: const TextStyle(
                    height: 1.5,
                    color: Color(0xff353535),
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                  controller: controller,
                  focusNode: focusNode,
                  onChanged: onChanged,
                ),
              );
          },
          optionsViewBuilder: (context, onSelected, options) =>
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 5,
                          offset: const Offset(3, 3)
                      )]
                ),
                constraints: BoxConstraints(maxWidth: Get.width - horizontal*2,maxHeight: 200),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  removeBottom: true,
                  context: context,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                      itemCount: options.length,
                      itemBuilder: (_, index) =>
                          GestureDetector(
                            onTap: () =>
                                onSelected(options.elementAt(index)),
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text.rich(formSpan(
                                options.elementAt(index),
                                controller.text)),
                            ),
                          )),
                ),
              ),
            ),
          displayStringForOption: (option) => option,
          onSelected: onSelected,
        );
      }
    );
  }

  InlineSpan formSpan(String src, String pattern) {
    List<TextSpan> span = [];
    List<String> parts = src.split(pattern);
    if (parts.length > 1) {
      for (int i = 0; i < parts.length; i++) {
        span.add(TextSpan(text: parts[i]));
        if (i != parts.length - 1) {
          span.add(TextSpan(text: pattern, style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          )));
        }
      }
    } else {
      span.add(TextSpan(text: src));
    }
    return TextSpan(children: span);
  }

}
