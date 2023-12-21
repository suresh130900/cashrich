// import 'dart:convert';
//
// import 'package:cash_rich/Model/coins.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// class CoinData extends GetxController {
//   Future<void> getCoinData() async {
//     const apiEndpoint =
//         "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest";
//     final apiResponse = await http.get(Uri.parse(apiEndpoint),
//         headers: {"X-CMC_PRO_API_KEY": "27ab17d1-215f-49e5-9ca4-afd48810c149"});
//
//     if (apiResponse.statusCode == 200) {
//       print(apiResponse.body);
//       List<Coing> allCoins = (jsonDecode(apiResponse.body)["data"] as List)
//           .map((data) => Coing.fromJson(data))
//           .toList();
//       print(allCoins);
//     }
//   }
// }

import 'dart:convert';

import 'package:cash_rich/Model/coins.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CoinData extends GetxController {
  List<Coing> allCoins = [];
  List<Data> allCoin = [];
  RxList<Coing> finalCoins = <Coing>[].obs;
  RxList<Data> crytpo = <Data>[].obs;
  RxList naming = [].obs;
  RxList symboling = [].obs;
  RxString maxSupply = "".obs;
  RxList maxSupplying = [].obs;
  RxString rank = "".obs;
  RxList ranking = [].obs;
  RxString prices = "".obs;
  RxList pricing = [].obs;
  RxString percentageChange = "".obs;
  RxList percentagesChanging = [].obs;


  Future<void> getCoinData() async {

    const apiEndpoint =
        "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest";
    final apiResponse = await http.get(Uri.parse(apiEndpoint),
        headers: {"X-CMC_PRO_API_KEY": "27ab17d1-215f-49e5-9ca4-afd48810c149"});

    if (apiResponse.statusCode == 200) {
      //print(apiResponse.body);
      // allCoin = (jsonDecode(apiResponse.body)["data"] as List)
      //     .map((data) => Data.fromJson(data))
      //     .toList();
      Coing coing = Coing.fromJson(jsonDecode(apiResponse.body));
      //print(coing);

      finalCoins.value = [coing];
      // print(coing.data);

      //print(coing.data);
      crytpo.value = coing.data!;
      print("----------------------------------------------------------------------------");
      print(crytpo);
      print("----------------------------------------------------------------------------");
      naming.value = crytpo.map((data) => data.name!).toList();
      print("Priting all the names in a List");
      print(naming);
      symboling.value = crytpo.map((data) => data.symbol!).toList();
      //print("symbol String: ${symbol.value}");
      maxSupply.value = crytpo.map((data) => data.maxSupply).join(', ');
      maxSupplying.value = crytpo.map((data) => data.maxSupply).toList();
      //print("Max supply String: ${maxSupply.value}");
      rank.value = crytpo.map((data) => data.cmcRank).join(', ');
      ranking.value = crytpo.map((data) => data.cmcRank!).toList();
      //print("Rank String: ${rank.value}");

      prices.value = crytpo
          .map((data) => data.quote?.uSD?.price.toString() ?? 'N/A')
          .join(', ');
      //print("Prices String: ${prices.value}");

      pricing.value = crytpo.map((data) => data.quote!.uSD!.price!).toList();
      print("Priting all the prices in a List");
      print(pricing);

      percentageChange.value = crytpo
          .map((data) => data.quote?.uSD?.percentChange24h.toString() ?? 'N/A')
          .join(', ');

      //Percentage Changes:-
      percentagesChanging.value = crytpo.map((data) => data.quote!.uSD!.percentChange24h!).toList();
      print("Priting all the prices in a List");
      print(percentagesChanging);
      //print("Percentage String: ${percentageChange.value}");

      // print("priting the length:-----------------------------------------------------------------------------");
      // print(crytpo.value.length);
      // print(crytpo.value);
      // print("------------------------------------------------------------");
      // print(crytpo.value);
      // print("------------------------------------------------------------");
      //
      // for( var coin in crytpo)
      //   {
      //     //print("priting names:---------------------------");
      //     //print(coin.name);
      //     names.value = coin.name;
      //   }
      // print("priting names:---------------------------");
      // print(names.value);
      //print(finalCoins.value);

      // for (var coin in allCoins) {
      //   print("------------------------------------------------------------");
      //   print(coin);
      // }
    }
  }
}
