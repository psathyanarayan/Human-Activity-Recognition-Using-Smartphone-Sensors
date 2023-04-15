import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sensor_data_logging/MyHomePage.dart';
import 'package:sensor_data_logging/admin.dart';
import 'main.dart';

void main() => runApp(const Login());

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  
  static const String _title = 'Activity';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: Scaffold(
        // appBar: AppBar(title: const Text(_title)),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return const LoginPage();
              }
              return const Text('Hi');
            }));
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child : Padding(
          padding: const EdgeInsets.all(95),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo2.png',
              height: 200,
              width: 200,
            ),
            
            TextFormField(
  controller: nameController,
  keyboardType: TextInputType.text,
  decoration: InputDecoration(
    filled: true,
    fillColor: Colors.grey.shade200,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(15.0),
    ),
    labelText: 'User Name',
    labelStyle: TextStyle(
      color: Colors.grey[600],
  
      fontWeight: FontWeight.bold,
      
    ),
    hintText: 'Enter your username',
    hintStyle: TextStyle(
      color: Colors.grey.shade500,
      fontSize: 18.0,
    ),
    
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey[400]!,
      ),
      borderRadius: BorderRadius.circular(20.0),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  validator: (value) {
    if (value!.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  },
),

            const SizedBox(
              height: 30,
            ),

            TextField(
  obscureText: true,
  controller: passwordController,
  decoration: InputDecoration(
    labelText: 'Password',
    filled: true,
    fillColor: Colors.grey.shade200,
    labelStyle: TextStyle(
      color: Colors.grey[600],
      fontWeight: FontWeight.bold,
    ),
    
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey[400]!,
      ),
      borderRadius: BorderRadius.circular(15.0),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue,
        width: 2,
      ),
    ),
    suffixIcon: Icon(
      Icons.visibility,
      color: Colors.grey[600],
    ),
  ),
),

            // TextField(
            //   obscureText: true,
            //   controller: passwordController,
            //   decoration: const InputDecoration(
            //     border: OutlineInputBorder(),
            //     labelText: 'Password',
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      User? user = await signInUsingEmailPassword(
                          email: nameController.text,
                          password: passwordController.text,
                          context: context);
                      if (user != null) {
                        if (user.email == "admin@gmail.com") {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => admin()));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage()));
                        }
                      }
                    })
                    ],
                  )
            
          ],
        ),
        ),
      ),

        );
  }
}
