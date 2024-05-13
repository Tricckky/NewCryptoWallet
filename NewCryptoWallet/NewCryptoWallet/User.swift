//
//  User.swift
//  CryptoWallet
//
//  Created by user245431 on 5/12/24.
//

import Foundation

public class User {
    private var balance: Double;
    private var walletList: Array<Wallet>;
    private var walletCount: Int;
    
    init() {
        self.balance = 0;
        self.walletList = [];
        self.walletCount = 0;
    }
    
    func addBalance(amount: Double) -> Void {
        self.balance += amount;
    }
    
    func addWallet(newWallet: Wallet) -> Void {
        self.walletList.append(newWallet);
        self.walletCount += 1;
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
}
