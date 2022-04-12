import 'package:flutter/material.dart';
import 'package:flutter_shared_preferences/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  TextEditingController emailController =  TextEditingController();

  TextEditingController passwordController =  TextEditingController();
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async{
      sharedPreferences = await SharedPreferences.getInstance();
    });
  }

  


  saveIntoLocalStorage(String email, String password) {
    if (email.isNotEmpty) {
      sharedPreferences?.setString('email', email);
    }
    if (password.isNotEmpty) {
      sharedPreferences?.setString('password', password);
    }
    print(sharedPreferences?.getString("email"));
    print(sharedPreferences?.getString("password"));
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 200),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email Id :",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: emailController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: "Enter your email"

                          ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password :",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "enter your password here"
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
              ),
              RaisedButton(
                onPressed: () {

                  saveIntoLocalStorage(
                      emailController.text, passwordController.text
                  );
                },
                child: Text(
                  "Login",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (sharedPreferences?.getString("email") != null)
                Text(
                    "user logged in!!! ->  Email Id : ${sharedPreferences?.getString('email') ?? "not"} "
                        "Password : ${sharedPreferences?.getString('password') ?? "not"}"),
            ],
          ),
        ),
      ),
    );
  }
}
