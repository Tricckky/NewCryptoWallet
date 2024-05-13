//
//  WalletViewModel.swift
//  CryptoWallet
//
//  Created by user245431 on 5/12/24.
//

import Foundation
class WalletViewModel: ObservableObject  {
    @Published var balance: Double;
    @Published var walletList: Array<Wallet>;
    @Published var walletCount: Int;
    @Published var walletTools = WalletTools();
    @Published var isLoading = true;
    @Published var topThree: [(name: String, change: Double)] = [];
    @Published var viewWalletList: [(name: String, balance: Double, change: Double)] = [
        ("Wallet 1", 0.0, 0.0),
        ("Wallet 2", 0.0, 0.0),
        ("Wallet 3", 0.0, 0.0)
    ]
    @Published var viewMarketData: [(symbol: String, price: Double, sevenDay: Double)] = [];
    @Published var marketCryptoNames: [String] = []
    @Published var marketCryptoRates: [String] = []
    @Published var marketCryptoProfitLoss: [String] = []
    
    init() {
        //Top Three function wasn't working unless it was called within setCryptoData. Might work without this after
        self.balance = 0;
        self.walletList = [];
        self.walletCount = 0;
        walletTools.setCryptoData {
            self.topThree = self.getTopThree()
            self.loadMarketData()
            self.isLoading = false;
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
    
    func handleAddNewWallet(name: String, amount: Double) {
        if !(self.hasRequiredFunds(amountRequired: amount)) {
            print("Error: Not enough funds")
            return
        }
        let coin = getCoinByName(name: name);
        let wallet = Wallet(newCoin: coin, audAmount: amount);
        self.addWallet(newWallet: wallet);
        self.removeBalance(amount: amount);
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
        let walletCount = getNumberOfWallets();
        let newViewWallet: (name: String, balance: Double, change: Double) = (name: newWallet.getCoinName(), balance: newWallet.getQuantity(), change: newWallet.getDailyChange())
        self.viewWalletList[walletCount-1] = newViewWallet;
    }
    
    func loadMarketData() {
        let cryptoData = walletTools.getCryptoData()
            guard !cryptoData.isEmpty else {
                print("Error: Crypto data is empty")
                return
            }
        var tempSymbols: [String] = []
        var tempPrices: [String] = []
        var tempSevenDays: [String] = []
        let percentFormatter = NumberFormatter();
        percentFormatter.minimumFractionDigits = 1;
        percentFormatter.maximumFractionDigits = 1;
        let priceFormatter = NumberFormatter();
        priceFormatter.minimumFractionDigits = 2;
        priceFormatter.maximumFractionDigits = 2;
        print("before looping")
        for coin in walletTools.getCryptoData() {
            print("LOOPING THROUGH COINTS NOW")
            let formattedPercent = percentFormatter.string(from: NSNumber(value: coin.quote.AUD.percent_change_7d)) ?? "0"
            let formattedPrice = priceFormatter.string(from: NSNumber(value: coin.quote.AUD.price)) ?? "0"
            tempSymbols.append(coin.symbol)
            tempPrices.append(formattedPrice)
            if (coin.quote.AUD.percent_change_7d >= 0) {
                tempSevenDays.append("+" + formattedPercent + "%");
            } else {
                tempSevenDays.append(formattedPercent + "%");
            }
        }
        print("LOADING MARKET DATA")
        print(tempSymbols);
        print(tempPrices);
        print(tempSevenDays);
        self.marketCryptoNames = tempSymbols;
        self.marketCryptoRates = tempPrices;
        self.marketCryptoProfitLoss = tempSevenDays;
        print("AFTER REPLACING ARRAYS");
        print(self.marketCryptoNames);
        print(self.marketCryptoRates);
        print(self.marketCryptoProfitLoss);
    }
    
    func addBalance(amount: Double) -> Void {
            self.balance += amount;
    }
    
    func addWallet(newWallet: Wallet) -> Void {
        DispatchQueue.main.async {
            self.walletList.append(newWallet);
            self.walletCount += 1;
        }
    }
    
    func getBalance() -> Double {
        return self.balance;
    }
    
    func getWalletList() -> [Wallet] {
        return self.walletList;
    }
    
    func hasFunds() -> Bool {
        return self.balance > 0;
    }
    
    func hasRequiredFunds(amountRequired: Double) -> Bool {
        return self.balance >= amountRequired;
    }
    
    func getNumberOfWallets() -> Int {
        return self.walletCount;
    }
    
    func hasWallets() -> Bool {
        return self.getNumberOfWallets() > 0;
    }
    
    func removeBalance(amount: Double) {
        DispatchQueue.main.async {
            self.balance -= amount;
        }
    }
}
