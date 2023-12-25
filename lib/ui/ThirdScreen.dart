import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:suitmedia_intern_test/network/response.dart';
import 'package:suitmedia_intern_test/ui/components/CustomBackButton.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final String _baseUrl = 'https://reqres.in/api/users';
  final int _perPage = 10;
  int _page = 1;

  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreLoading = false;

  List<User> _users = [];

  void _firstLoad() async{
    setState(() {
      _isFirstLoadRunning = true;
    });

    try{
      final result = await http.get(Uri.parse("$_baseUrl?page=$_page&per_page=$_perPage"));
      if(result.statusCode == 200){
        UserResponse response = UserResponse.fromJson(jsonDecode(result.body) as Map<String, dynamic>);
        setState(() {
          _users = response.data;
        });
      }
    }catch(err){
      if(kDebugMode){
        Exception(err);
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMore() async{
    if(
      _hasNextPage && 
      !_isFirstLoadRunning && 
      !_isLoadMoreLoading && 
      _scrollController.position.extentBefore > 3){

      setState(() {
        _isLoadMoreLoading = true;
      });

      _page++;

      try{
        final result = await http.get(Uri.parse("$_baseUrl?page=$_page&per_page=$_perPage"));
        if(result.statusCode == 200){
          final List<User> fetchedUsers = UserResponse.fromJson(jsonDecode(result.body) as Map<String, dynamic>).data;
          if(fetchedUsers.isNotEmpty){
            setState(() {
              _users.addAll(fetchedUsers);
            });
          }else{
            setState(() {
              _hasNextPage = false;
            });
          }
        }
      }catch(err){
        if(kDebugMode){
          print('ThirdScreen E:${err.toString()}');
        }
      }

      setState(() {
        _isLoadMoreLoading = false;
      });
    }
  }

  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _firstLoad();
    _scrollController = ScrollController()..addListener(_loadMore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Third Screen",
          style: Theme.of(context).textTheme.titleMedium
        ),
        centerTitle: true,
        leading: CustomBackButton(context: context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: _isFirstLoadRunning ? const Center(
          child: CircularProgressIndicator(),
        ) : ListView(
          controller: _scrollController,
          children: [
            if(!_isFirstLoadRunning && _users.isEmpty)
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                child: Text(
                  "No users are currently registered",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),

            ListView.separated(
              itemCount: _users.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (_,index){
                return CardUser(
                  firstName: _users[index].firstName, 
                  lastName: _users[index].lastName, 
                  email: _users[index].email, 
                  avatar: _users[index].avatar
                );
              },
            ),

            if(_isLoadMoreLoading)
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 40),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),

            if(!_hasNextPage)
            Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              color: Colors.amber,
              child: const Center(
                child: Text("You have fetched all of the content"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardUser extends StatelessWidget {
  final String firstName, lastName, email, avatar;
  const CardUser({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pop(context, "$firstName $lastName");
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(avatar),
              radius: 32
            ),
      
            const SizedBox(width: 8,),
      
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "$firstName $lastName",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color.fromRGBO(104, 103, 119, 1)
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}