//
//  Wallet.swift
//  CryptoWallet
//
//  Created by user245431 on 5/12/24.
//

import Foundation

//TODO: GET RATE FROM API BASED ON NAME VALUE

public class Wallet {
    private var name: String;
    private var balance: Double;
    //private var rate: Double;
    
    init(name: String, balance: Double) {
        self.name = name
        self.balance = balance
        //self.rate = rate
    }
}
