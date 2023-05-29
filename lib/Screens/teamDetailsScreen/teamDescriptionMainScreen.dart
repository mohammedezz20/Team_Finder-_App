import 'package:advanced_project/moadels/membersmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../moadels/TeamModel.dart';
import '../../moadels/UserModel.dart';
import '../../shared/cubit/teamCubit/teamState.dart';
import '../../shared/cubit/teamCubit/teamcubit.dart';
import '../../SizeCalc.dart';
import '../meetingScreen.dart';


class TeamDescriptionMainScreen extends StatefulWidget {
  final TeamModel teamModel;

  const TeamDescriptionMainScreen({Key? key, required this.teamModel})
      : super(key: key);

  @override
  State<TeamDescriptionMainScreen> createState() =>
      _TeamDescriptionMainScreenState(teamModel);
}

class _TeamDescriptionMainScreenState extends State<TeamDescriptionMainScreen>
    with SingleTickerProviderStateMixin {
  final TeamModel teamModel;
  late TabController _tabController;
  late TeamCubit _cubit;
_TeamDescriptionMainScreenState(this.teamModel);
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      if (_tabController.index == 2) {
        _cubit.showVideoCallButton();
      } else {
        _cubit.hideVideoCallButton();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _cubit = BlocProvider.of<TeamCubit>(context);
    return BlocConsumer<TeamCubit, TeamStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: (){
                  Navigator.pop(context);
            },),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0.0),
              child: Container(
                width: getWidth(context, 370),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: const Color(0xffBAE6FF),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            centerTitle: true,
            title: Text(
              teamModel.teamName,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [

              Visibility(
                visible: _cubit.ischatScreen,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () {
                      return jumpToMeetingpage(context,
                           conferanceId: '${teamModel.teamID}');
                    },
                    splashColor: Colors.grey,
                    child: Ink(
                      child: Container(
                        height: getHeight(context, 40),
                        width: getWidth(context, 40),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: const Icon(
                          Icons.video_call,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
          body: Column(
            children: [
              Center(
                child: Container(
                  width: getWidth(context, 370),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    indicator: const UnderlineTabIndicator(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(
                        text: 'Dashboard',
                      ),
                      Tab(
                        text: 'Requests',
                      ),
                      Tab(
                        text: 'Chat',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: getWidth(context, 20),
                  vertical: getHeight(context, 10)),
                  child: TabBarView(
                    controller: _tabController,
                    children: _cubit.Screens,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
jumpToMeetingpage(BuildContext context, {required String conferanceId}) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => VideoConferance("512")));
}