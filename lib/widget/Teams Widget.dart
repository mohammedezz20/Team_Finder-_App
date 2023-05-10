import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';
import '../res/assets_res.dart';

class TeamsWidget extends StatelessWidget {
   TeamsWidget({Key? key}) : super(key: key);
String teamname="Team Name";
String teamdescription="teamdescriptionteamdescriptionteamdescriptionteamdescriptionteamdesc"
    "riptionteamdescriptionteamdescriptionteamdescription";
    double? progress = Random().nextDouble();


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width-20;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        children: [
          Container(
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),

            ),
            child:  ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                backgroundColor:Color(0xffb1d5f5) ,
                value: progress,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff47b2ff),),

              ),
            ),
          ),
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teamname,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.h,),
                  SizedBox(
                    width: width/2.1,
                    child: Text(
                      teamdescription,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    "Team Member",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.h,),
                  SizedBox(
                    height: 55,
                    width: width/2.1,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: width * .01,
                      ),
                      itemBuilder: (context, index) => Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 23,
                          backgroundImage: NetworkImage(
                              'https://th.bing.com/th/id/OIP.g9JQBsgn1JtJ4WirA1--IQHaHa?pid=ImgDet&rs=1'),
                        ),
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),

        ],
      ),
    );
  }
}
