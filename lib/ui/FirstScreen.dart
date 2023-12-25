import 'package:flutter/material.dart';
import 'package:suitmedia_intern_test/style/color.dart';
import 'package:suitmedia_intern_test/ui/PalindromeCheckDialog.dart';
import 'package:suitmedia_intern_test/ui/SecondScreen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String _name = "";
  String _palindrome = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "images/background_screen_1.png",
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 72,
                    backgroundColor: Colors.white30,
                    child: Icon(
                      size : 72,
                      Icons.person_add_alt_1,
                      color: MyColors.white,
                    ),
                  ),
                  const SizedBox(height: 51,),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) => (value == null || value.isEmpty)? 'Please enter your name' : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)
                            ),
                            isDense: true,
                            filled: true,
                            focusColor: Colors.transparent,
                            fillColor: MyColors.white,
                            hintText: "Name",
                            hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: const Color.fromARGB(104, 103, 119, 92)
                            )
                          ),
                          onChanged: (value) => setState(() {
                            _name = value;
                          }),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)
                            ),
                            isDense: true,
                            filled: true,
                            focusColor: Colors.transparent,
                            fillColor: MyColors.white,
                            hintText: "Palindrome",
                            hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: const Color.fromARGB(104, 103, 119, 92)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              _palindrome = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 45,),
                  Row(
                    children: [
                      Expanded(child: ElevatedButton(
                        onPressed: (){
                          showDialog(context: context, builder: (context) => PalindromeCheckDialog(palindromeText: _palindrome));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16)
                        ),
                        child: const Text(
                          "CHECK",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: MyColors.white
                          ),
                        ),
                      ))
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    children: [
                      Expanded(child: ElevatedButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen(username: _name)));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16)
                        ),
                        child: const Text(
                          "NEXT",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: MyColors.white
                          ),
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}