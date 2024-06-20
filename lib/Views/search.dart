import 'package:cash_rich/Services/coinData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/coins.dart';
import '../Services/coin_serach.dart';
import 'Auth/signup.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  CoinData coins = Get.put(CoinData());

  //Searching the data
  CoinSearch coinSearch = CoinSearch();

  int index = 0;

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.off(const SignUp());
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (query) {
                  coinSearch.searchCoins(query);
                },
                decoration: const InputDecoration(
                    labelText: 'Search Coins',
                    labelStyle: TextStyle(fontSize: 16),
                    prefixIcon: Icon(CupertinoIcons.search),
                    border: OutlineInputBorder()),
              ),
            ),
            // Obx(() {
            //   if (coinSearch.searchResults.isNotEmpty) {
            //     print("-----------------------------------------------------------------");
            //     print(coinSearch.searchResults);
            //     return ListView.builder(
            //       itemCount: coinSearch.searchResults.length,
            //       itemBuilder: (context, index) {
            //         Data coin = coinSearch.searchResults[index];
            //         return ListTile(
            //           title: Text(coin.name ?? ''),
            //           subtitle: Text(coin.symbol ?? ''),
            //           // Add more information as needed
            //         );
            //       },
            //     );
            //   } else {
            //     print("Else Part only");
            //     return Text('No results found');
            //   }
            // }),

            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Obx(
                () => ListView.builder(
                  itemCount: coinSearch.searchResults.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    Data coin = coinSearch.searchResults[index];
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        child: ListTile(
                          title: Text(
                            coin.name ?? '',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Symbol: ${coin.symbol ?? ''}'),
                              Text('Price: \$${coins.pricing[index]}'),
                              Text(
                                  'Percentage Change: ${coins.percentagesChanging[index]}%'),
                              Text('Rank: ${coins.ranking[index]}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Container(
            //   height: MediaQuery.of(context).size.height,
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Obx(
            //       () => ListView(
            //         children: List.generate(
            //           coins.naming.length,
            //           (index) => Card(
            //             elevation: 4.0,
            //             margin: EdgeInsets.symmetric(vertical: 8.0),
            //             child: ListTile(
            //               title: Text(
            //                 coins.naming[index],
            //                 style: TextStyle(
            //                     fontSize: 24, fontWeight: FontWeight.bold),
            //               ),
            //               subtitle: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text('Symbol: ${coins.symboling[index]}'),
            //                   Text('Price: \$${coins.pricing[index]}'),
            //                   Text(
            //                       'Percentage Change: ${coins.percentagesChanging[index]}%'),
            //                   Text('Rank: ${coins.ranking[index]}'),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
