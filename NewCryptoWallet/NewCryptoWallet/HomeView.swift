//
//  ContentView.swift
//  CryptoWallet
//
//  Created by user245431 on 5/11/24.
//
  
import SwiftUI

struct HomeView: View {
<<<<<<< Updated upstream

    init() {
        let walletTools = WalletTools();
        walletTools.setCryptoData {
            let topThreeGains: [(String, Double)] = walletTools.getTopThree();
        }
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
=======
    @StateObject var walletViewModel = WalletViewModel()
    
    var body: some View {
        
        VStack {
            VStack {
                Text("$\(walletViewModel.user.getBalance(), specifier: "%.2f")")
                    .font(.largeTitle)
                    .fontWeight(.bold)
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
                    
                    ForEach(walletViewModel.topThree, id: \.name) { currency in
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
                    ForEach(walletViewModel.viewWalletList, id: \.name) { wallet in
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
>>>>>>> Stashed changes
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
