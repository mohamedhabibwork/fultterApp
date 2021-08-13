import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/shared/components/conponents.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController __email = TextEditingController(
    text: '',
  );

  final TextEditingController __password = TextEditingController(
    text: '',
  );

  bool visiblePassword = true;

  @override
  Widget build(BuildContext context) {
    var FormLoginKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: FormLoginKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  defaultFormField(
                      inputController: __email,
                      keyboardType: TextInputType.emailAddress,
                      labelText: 'Email Address :',
                      validate: (String? value) =>
                          (value!.isNotEmpty) ? null : 'email address',
                      prefix: Icons.email),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      inputController: __password,
                      keyboardType: TextInputType.visiblePassword,
                      labelText: "Password",
                      IsPassword: visiblePassword,
                      validate: (String? value) =>
                          (value!.isNotEmpty) ? null : 'Password Required',
                      prefix: Icons.lock,
                      IsPressSuffixIcon: true,
                      onPressSuffixIcon: () {
                        setState(() {
                          visiblePassword = !visiblePassword;
                        });
                      },
                      suffix: visiblePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    context: context,
                    text: 'Login',
                    function: () {
                      if (FormLoginKey.currentState!.validate()) {
                        print(__email.text);
                        print(__password.text);
                        FormLoginKey.currentState!.reset();
                      }
                    },
                  ),
                  defaultButton(
                    context: context,
                    text: 'Register',
                    function: () {
                      if (FormLoginKey.currentState!.validate()) {
                        print(__email.text);
                        print(__password.text);
                        FormLoginKey.currentState!.reset();
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('don\'t have Account ?'),
                      TextButton(
                          onPressed: () {}, child: const Text('Register'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
