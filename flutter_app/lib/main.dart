import 'package:flutter/material.dart';
import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';
import 'package:provider/provider.dart';
import './classes/classes.dart';

void main() {
  runApp(const MyApp());
}

class MyAppState extends ChangeNotifier {
  var persons = <Person>[
    Person(
      name: "João",
      email: "teste@gmail.com",
      password: "123",
    ),
  ];

  void addPerson(Person person) {
    persons.add(person);
    notifyListeners();
  }

  bool checkPerson(String email, String password) {
    for (var person in persons) {
      if (person.email == email && person.password == password) {
        return true;
      }
    }
    return false;
  }

  void removePerson(String email) {
    persons.removeWhere((element) => element.email == email);
    notifyListeners();
  }

  void updatePerson(String email, String name, String password) {
    for (var person in persons) {
      if (person.email == email) {
        person.name = name;
        person.password = password;
      }
    }
    notifyListeners();
  }

  bool searchPerson(String email) {
    for (var person in persons) {
      if (person.email == email) {
        return true;
      }
    }
    return false;
  }

  void printPersons(){
    for (var person in persons) {
      print(person.email);
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: FlutterBootstrap5(
        builder: (ctx) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(184,184,255, 1)),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final loginForm = GlobalKey<FormState>();
  final registerForm = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController nameReg = TextEditingController();
  TextEditingController emailReg = TextEditingController();
  TextEditingController passwordReg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var persons = appState.persons;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Test"),
        ),
        body: FB5Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Form(
                key: loginForm,
                child: FB5Row(
                  classNames: 'align-items-center justify-content-center',
                  children: [
                    FB5Col(
                      classNames: 'col-md-8 offset-md-2 mt-2',
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FB5Col(
                      classNames: 'col-md-8 offset-md-2 mt-2',
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          hintText: "Enter your email",
                        ),
                      ),
                    ),
                    FB5Col(
                      classNames: 'col-md-8 offset-md-2 mt-2',
                      child: TextFormField(
                        obscureText: true,
                        controller: password,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          hintText: "Enter your password",
                        ),
                      ),
                    ),
                    FB5Col(
                      classNames: 'col-md-8 offset-md-2 mt-2',
                      child: ElevatedButton(
                        onPressed: () {
                          if(appState.checkPerson(email.text, password.text)){
                            Person person = Person(
                              email: email.text,
                              password: password.text,
                            );
              
                            print("Login feito com sucesso");
                          } else {
                            print("Email ou senha incorretos");
                          }
                          print(email.text);
                          print(password.text);
                          appState.printPersons();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              Form(
                key: registerForm,
                child: FB5Row(
                  classNames: 'align-items-center justify-content-center',
                  children: [
                    FB5Col(
                      classNames: 'col-md-8 offset-md-2 mt-2',
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FB5Col(
                      classNames: 'col-md-8 offset-md-2 mt-2',
                      child: TextFormField(
                        controller: nameReg,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          hintText: "Enter your name",
                        ),
                      ),
                    ),
                    FB5Col(
                      classNames: 'col-md-8 offset-md-2 mt-2',
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailReg,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          hintText: "Enter your email",
                        ),
                      ),
                    ),
                    FB5Col(
                      classNames: 'col-md-8 offset-md-2 mt-2',
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordReg,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          hintText: "Enter your password",
                        ),
                      ),
                    ),
                    FB5Col(
                      classNames: 'col-md-8 offset-md-2 mt-2',
                      child: ElevatedButton(
                        onPressed: () {
                          if(!appState.searchPerson(emailReg.text)){
                            Person person = Person(
                              name: nameReg.text,
                              email: emailReg.text,
                              password: passwordReg.text,
                            );
              
                            print("Register feito com sucesso");
                            appState.addPerson(person);
                          } else {
                            print("Pessoa já existe");
                          }
                          print(nameReg.text);
                          print(emailReg.text);
                          print(passwordReg.text);
                          appState.printPersons();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ));
  }
}
