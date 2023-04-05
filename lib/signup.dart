


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'newpage.dart';



class SignupScreen extends StatefulWidget{
  const SignupScreen({Key ? key}) : super (key:key);

  @override
  _SignupScreenState createState()=> _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var emailcontroller = TextEditingController();
  var passcontroller = TextEditingController();
  @override
  void initState(){
    super.initState();
  }
  void checkLogin() async{
    // here we check if user already login or credentential already availabel or not
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("login");
    if(val!= null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:
      (context)=>NewPage()),
              (route) => false);
   //   Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Text("Login" , style: TextStyle(fontSize: 30),),
              TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                labelText: 'Email' , border: OutlineInputBorder(),

              ),),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passcontroller,

                  decoration: InputDecoration(
                  labelText: 'Password' , border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.password)

                ),),
                SizedBox(
                  height:10
                ),
                OutlinedButton.icon(onPressed: (){
                  login();
                },
                icon: Icon(Icons.login),
                  label: Text("Login"),
                ),
          ],
              
            ),
          ),
        ),
      ),
    );
  }
  void login() async{
    if(passcontroller.text.isNotEmpty && emailcontroller.text.isNotEmpty) {
      var response = await http.post(Uri.parse("https://reqres.in/api/login"),
          body: ({"email": emailcontroller.text,
            "password": passcontroller.text
          }));
      if(response.statusCode == 200) {
        final body = jsonDecode(response.body);
        // print("Login Token " + body["token"]);
        // Map<String, dynamic> user = jsonDecode(response);
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
           content: Text("Token : ${body['token']}")));
        pageRoute(body['token']);

      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("invalid")));
      }
    }

    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Blank value")));
    }

  }

  Future<void> pageRoute(String token) async {
    SharedPreferences pref= await SharedPreferences.getInstance();
    await pref.setString("login",token);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:
        (context)=>NewPage()),
            (route) => false);
  }

}
