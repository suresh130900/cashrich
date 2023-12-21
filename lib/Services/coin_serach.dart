// import 'package:cash_rich/Services/coinData.dart';
// import 'package:get/get.dart';
// import '../Model/coins.dart';
//
// CoinData coinData = CoinData();
//
// class CoinSearch extends GetxController {
//   RxList<Data> searchResults = <Data>[].obs;
//
//   void searchCoins(String query) {
//     query = query.toLowerCase();
//     searchResults.clear();
//
//     for (Coing coin in coinData.allCoins) {
//       if (coin.data!.any((data) => data.name!.toLowerCase().contains(query) || data.symbol!.toLowerCase().contains(query))) {
//         searchResults.addAll(coin.data!);
//       }
//     }
//   }
// }

// import 'package:get/get.dart';
// import '../Services/coinData.dart'; // Adjust the import path based on your project structure
// import '../Model/coins.dart';
//
// CoinData coinData = CoinData();
// class CoinSearch extends GetxController {
//   RxList<Data> searchResults = <Data>[].obs;
//
//   void searchCoins(String query) {
//     query = query.toLowerCase();
//     searchResults.clear();
//
//     for (Coing coin in coinData.allCoins) {
//       coin.data?.forEach((data) {
//         if (data.name!.toLowerCase().contains(query) || data.symbol!.toLowerCase().contains(query)) {
//           searchResults.add(data);
//         }
//       });
//     }
//   }
// }

import 'package:get/get.dart';
import '../Services/coinData.dart'; // Adjust the import path based on your project structure
import '../Model/coins.dart';

class CoinSearch extends GetxController {

  CoinData coinData = Get.put(CoinData());
  RxList<Data> searchResults = <Data>[].obs;

  void searchCoins(String query) {
    query = query.toLowerCase();
    searchResults.clear();

    for (int i = 0; i < coinData.naming.length; i++) {
      print("------------------------------------------");
      print(coinData.naming.length);
      String name = coinData.naming[i].toLowerCase();
      String symbol = coinData.symboling[i].toLowerCase();

      if (name.contains(query) || symbol.contains(query)) {
        // Create a Data object with the matching name and symbol
        Data matchingData = Data(name: name, symbol: symbol);
        searchResults.add(matchingData);
      }
    }
  }
}
