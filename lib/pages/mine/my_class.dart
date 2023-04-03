import 'package:cached_network_image/cached_network_image.dart';
import 'package:classes/base/base_page.dart';
import 'package:classes/logic/mine/my_class_logic.dart';
import 'package:classes/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/user_entity.dart';
import '../../res/colours.dart';
import '../../widgets/button.dart';

class MyClass extends BasePage{
  MyClass({super.key});

  final MyClassLogic logic = Get.put(MyClassLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<MyClassLogic>(
      initState: (state) => logic.requestData(),
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(title: Text("我的班级"),actions: [
            Container(
                padding: const EdgeInsets.only(right: 16),
                alignment: Alignment.center,
                child: Text("加入班级",style: TextStyle(color: Colors.black.withOpacity(0.7)))
            ).tap(() => Get.bottomSheet(addTask()))
          ],),
          body: SafeArea(
            child: SingleChildScrollView(
              child: ExpansionPanelList(
                elevation: 0,
                expansionCallback: (index, expanded) {
                  logic.currentIndex != index?logic.currentIndex = index:logic.currentIndex = null;
                },
                children: List.generate(logic.classList.length, (index) => item(index)),
              ),
            ),
          ),
        );
      }
    );
  }

  ExpansionPanel item(int index){
    return ExpansionPanel(
      canTapOnHeader: true,
      backgroundColor: Colors.white,
      isExpanded: logic.currentIndex == index,
      headerBuilder: (context, expanded) => Container(padding: EdgeInsets.only(left: 16),alignment: Alignment.centerLeft,child: Text(logic.classes[index])),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 3,horizontal: 5),
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Wrap(
          spacing: 16,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: List.generate(
            logic.classList[index].students?.length ?? 0, (childIndex) => stu(logic.classList[index].students?[childIndex])
          ),
        ),
      ),
      );
  }

  Widget stu(User? entity){
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 4,
                blurStyle: BlurStyle.solid,
                offset: Offset(2, 2)
            )
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.center,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: CachedNetworkImage(
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => Container(),
                  imageUrl: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202104%2F22%2F20210422220415_2e4bd.jpg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1680746191&t=ddb4b41f1676fbe35e1c2546bf472d0b'),
            ),
            Container(width: 8),
            Text(entity?.userName ?? "")
          ]),
    );
  }

  Widget addTask(){
    return BottomSheet(
      elevation: 40,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(16))
      ),
      constraints: BoxConstraints(minHeight: 490,maxHeight: 490),
      builder: (BuildContext context) =>Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          [Text("标题",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
            SizedBox(
              width: 100,
              child: TextField(
                cursorColor: Colors.black,
                expands: true,
                maxLines: null,
                minLines: null,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: '请输入任务标题',
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            )].formLine().paddingOnly(top: 10,left: 16,right: 16),
          [Text("内容",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
            NormalButton(text: "发布",width: 80,height: 30)].formLine().paddingOnly(left: 16,right: 16,bottom: 10),
          Container(
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35 / 2),
                boxShadow: [BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 4,
                )]
            ),
            child: TextField(
              maxLines: 15,
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none
              ),
            ),
          )
        ],
      ), onClosing: () {  },
    );
  }

  // Widget chooseList(context){
  //   return Column(
  //     children: [
  //       _searchBar(context),
  //       Column(
  //         children: List.generate(_findList.length, (index) => _searchItem(index)),
  //       )
  //     ],
  //   );
  // }
  //
  // Widget _searchBar(context) {
  //   return Container(
  //     color: Colors.white,
  //     padding: const EdgeInsets.only(left: 16,top: 8, bottom: 8,right: 16),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Container(
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(35 / 2),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Colors.grey.withOpacity(0.5),
  //                       blurRadius: 4,
  //                     )
  //                   ]
  //               ),
  //               child: TextField(
  //                 expands: true,
  //                 cursorColor: Colors.blue,
  //                 maxLines: null,
  //                 minLines: null,
  //                 onChanged: (str) => getInput(str),
  //                 onSubmitted: (str) => getInput(str),
  //                 decoration: InputDecoration(
  //                     filled: true,
  //                     constraints: BoxConstraints(maxHeight: 34),
  //                     contentPadding: EdgeInsets.all(5),
  //                     fillColor: Colors.white,
  //                     prefixIcon: Icon(Icons.search_rounded,color: Colors.black.withOpacity(0.8),size: 16),
  //                     border: const UnderlineInputBorder(
  //                       borderSide: BorderSide.none,
  //                       borderRadius:
  //                       BorderRadius.all(Radius.circular(35 / 2)),
  //                     ),
  //                     hintText: "搜索教室",
  //                     hintStyle: const TextStyle(fontSize: 16,height: 1.2)),
  //               )),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _searchItem(int index){
  //   return Container(
  //     height: 50,
  //     alignment: Alignment.center,
  //     margin: EdgeInsets.only(bottom: 8,left: 10,right: 10),
  //     decoration: BoxDecoration(
  //         color: Colors.white,
  //         boxShadow: [
  //           BoxShadow(
  //               color: Colors.grey.withOpacity(0.5),
  //               blurRadius: 2,
  //               blurStyle: BlurStyle.solid,
  //               offset: Offset(index==tapped?5:1, index==tapped?5:1)
  //           )
  //         ]),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         Container(width: 10),
  //         Icon(Icons.home_outlined,size: 30),
  //         Container(
  //           margin: EdgeInsets.symmetric(horizontal: 10),
  //           width: 2,
  //           height: 30,
  //           color: Colors.black,
  //         ),
  //         Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(_findList[index].roomName ?? ""),
  //             Text(_findList[index].schoolName ?? "")
  //           ],
  //         ),
  //       ],
  //     ),
  //   ).tap(() {
  //     tapped = index;
  //     _result = _findList[index].roomName;
  //     update();
  //   });
  // }
}