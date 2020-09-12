import 'package:flutter/material.dart';
import 'package:food_notifier/main_page.dart';
import 'package:food_notifier/provider/login_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static final routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _groupValue = 0;

  @override
  void initState() {
    super.initState();
    loadDataFromModel();
  }

  void loadDataFromModel() async {
    await Provider.of<LoginProvider>(context, listen: false).setup();

    LoginProvider loginProvider = Provider.of<LoginProvider>(context, listen: false);
    if(loginProvider.isLogin) {
      Navigator.pushNamed(context, MainPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 240),
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5
              )
            ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Cooking Assistance',
                style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 30),
              Container(
                height: 30,
                child: Row(
                  children: [
                    Text('이름'),
                    SizedBox(width: 15),
                    Expanded(
                      child: TextField(
                        
                      ),
                    )
                  ],
                )
              ),
              SizedBox(height: 15),
              Container(
                height: 30,
                child: Row(
                  children: [
                    Text('나이'),
                    SizedBox(width: 15),
                    Expanded(
                      child: TextField(
                        
                      ),
                    )
                  ],
                )
              ),
              SizedBox(height: 15),
              Container(
                height: 30,
                child: Row(
                  children: [
                    Text('성별'),
                    SizedBox(width: 15),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _groupValue,
                            onChanged: onRadioValueChanged
                          ),
                          Text('남자'),
                          Radio(
                            value: 2,
                            groupValue: _groupValue,
                            onChanged: onRadioValueChanged
                          ),
                          Text('여자')
                        ],
                      ),
                    )
                  ],
                )
              ),
              SizedBox(height: 15),
              Container(
                height: 30,
                child: Row(
                  children: [
                    Text('직업'),
                    SizedBox(width: 15),
                    Expanded(
                      child: TextField(
                        
                      ),
                    )
                  ],
                )
              ),
              SizedBox(height: 20),
              Material(
                type: MaterialType.transparency,
                child: FlatButton(
                  color: Colors.blueAccent,
                  child: Text('완료', style: TextStyle(color: Colors.white, fontSize: 16)),
                  onPressed: () {},
                )
              )
            ]
          )
        )
      )
    );
  }

  void onRadioValueChanged(int index) {
    setState(() {
      _groupValue = index;
    });
  }
}