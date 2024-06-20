import 'dart:convert';

import 'package:cash_rich/Model/coins.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
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
      Coing coing = Coing.fromJson(jsonDecode(apiResponse.body));

      finalCoins.value = [coing];

      crytpo.value = coing.data!;

      naming.value = crytpo.map((data) => data.name!).toList();

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

      percentageChange.value = crytpo
          .map((data) => data.quote?.uSD?.percentChange24h.toString() ?? 'N/A')
          .join(', ');

      //Percentage Changes:-
      percentagesChanging.value =
          crytpo.map((data) => data.quote!.uSD!.percentChange24h!).toList();
    }
  }

  Future<void> getFirebaseRealtimeData() async {
    final firebaseApp = Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(
        app: firebaseApp,
        databaseURL:
            'https://cashrich-26755-default-rtdb.asia-southeast1.firebasedatabase.app/');

    final ref = rtdb.ref();

    final snapshot = await ref.child('investmentTrigger').get();
    print("Printing the value of snapshot: $snapshot ");
    if (snapshot.exists) {
      print(snapshot.value);
    } else {
      print('No data available.');
    }
  }

  Future<void> createFirebaseData() async {
    final firebaseApp = Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(
        app: firebaseApp,
        databaseURL:
            'https://cashrich-26755-default-rtdb.asia-southeast1.firebasedatabase.app/');
    print(rtdb.databaseURL);
    final ref = rtdb.ref("investmentTriggers");
    await ref.set({
      "createdBy": 283,
      "createdDate": 1718702501067,
      "createdFrom": 7122,
      "customerId": 96313,
      "status": 11,
      "triggerData": {
        "comparator": 100,
        "investmentAmount": 50000000,
        "investmentType": 23213,
        "ofScheme": {
          "currentNav": 3853948.3248,
          "schemeCategory": 5323,
          "schemeHouse": 93213,
          "schemeLogoUrl": "https://cashrichapp.com/icon/fundhouse/93.png",
          "schemeMasterId": 10013483232,
          "schemeName": "Nippon India Growth Fund (G) by Suresh Chaudhary",
        },
        "value": 3935.49,
        "valuePercentage": 2,
        "valueType": 200
      },
      "triggerName": "Alert Only in Suresh DataBase",
      "version": 1
    }).then((_) {
      print("Data Added SuccessFully");
    }).catchError((_) {
      print("Data Did not Add Successfully ");
    });
  }
}
