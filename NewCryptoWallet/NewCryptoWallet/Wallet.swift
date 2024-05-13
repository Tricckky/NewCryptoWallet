//
//  Wallet.swift
//  CryptoWallet
//
//  Created by user245431 on 5/12/24.
//

import Foundation

public class Wallet {
    private var name: String;
    private var audAmount: Double;
    private var quantity: Double;
    private var coin: WalletTools.Coin;
    
    init(newCoin: WalletTools.Coin, audAmount: Double) {
        self.coin = newCoin;
        self.name = newCoin.name;
        self.audAmount = audAmount;
        self.quantity = audAmount/newCoin.quote.AUD.price;
    }
    
    func getAudValue() -> Double {
        return self.quantity*coin.quote.AUD.price;
    }
    
    func getQuantity() -> Double {
        return self.quantity;
    }
    
    func getDailyChange() -> Double {
        return self.coin.quote.AUD.percent_change_24h;
    }
    
    func getWeeklyChange() -> Double {
        return self.coin.quote.AUD.percent_change_7d;
    }
    
    func getCoinName() -> String {
        return self.name;
    }
    
    func getCoinTicker() -> String {
        return self.coin.symbol;
    }
}
