import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RealtimeDatabase extends StatefulWidget {
  const RealtimeDatabase({super.key});

  @override
  State<RealtimeDatabase> createState() => _RealtimeDatabaseState();
}

class _RealtimeDatabaseState extends State<RealtimeDatabase> {
  late FirebaseDatabase database;
  late DatabaseReference ref;
  // final DatabaseReference ref =
  //     FirebaseDatabase.instance.ref("investmentTriggers");

  @override
  void initState() {
    super.initState();
    initializeDatabase();
  }

  int counterUserId = 0;

  void initializeDatabase() {
    final firebaseApp = Firebase.app();
    database = FirebaseDatabase.instanceFor(
        app: firebaseApp,
        databaseURL:
            'https://cashrich-26755-default-rtdb.asia-southeast1.firebasedatabase.app/');
  }

  @override
  Widget build(BuildContext context) {
    // CoinData coins = Get.put(CoinData());

    return SingleChildScrollView(
      child: Column(
        children: [
          const Text("Realtime Database"),
          ElevatedButton(
            onPressed: () {
              // coins.createFirebaseData();
              setState(() {
                counterUserId++;
              });
              print(counterUserId);
              createRecord();
            },
            child: const Text("Create Data"),
          ),
        ],
      ),
    );
  }

  void createRecord() async {
    ref = database.ref("investmentTriggers/cr_$counterUserId");
    print(counterUserId);
    DatabaseReference newRef = ref.push();
    await newRef.set({'name': 'Investment Hari', 'value': 10000000});
  }
}
