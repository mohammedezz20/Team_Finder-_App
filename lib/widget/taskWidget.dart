import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../SizeCalc.dart';
import '../moadels/taskmodel.dart';

class TaskWidget extends StatelessWidget {
   TaskWidget({Key? key,required this.task,required this.function}) : super(key: key);
  TaskModel task ;
  var function;
  @override
  Widget build(BuildContext context) {
    return
        GestureDetector(
          onTap: function,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(

              decoration: BoxDecoration(
                  color: Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: getWidth(context, 10),vertical: getHeight(context, 6)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: (){

                      },
                      child: Container(

                        height: getHeight(context, 25),
                        width: getWidth(context, 25),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white
                        ),
                        child: Icon(Icons.arrow_forward,size: 20,),
                      ),
                    ),
                    SizedBox(width: getWidth(context, 10),),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(task.taskTitle,style: TextStyle(fontSize: 15),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,),
                    ),


                  ],
                ),
              ),
            ),
          ),
        );

  }
}
