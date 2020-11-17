import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_stack/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'GET IN'),
      routes: {"/profile": (_) => Profile()},
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  get wid => MediaQuery.of(context).size.width;
  get hei => MediaQuery.of(context).size.height;
  GlobalKey key1 = GlobalKey();
  GlobalKey key2 = GlobalKey();
  BoxShape s1 = BoxShape.rectangle;
  double w1, w2, h1, h2, r1, r2;
  bool signin = true;
  String selected = "sign in";
  AnimationController controller;
  Animation anim;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    anim = CurvedAnimation(curve: Curves.easeIn, parent: controller);
  }

  _getSize(bool signin) {
    setState(() {
      r1 = 10;
      r2 = 10;
      if (signin == true) {
        w1 = MediaQuery.of(context).size.width * 0.85;
        w2 = MediaQuery.of(context).size.width * 0.75;
        h1 = MediaQuery.of(context).size.height * 0.5;
        h2 = MediaQuery.of(context).size.height * 0.45;
      } else {
        w1 = MediaQuery.of(context).size.width * 0.75;
        w2 = MediaQuery.of(context).size.width * 0.85;
        h1 = MediaQuery.of(context).size.height * 0.45;
        h2 = MediaQuery.of(context).size.height * 0.5;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (w1 == null) _getSize(signin);
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("resources/sign_in_background.jpg")),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Builder(
          builder: (_) {
            var children2 = [
              Positioned(
                //// signin
                top: hei * 0.2,
                child: GestureDetector(
                  onTap: () async {
                    if (r1 < 100)
                      setState(() {
                        w1 = MediaQuery.of(context).size.width * 0.85;
                        w2 = MediaQuery.of(context).size.width * 0.75;
                        h1 = MediaQuery.of(context).size.height * 0.5;
                        signin = true;
                        h2 = MediaQuery.of(context).size.height * 0.45;
                      });
                  },
                  child: AnimatedContainer(
                      key: key1,
                      curve: Curves.easeIn,
                      transformAlignment: Alignment.center,
                      alignment: Alignment.center,
                      width: w1,
                      height: h1,
                      padding: EdgeInsets.symmetric(
                          horizontal: signin ? 30 : 70,
                          vertical: signin ? 40 : 40),
                      duration: Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.blue[300],
                                Colors.blue[50],
                              ]),
                          borderRadius: BorderRadius.circular(r1),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                spreadRadius: 5,
                                blurRadius: 20),
                          ]),
                      child: r1 < 50
                          ? SignInForm(
                              signin: signin,
                              onSign: (email, password) {
                                _signIn();
                              },
                            )
                          : Container()),
                ),
              ),
              r1 > 100
                  ? Container()
                  : Positioned(
                      // bottom: 0,
                      top: hei * 0.3,
                      // height: h2,
                      child: GestureDetector(
                        onTap: () {
                          // var t = wid * 0.5;
                          setState(() {
                            signin = false;
                            w1 = wid * 0.75;
                            w2 = MediaQuery.of(context).size.width * 0.85;
                            h1 = MediaQuery.of(context).size.height * 0.45;
                            h2 = MediaQuery.of(context).size.height * 0.5;
                          });
                        },
                        child: AnimatedContainer(
                          key: key2,
                          padding: EdgeInsets.symmetric(
                              horizontal: signin ? 70 : 30,
                              vertical: signin ? 10 : 20),
                          curve: Curves.easeOut,
                          width: w2,
                          height: h2,
                          alignment: Alignment.bottomCenter,
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.blue[50],
                                    Colors.blue[300],
                                  ]),
                              borderRadius: BorderRadius.circular(r2),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    spreadRadius: 2,
                                    blurRadius: 5)
                              ]),
                          child: signin
                              ? Text(
                                  "CREATE NEW ",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900),
                                )
                              : SignUpForm(
                                  onCreate: (email, password, name) {
                                    _signUp();
                                  },
                                ),
                        ),
                      ),
                    )
            ];
            return Stack(
                alignment: Alignment.center,
                children: signin
                    //  w1 > w2 && h1 > h2
                    ? children2.reversed.toList()
                    : children2);
          },
        ),
      ),
    );
  }

  _signIn() async {
    int i = 0;
    while (i < 5) {
      await Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          r1 = 1000;
          r2 = 1000;
          w1 = 150;
          h1 = 150;
          w2 = 0;
          h2 = 0;
        });
      });
      await Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          w1 = 300;
          h1 = 300;
          // w2 = 200;
          // h2 = 200;
        });
      });
      i++;
    }
    Navigator.pushNamed(context, "/profile");

    await Future.delayed(Duration(milliseconds: 1000), () {
      _getSize(signin);
    });
  }

  _signUp() {
    _signIn();
  }
}

class SignUpForm extends StatelessWidget {
  final Function(String email, String password, String name) onCreate;
  const SignUpForm({Key key, this.onCreate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController password = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController passwordConfirm = TextEditingController();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment:
        //     signin ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Text(
            "CREATE NEW ACCOUNT",
            style: TextStyle(
                color: Colors.blue[900],
                fontSize: 20,
                fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: name,
            decoration: InputDecoration(
                labelText: "Name",
                // icon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.blue,
                ))),
            validator: (input) => input.isEmpty ? "Name is Invailed" : null,
            onSaved: (input) => {},
          ),
          TextFormField(
            controller: email,
            decoration: InputDecoration(
                labelText: "Email",
                // icon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.blue,
                ))),
            validator: (input) => input.isEmpty ? "Email is Invailed" : null,
            onSaved: (input) => {},
          ),
          TextFormField(
            obscureText: true,
            controller: password,
            decoration: InputDecoration(
                labelText: "Password",
                // icon: Icon(Icons.),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.blue,
                ))),
            validator: (input) => input.isEmpty ? "PASSWORD IS NOT TRUE" : null,
            onSaved: (input) => {},
          ),
          TextFormField(
            obscureText: true,
            controller: passwordConfirm,
            decoration: InputDecoration(
                labelText: "Password",
                // icon: Icon(Icons.),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.blue,
                ))),
            validator: (input) => input.isEmpty ? "PASSWORD IS NOT TRUE" : null,
            onSaved: (input) => {},
          ),
          RaisedButton(
              color: Colors.blue,
              child: Text("Create",
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onPressed: () => onCreate(
                    email.toString(),
                    password.value.toString(),
                    name.toString(),
                  ))
        ],
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  final bool signin;
  final Function(String email, String password) onSign;
  const SignInForm({Key key, @required this.signin, this.onSign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController password = TextEditingController();
    TextEditingController email = TextEditingController();
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment:
        //     signin ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Text(
            "SIGN IN",
            style: TextStyle(
                color: Colors.blue[900],
                fontSize: 20,
                fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: email,
            decoration: InputDecoration(
                labelText: "EMAIL",
                // icon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.blue,
                ))),
            validator: (input) => input.isEmpty ? "Email is Invailed" : null,
            onSaved: (input) => {},
          ),
          TextFormField(
            obscureText: true,
            controller: password,
            decoration: InputDecoration(
                labelText: "PASSWORD",
                // icon: Icon(Icons.),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.blue,
                ))),
            validator: (input) => input.isEmpty ? "PASSWORD IS NOT TRUE" : null,
            onSaved: (input) => {},
          ),
          RaisedButton(
              color: Colors.blue,
              child: Text("Sign in",
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onPressed: () =>
                  onSign(email.toString(), password.value.toString()))
        ],
      ),
    );
  }
}
