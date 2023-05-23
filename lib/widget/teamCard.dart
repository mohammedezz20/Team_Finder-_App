import 'package:flutter/material.dart';

import '../SizeCalc.dart';


class TeamCard extends StatelessWidget {
  const TeamCard({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffEEEEEE),
          border: Border.all(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            height: 55,
            child: Row(
              children: [
                const Spacer(),
                Container(
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
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Ali Ahmed",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Java developer",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 6,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: width * .75,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: const Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
                child: Text(
                  "Team Developer Team Developer Team Developer Team Developer Team Developer"
                  " Team Developer Team Developer Team Developer Team Developer Team Developer ",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.07),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  "Team Member",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.07),
            child: SizedBox(
              height: 55,
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
          ),
          Container(
            height: 2,
            width: width * .75,
            color: Colors.white,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                onPressed: (){},
                child: Container(
                  alignment: Alignment.center,
                  width:getWidth(context,100),
                  height: getHeight(context, 30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    "join Request",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
