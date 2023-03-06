import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseText extends StatelessWidget {
  const ChooseText({Key? key, required this.title, required this.data, this.onSelected, required this.horizontal}) : super(key: key);

  final String title;
  final List<String> data;
  final double horizontal;
  final AutocompleteOnSelected<String>? onSelected;
  @override
  Widget build(BuildContext context) {
    late TextEditingController controller;
    return Autocomplete(
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
            controller: textEditingController,
            focusNode: focusNode,
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) =>
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              color: Colors.white,
              constraints: BoxConstraints(maxWidth: Get.width - horizontal*2),
              height: (50 * options.length).toDouble(),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (_, index) =>
                        InkWell(
                          onTap: () =>
                              onSelected(options.elementAt(index)),
                          child: Container(
                            width: 110,
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
