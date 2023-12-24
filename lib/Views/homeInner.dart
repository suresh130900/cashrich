
import 'package:cash_rich/Services/coinData.dart';
import 'package:cash_rich/Services/coin_serach.dart';
import 'package:cash_rich/Views/Auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeInner extends StatefulWidget {
  const HomeInner({super.key});

  @override
  State<HomeInner> createState() => _HomeInnerState();
}

class _HomeInnerState extends State<HomeInner>
    with SingleTickerProviderStateMixin {
  CoinData coins = Get.put(CoinData());

  //Searching the data
  CoinSearch coinSearch = CoinSearch();

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
                            style: const TextStyle(
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
