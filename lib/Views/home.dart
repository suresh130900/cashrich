
import 'package:cash_rich/Services/coinData.dart';
import 'package:cash_rich/Views/Auth/signup.dart';
import 'package:cash_rich/Views/homeInner.dart';
import 'package:cash_rich/Views/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/coins.dart';
import '../Services/coin_serach.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
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
              Icons.search,
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
      body: IndexedStack(
        index: index,
        children: [
          HomeInner(),
          Center(
            child: Search(),
          )
        ],
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       ElevatedButton(onPressed: (){
      //         Get.to(HomeInner());
      //       }, child: Text("testing")),
      //       TextField(
      //         onChanged: (query) {
      //           coinSearch.searchCoins(query);
      //         },
      //         decoration: InputDecoration(
      //           labelText: 'Search Coins',
      //           hintText: 'Enter coin name or symbol',
      //         ),
      //       ),
      //       // Obx(() {
      //       //   if (coinSearch.searchResults.isNotEmpty) {
      //       //     print("-----------------------------------------------------------------");
      //       //     print(coinSearch.searchResults);
      //       //     return ListView.builder(
      //       //       itemCount: coinSearch.searchResults.length,
      //       //       itemBuilder: (context, index) {
      //       //         Data coin = coinSearch.searchResults[index];
      //       //         return ListTile(
      //       //           title: Text(coin.name ?? ''),
      //       //           subtitle: Text(coin.symbol ?? ''),
      //       //           // Add more information as needed
      //       //         );
      //       //       },
      //       //     );
      //       //   } else {
      //       //     print("Else Part only");
      //       //     return Text('No results found');
      //       //   }
      //       // }),
      //
      //       Container(
      //         height: MediaQuery.of(context).size.height,
      //         child: Obx(
      //           () => ListView.builder(
      //             itemCount: coinSearch.searchResults.length,
      //             shrinkWrap: true,
      //             itemBuilder: (BuildContext context, int index) {
      //               Data coin = coinSearch.searchResults[index];
      //               return Padding(
      //                 padding: const EdgeInsets.all(16.0),
      //                 child: Card(
      //                   child: ListTile(
      //                     title: Text(
      //                       coin.name ?? '',
      //                       style: TextStyle(
      //                           fontSize: 24, fontWeight: FontWeight.bold),
      //                     ),
      //                     subtitle: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Text('Symbol: ${coin.symbol ?? ''}'),
      //                         Text('Price: \$${coins.pricing[index]}'),
      //                         Text(
      //                             'Percentage Change: ${coins.percentagesChanging[index]}%'),
      //                         Text('Rank: ${coins.ranking[index]}'),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //         ),
      //       ),
      //
      //       // Container(
      //       //   height: MediaQuery.of(context).size.height,
      //       //   child: Padding(
      //       //     padding: const EdgeInsets.all(16.0),
      //       //     child: Obx(
      //       //       () => ListView(
      //       //         children: List.generate(
      //       //           coins.naming.length,
      //       //           (index) => Card(
      //       //             elevation: 4.0,
      //       //             margin: EdgeInsets.symmetric(vertical: 8.0),
      //       //             child: ListTile(
      //       //               title: Text(
      //       //                 coins.naming[index],
      //       //                 style: TextStyle(
      //       //                     fontSize: 24, fontWeight: FontWeight.bold),
      //       //               ),
      //       //               subtitle: Column(
      //       //                 crossAxisAlignment: CrossAxisAlignment.start,
      //       //                 children: [
      //       //                   Text('Symbol: ${coins.symboling[index]}'),
      //       //                   Text('Price: \$${coins.pricing[index]}'),
      //       //                   Text(
      //       //                       'Percentage Change: ${coins.percentagesChanging[index]}%'),
      //       //                   Text('Rank: ${coins.ranking[index]}'),
      //       //                 ],
      //       //               ),
      //       //             ),
      //       //           ),
      //       //         ),
      //       //       ),
      //       //     ),
      //       //   ),
      //       // ),
      //     ],
      //   ),
      // ),
    );
  }
}
