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
    
    init() {
        walletTools.setCryptoData {
            self.topThree = self.getTopThree()
        }
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
    
    func addNewWallet(name: String, amount: Double) {
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
    
}
