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
        ("Wallet", 0.0, 0.0),
        ("Wallet", 0.0, 0.0),
        ("Wallet", 0.0, 0.0)
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
        
        
    }
    
}
