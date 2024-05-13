//
//  WalletViewModel.swift
//  CryptoWallet
//
//  Created by user245431 on 5/12/24.
//

import Foundation
class WalletViewModel: ObservableObject  {
    @Published var user = User();
    @Published var walletTools = WalletTools();
    @Published var topThree: [(name: String, change: Double)] = [];
    @Published var viewWalletList: [(name: String, balance: Double, change: Double)] = [
        ("Wallet 1", 0.0, 0.0),
        ("Wallet 2", 0.0, 0.0),
        ("Wallet 3", 0.0, 0.0)
    ]
    @Published var viewMarketData: [(symbol: String, price: Double, sevenDay: Double)] = [];
    
    init() {
        //Top Three function wasn't working unless it was called within setCryptoData. Might work without this after
        //structural changes to code but don't want to break it
        walletTools.setCryptoData {
            self.topThree = self.getTopThree()
        }
        loadMarketData()
    }
    
    func getTopThree() -> [(String, Double)] {
        var dailyGainMap: [(String, Double)] = [];
        var tempName: String = "";
        var tempGain: Double = 0;
        for coin in walletTools.getCryptoData() {
            tempName = coin.name;
            tempGain = coin.quote.AUD.percent_change_24h;
            dailyGainMap.append((tempName, tempGain));
        }
        let sortedGainMap = dailyGainMap.sorted { $0.1 > $1.1 }
        let topThree = Array(sortedGainMap.prefix(3));
        print(topThree);
        return topThree;
    }
    
    func handleAddNewWallet(name: String, amount: Double) {
        if !(self.user.hasRequiredFunds(amountRequired: amount)) {
            print("Error: Not enough funds")
            return
        }
        let coin = getCoinByName(name: name);
        let wallet = Wallet(newCoin: coin, audAmount: amount);
        user.addWallet(newWallet: wallet);
        user.removeBalance(amount: amount);
        updateWalletView(newWallet: wallet);
    }
    
    func getCoinByName(name: String) -> WalletTools.Coin {
        for coin in walletTools.getCryptoData() {
            if name.elementsEqual(coin.name) {
                return coin;
            }
        }
        print("Error: Couldn't find coin by name, returning first coin in data");
        return walletTools.getCryptoData()[0];
    }
    
    func updateWalletView(newWallet: Wallet) {
        let walletCount = self.user.getNumberOfWallets();
        let newViewWallet: (name: String, balance: Double, change: Double) = (name: newWallet.getCoinName(), balance: newWallet.getQuantity(), change: newWallet.getDailyChange())
        self.viewWalletList[walletCount-1] = newViewWallet;
    }
    
    func handleAddFunds(amount: Double) {
        self.user.addBalance(amount: amount);
    }
    
    func loadMarketData() {
        var tempSymbol: String
        var tempPrice: Double
        var tempSevenDay: Double
        var tempMarketData: [(symbol: String, price: Double, sevenDay: Double)] = []
        for coin in walletTools.getCryptoData() {
            tempSymbol = coin.symbol
            tempPrice = coin.quote.AUD.price
            tempSevenDay = coin.quote.AUD.percent_change_7d
            tempMarketData.append((symbol: tempSymbol, price: tempPrice, sevenDay: tempSevenDay))
        }
        self.viewMarketData = tempMarketData;
    }
}
