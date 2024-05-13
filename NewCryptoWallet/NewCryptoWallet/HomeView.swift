//
//  ContentView.swift
//  CryptoWallet
//
//  Created by user245431 on 5/11/24.
//
  
import SwiftUI

struct HomeView: View {
    
    @StateObject var walletViewModel: WalletViewModel
    @State private var showingAddFundsView = false;
    @State private var showingMarketView = false;
    
    var body: some View {
        
        VStack {
            VStack {
                Text("$\(walletViewModel.getBalance(), specifier: "%.2f")")
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
                        
                        Button(action: { showingMarketView = true;
                        }) {
                            Text("View Market")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .cornerRadius(8)
                        } .sheet(isPresented: $showingMarketView) {
                            MarketView(walletViewModel: walletViewModel)
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
                            Button(action: {self.showingAddFundsView = true}) {
                                Text("Add Funds")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }.sheet(isPresented: $showingAddFundsView) {
                                AddFundsView(walletViewModel: walletViewModel)
                            }
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
            }
            .padding()
        }
    }

    #Preview {
        HomeView(walletViewModel: WalletViewModel())
    }
