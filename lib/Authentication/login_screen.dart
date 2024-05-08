import 'package:cultimate/Authentication/signup_screen.dart';
import 'package:cultimate/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  State<LoginScreen> createState() =>_LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen>{
  final username=TextEditingController();
  final password=TextEditingController();

  bool isVisible=false;
  final formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  //Lottie animation
                  Lottie.asset('assets/login_animation.json',fit: BoxFit.cover),
                  
                  
                  //UserName Field
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color:Color.fromARGB(255,147,217,196)
                    ),
                    child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "User Name is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.person),
                        hintText: "User Name",
                        iconColor: Color.fromARGB(255,232,227,218),
                      ),
                    ),
                  ),
              
                        //Password Field
                   Container(
                      margin: const EdgeInsets.all(8),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromARGB(255,147,217,196)),
                      child: TextFormField(
                        controller: password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password is required";
                          }
                          return null;
                        },
                        obscureText: !isVisible,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.lock),
                            border: InputBorder.none,
                            hintText: "Password",
                            iconColor: Color.fromARGB(255,232,227,218),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  //In here we will create a click to show and hide the password a toggle button
                                  setState(() {
                                    //toggle button
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off))),
                      ),
                    ),
              
                    const SizedBox(height: 10,),
                    //Login Button
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width*.9,
                      decoration: BoxDecoration(color: Color.fromARGB(255,50,39,26),
                      borderRadius: BorderRadius.circular(8)),
                      child: TextButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            //TO-DO Login processes
                            Navigator.push(context,MaterialPageRoute(builder: (context) => const HomePage(),));
                          }
              
                        },
                         child: const Text("Login",
                         style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white) ,),
                         
                         )),
              
                         //Signup button
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(onPressed: (){
                              //Navigate to Sign Up
                              Navigator.push(context,MaterialPageRoute(builder: (context) => const SignUp(),));
                              }, child: const Text("Sign up",style: TextStyle(color: Color.fromARGB(255, 15, 15, 208)),))
                          ],
                         ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
