//
//  ContentView.swift
//  CryptoWallet
//
//  Created by user245431 on 5/11/24.
//

import SwiftUI

struct HomeView: View {
    @State private var totalBalance: Double = 0.0
    @State private var initialDeposit: Double = 0.0
    @State private var wallets: [(name: String, balance: Double, change: Double)] = [
        ("Wallet 1", 0.0, 0.0),
        ("Wallet 2", 0.0, 0.0),
        ("Wallet 3", 0.0, 0.0)
    ]
    @State private var topCurrencies: [(name: String, change: Double)] = [
        ("Currency 1", 0.05),
        ("Currency 2", 0.04),
        ("Currency 3", 0.03)
    ]
    
    var body: some View {
        VStack {
            VStack {
                Text("$\(totalBalance, specifier: "%.2f")")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("\(balanceChange >= 0 ? "+" : "")\(balanceChange, specifier: "%.2f")%")
                    .foregroundColor(balanceChange >= 0 ? .green : .red)
            }
            .padding()
            
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Top Gainers (24h)")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {
                            // View market action
                        }) {
                            Text("View Market")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.vertical)
                    
                    ForEach(topCurrencies, id: \.name) { currency in
                        HStack {
                            Text(currency.name)
                            Spacer()
                            Text("+\(currency.change, specifier: "%.2f")%")
                                .foregroundColor(.green)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .padding()
                
                VStack(spacing: 16) {
                    ForEach(wallets, id: \.name) { wallet in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(wallet.name)
                                    .font(.headline)
                                Text("\(wallet.change >= 0 ? "+" : "")\(wallet.change, specifier: "%.2f")%")
                                    .foregroundColor(wallet.change >= 0 ? .green : .red)
                            }
                            Spacer()
                            Text("$\(wallet.balance, specifier: "%.2f")")
                                .font(.headline)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                    
                    HStack {
                        Button(action: {
                            // Add wallet action
                        }) {
                            Text("Add Wallet")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Add funds action
                        }) {
                            Text("Add Funds")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            initialDeposit = 0.0
            totalBalance = initialDeposit
        }
    }
    
    var balanceChange: Double {
        let currentBalance = wallets.reduce(0) { $0 + $1.balance }
        if initialDeposit == 0 {
            return 0.0
        } else {
            return ((currentBalance - initialDeposit) / initialDeposit) * 100
        }
    }
}

#Preview {
    HomeView()
}
