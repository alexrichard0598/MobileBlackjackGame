import 'package:blackjack/bl/databaseHelper.dart';

class Profile {
  int id,
      wins,
      losses,
      playerBlackjacks,
      dealerBlackjacks,
      totalGames,
      totalPlayerHand,
      totalDealerHand;
  String name;

  Profile(
      {this.id,
      this.name,
      this.wins = 0,
      this.losses = 0,
      this.playerBlackjacks = 0,
      this.dealerBlackjacks = 0,
      this.totalGames = 0,
      this.totalPlayerHand = 0,
      this.totalDealerHand = 0});

  Profile.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    name = map['Name'];
    wins = map['Wins'];
    losses = map['Losses'];
    playerBlackjacks = map["PlayerBlackjacks"];
    dealerBlackjacks = map['DealerBlackjacks'];
    totalGames = map['TotalGames'];
    totalPlayerHand = map['TotalPlayerHands'];
    totalDealerHand = map['TotalDealerHands'];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.colName: name,
      DatabaseHelper.colWins: wins,
      DatabaseHelper.colLosses: losses,
      DatabaseHelper.colPlayerBlackjacks: playerBlackjacks,
      DatabaseHelper.colDealerBlackjacks: dealerBlackjacks,
      DatabaseHelper.colTotalGames: totalGames,
      DatabaseHelper.colTotalPlayerHands: totalPlayerHand,
      DatabaseHelper.colTotalDealerHands: totalDealerHand
    };
  }
}
