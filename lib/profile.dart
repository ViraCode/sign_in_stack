import 'package:fading_avatar/fading_avatar.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("resources/sign_in_background.jpg")),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Profile"),
          ),
          body: AvatarStack(
            controller: controller,
            image: AssetImage("resources/me.jpg"),
            top: 200,
            expandTimes: 2,
            child: ListView(
              controller: controller,
              children: [
                ...[
                  Colors.red,
                  Colors.blue,
                  Colors.blueGrey,
                  Colors.deepPurple,
                  Colors.green,
                  Colors.amber,
                  Colors.black,
                  Colors.purple,
                  Colors.yellow,
                  Colors.brown
                ].map((e) => Container(width: 450, height: 200, color: e))
              ],
            ),
          ),
        ));
  }
}
