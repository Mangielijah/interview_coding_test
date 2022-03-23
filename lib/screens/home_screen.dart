import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_new_startup/services/auth_service.dart';
import 'package:interview_new_startup/services/database_service.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int counter = 0;
  late DatabaseService databaseService;
  late AuthService authService;
  @override
  void initState() {
    // TODO: implement initState
    authService = ref.read(authServiceProvider);
    databaseService = ref.read(databaseServiceProvider);

    databaseService.getUserCount(authService.currentUser.uid).then((value) {
      setState(() {
        counter = value ?? 0;
      });
    });
    super.initState();
  }

  void _increment() async {
    int newCount = counter + 1;
    databaseService.saveUserCount(authService.currentUser.uid, newCount);
    setState(() {
      counter = newCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('You\'re in the Home Screen'),
          SizedBox(
            height: 20,
          ),
          Text('$counter'),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              child: Text('Logout'),
              onPressed: () async {
                await authService.signOut();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
