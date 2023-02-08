
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_controller.dart';

abstract class BasePage extends StatelessWidget{
  const BasePage({super.key});

  // BaseLogic init();
  // String? get tag => null;
  Widget buildWidget();
  // void initState(){return;}
  // void didUpdateWidget(){return;}
  // void didChangeDependencies(){return;}
  // void dispose(){return;}

  @override
  Widget build(BuildContext context) {

    // return GetBuilder(
    //   init: init(),
    //   tag: tag,
    //   didUpdateWidget: (getBuilder,getBuilderState) => didUpdateWidget,
    //   didChangeDependencies: (getBuilderState) => didChangeDependencies,
    //   dispose: (getBuilderState) => dispose,
    //   initState: (state){
    //     initState();
    //   },
    //
    //   builder: (logic){
        return buildWidget();
    //   }
    // );
  }

}