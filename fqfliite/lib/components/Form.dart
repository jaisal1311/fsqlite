import 'package:flutter/material.dart';
import '../db/DatabaseProvider.dart';

class FormSQL extends StatefulWidget {
  @override
  _FormSQLState createState() => _FormSQLState();
}

class _FormSQLState extends State<FormSQL> {
  TextEditingController usernameController;
  TextEditingController passwordController;

  bool isUserenameValid;
  bool isPasswordValid;

  @override
  void initState() {
    super.initState();
    usernameController = new TextEditingController();
    passwordController = new TextEditingController();

    isUserenameValid = true;
    isPasswordValid = true;
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  insert({username, password}) async {
    print('entered insert');
    int id = await DatabaseProvider.instance.insert({
      DatabaseProvider.COLUMN_NAME: username,
      DatabaseProvider.COLUMN_PASSWORD: password
    });
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 60,
              child: TextField(
                onChanged: (value) {
                  if (value.length > 5) {
                    if (value.length < 8) {
                      setState(() {
                        isUserenameValid = false;
                      });
                    } else {
                      setState(() {
                        isUserenameValid = true;
                      });
                    }
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Username',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    errorText: isUserenameValid ? null : "Invalid username"),
                controller: usernameController,
              ),
            ),
            Container(
              height: 60,
              width: 200,
              child: TextField(
                obscureText: true,
                onChanged: (value) {
                  if (value.length > 4) {
                    if (value.length <= 8) {
                      if (mounted) {
                        setState(() {
                          isPasswordValid = false;
                        });
                      }
                    } else {
                      if (mounted) {
                        setState(() {
                          isPasswordValid = true;
                        });
                      }
                    }
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Password',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    errorText:
                        isPasswordValid ? null : 'Please set valid password!'),
                controller: passwordController,
              ),
            ),
            OutlinedButton(
                onPressed: () => {
                      insert(
                          username: usernameController.text,
                          password: passwordController.text)
                    },
                child: Text('Submit'))
          ],
        ),
      ),
    );
  }
}
