import 'dart:math';

import 'package:cash_rich/Services/coinData.dart';
import 'package:cash_rich/Views/Auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  CoinData coins = Get.put(CoinData());

  int index = 0;

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.off(SignUp());
  }
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    coins.getCoinData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: const Text(""),
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {
              logout();
            },
            icon: Icon(Icons.login),
          ),
        ],
        title: const Text(
          "CoinRich",
          style: TextStyle(
              color: Colors.purple, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.blueAccent,
            icon: Icon(CupertinoIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blueAccent,
            icon: Icon(
              Icons.analytics,
            ),
            label: "Analysis",
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.blueAccent,
              icon: Icon(Icons.add_circle),
              label: "Add"),
          BottomNavigationBarItem(
              backgroundColor: Colors.blueAccent,
              icon: Icon(Icons.wallet),
              label: "Wallet"),
          BottomNavigationBarItem(
              backgroundColor: Colors.blueAccent,
              icon: Icon(
                Icons.settings,
              ),
              label: "Settings"),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(
                  () => ListView(
                    children: List.generate(
                      coins.naming.length,
                      (index) => Card(
                        elevation: 4.0,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            coins.naming[index],
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Symbol: ${coins.symboling[index]}'),
                              Text('Price: \$${coins.pricing[index]}'),
                              Text(
                                  'Percentage Change: ${coins.percentagesChanging[index]}%'),
                              Text('Rank: ${coins.ranking[index]}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
