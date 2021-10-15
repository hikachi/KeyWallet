import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Key wallet")),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor])),
        child: Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Center(
            child: SizedBox(
              width: 500,
              child: Column(
                children:  <Widget>[
                  Image(image: AssetImage('assets/images/logo.png')),
                  SizedBox(height: 100,),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                          hintText: 'Enter valid mail id as abc@gmail.com'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Password', hintText: 'Enter your secure password'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
