import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_notifier/db_helper.dart';
import 'package:food_notifier/main_page.dart';
import 'package:food_notifier/provider/login_provider.dart';
import 'package:food_notifier/unit/user.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static final routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _ageController = new TextEditingController();
  TextEditingController _jobController = new TextEditingController();

  FocusNode _nameFocusNode = new FocusNode();
  FocusNode _ageFocusNode = new FocusNode();
  FocusNode _jobFocusNode = new FocusNode();

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
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Container(
            width: 340,
            height: 340,
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
                          focusNode: _nameFocusNode,
                          controller: _nameController,
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
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          focusNode: _ageFocusNode,
                          controller: _ageController,
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
                          focusNode: _jobFocusNode,
                          controller: _jobController,
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
                    onPressed: () async {
                      if(_nameController.text.isEmpty) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('이름을 입력해주세요!'), duration: Duration(seconds: 2)));
                        FocusScope.of(context).requestFocus(_nameFocusNode);
                        return;
                      } else if(_ageController.text.isEmpty) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('나이를 입력해주세요!'), duration: Duration(seconds: 2)));
                        FocusScope.of(context).requestFocus(_ageFocusNode);
                        return;
                      } else if(_jobController.text.isEmpty) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('직업을 입력해주세요!'), duration: Duration(seconds: 2)));
                        FocusScope.of(context).requestFocus(_jobFocusNode);
                        return;
                      } else if(_groupValue == 0) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('성별을 선택해주세요!'), duration: Duration(seconds: 2)));
                        return;
                      }
                      String name = _nameController.text;
                      int age = int.parse(_ageController.text);
                      String gender = _groupValue == 1 ? 'M' : 'F';
                      String job = _jobController.text;

                      String result = await DBHelper.postUser(name, age, gender, job);

                      if(result != null) {
                        User me = new User(result, name, gender, age, job);
                        Provider.of<LoginProvider>(context, listen: false).setLogin(result);
                        Provider.of<LoginProvider>(context, listen: false).me = me;
                        Navigator.pushNamed(context, MainPage.routeName);
                      } else {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('정보를 보내던 중, 오류가 발생하였습니다.'),
                          backgroundColor: Colors.redAccent,
                        ));
                      }
                    },
                  )
                )
              ]
            )
          ),
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