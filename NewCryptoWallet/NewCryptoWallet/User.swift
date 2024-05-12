//
//  User.swift
//  CryptoWallet
//
//  Created by user245431 on 5/12/24.
//

import Foundation

public class User {
    private var totalBalance: Double;
    private var walletList: Array<Wallet>;
    
    init() {
        self.totalBalance = 0;
        self.walletList = [];
    }
}
