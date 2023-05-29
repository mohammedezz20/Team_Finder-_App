import 'package:advanced_project/res/assets_res.dart';
import 'package:advanced_project/shared/cubit/Appcubit/appcubit.dart';
import 'package:advanced_project/shared/cubit/Appcubit/appstate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../SizeCalc.dart';
import '../moadels/UserModel.dart';
import '../widget/text_Field.dart';
import 'EditProfileScreen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key, required this.user,this.current=true}) : super(key: key);
  UserModel? user;
  var  current;
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Profile.png"),
                      fit: BoxFit.fitHeight)),
              child: Padding(
                padding: EdgeInsets.only(
                    right: getHeight(context, 30),
                    left: getHeight(context, 30),
                    top: statusBarHeight,
                bottom: getHeight(context, 20)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back)),
                          Spacer(),
                          if(current)...[IconButton(onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  cubit.editProfileName.text=user!.name;
                                  cubit.editProfileBio.text=user!.bio;
                                  cubit.editProfileAbout.text=user!.about;
                                  cubit.links=user!.links;
                                  return EditProfileScreen(user: user,);
                                }));
                          }, icon: Icon(Icons.mode_edit_rounded)),]
                        ],
                      ),
                      Column(
                        children: [
                          //*********************Image*************************
                          SizedBox(
                            height: getHeight(context, 80),
                          ),
                          Container(
                            height: getHeight(context, 160),
                            width: getWidth(context, 160),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 5, color: Colors.grey),
                            ),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: '${user?.photoURL}',
                                height: getHeight(context, 160),
                                width: getWidth(context, 160),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                          //*********************Name*************************

                          Text(
                            "${user?.name}",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          //*********************bio*************************
                          Text("${user?.bio}",
                              style: TextStyle(fontSize: 22),
                              textAlign: TextAlign.center),
                          //*********************Separator*************************
                          SizedBox(
                            height: getHeight(context, 10),
                          ),
                          Container(
                            width: double.infinity,
                            height: 2,
                            color: Color(0xffBAE6FF),
                          ),
                          //*********************About*************************
                          SizedBox(
                            height: getHeight(context, 5),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "About",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade200),
                            padding: EdgeInsets.all(getWidth(context, 10)),
                            child: Text(
                              "${user?.about}",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(context, 10),
                          ),
                          //*********************Sochial media*************************
                          Container(
                            width: double.infinity,
                            height: 2,
                            color: Color(0xffBAE6FF),
                          ),
                          SizedBox(
                            height: getHeight(context, 10),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Links",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Wrap(
                            children: List.generate(
                              user?.links.length,
                              (index) {
                                var links = user?.links[index];
                                if (links['title'] != 'cvURL') {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: getHeight(context, 3),
                                        bottom: getWidth(context, 3)),
                                    child: InkWell(
                                      splashColor: Colors.grey,
                                      onTap: () {
                                        cubit.launchURL(
                                            Uri.parse(links['link']));
                                      },
                                      child: Ink(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/${links['title'].toString().toLowerCase()}.png',
                                              height: getHeight(context, 35),
                                              width: getHeight(context, 35),
                                            ),
                                            SizedBox(
                                              width: getWidth(context, 5),
                                            ),
                                            Text(
                                                "${cubit.extractUsernameFromLink(links['link'])}")
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: getHeight(context, 3),
                                        bottom: getWidth(context, 3)),
                                    child: InkWell(
                                      splashColor: Colors.grey,
                                      onTap: () {
                                        cubit.launchURL(
                                            Uri.parse(links['link']));
                                      },
                                      child: Ink(
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: getWidth(context, 18),
                                              backgroundColor: Colors.black,
                                              child: Text(
                                                "CV",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              width: getWidth(context, 5),
                                            ),
                                            Text(
                                                "${user?.name}'s CV")
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return SizedBox();
                              },
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
