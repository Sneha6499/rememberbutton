


import 'package:apilogin/signup.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NewPage extends StatefulWidget {
  NewPage({Key? key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  String token ="";
  @override
  void initState(){
    super.initState();
    getCred();
  }
  Future<void> getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("token")!;
    }
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Text("Welcome user"),
                SizedBox(
                  height: 15,
                ),
                Text("Your token  : ${token}"),
                SizedBox(
                    height:10
                ),
                OutlinedButton.icon(onPressed: () async {
                  SharedPreferences pref= await SharedPreferences.getInstance();
                  await pref.clear();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:
                      (context)=>SignupScreen()),
                          (route) => false);

                },
                  icon: Icon(Icons.login),
                  label: Text("Logout"),
                ),


                ],

                ),
          ),

          ),
        ),

    );
  }
}

