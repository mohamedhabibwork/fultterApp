import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/shared/components/conponents.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatelessWidget {
  final TextEditingController __email = TextEditingController(
    text: '',
  );

  final TextEditingController __password = TextEditingController(
    text: '',
  );

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
                      labelText: 'Email Address A',
                      validate: (String? value)=>(value!.isNotEmpty) ? null : 'email address',
                      prefix: Icons.email
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: __password,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.remove_red_eye),
                    ),
                    validator: (String? value)=>(value!.isNotEmpty) ? null : 'password',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    context: context,
                    text: 'Login text',
                    function: (){
                      if(FormLoginKey.currentState!.validate()){
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
                      TextButton(onPressed: (){}, child: const Text('Register'))
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
