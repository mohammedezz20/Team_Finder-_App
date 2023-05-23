import 'package:advanced_project/SizeCalc.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamState.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamcubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkillWidget extends StatelessWidget {
var text;
SkillWidget({required this.text});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeamCubit,TeamStates>(builder: (context,state){
      var w=MediaQuery.of(context).size.width;
      var cubit=TeamCubit.get(context);
      return Padding(
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
                    cubit.removeSkill(text);
                    if(cubit.skillsWidget.length==0)
                    {cubit.HideSkillsWidget();}
                  },
                  child: Container(

                    height: getHeight(context, 25),
                    width: getWidth(context, 25),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                    ),
                    child: Icon(Icons.highlight_remove,size: 20,),
                  ),
                ),
                SizedBox(width: getWidth(context, 10),),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(text,style: TextStyle(fontSize: 15),
                    maxLines: 2,
                  overflow: TextOverflow.ellipsis,),
                ),


              ],
            ),
          ),
        ),
      );
    }, listener: (context,state){});
  }
}
