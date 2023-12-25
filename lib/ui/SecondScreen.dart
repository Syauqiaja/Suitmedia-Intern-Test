import 'package:flutter/material.dart';
import 'package:suitmedia_intern_test/style/color.dart';
import 'package:suitmedia_intern_test/ui/ThirdScreen.dart';
import 'package:suitmedia_intern_test/ui/components/CustomBackButton.dart';

class SecondScreen extends StatefulWidget {
  final String username;
  const SecondScreen({super.key, required this.username});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String _selectedUsername = "Selected User Name";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Second Screen",
          style: Theme.of(context).textTheme.titleMedium
        ),
        centerTitle: true,
        leading: CustomBackButton(context: context),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        softWrap: true,
                      ),
                      Text(
                        widget.username,
                        softWrap: true,
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  )
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _selectedUsername,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        _navigateAndDisplaySelection(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith((states) => MyColors.primary),
                      ),
                      child: Text(
                        "Choose a user",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: MyColors.white,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _navigateAndDisplaySelection(BuildContext context) async{
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdScreen()));

    if(!mounted) return;

    if(result != null)
    setState(() {
      _selectedUsername = result;
    });
  }
}