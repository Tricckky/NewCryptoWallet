//
//  AddWalletView.swift
//  CryptoWallet
//
//  Created by user245431 on 5/12/24.
//

import SwiftUI

struct AddWalletView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var balance: Double = 0.0
    @State private var depositAmount: String = ""
    @State private var selectedCryptocurrency: String = ""
    
    let cryptocurrencies = ["Bitcoin", "Ethereum", "Ripple", "Litecoin", "Cardano"]
    let cryptocurrencyAbbreviations = ["BTC", "ETH", "XRP", "LTC", "ADA"]
    let cryptocurrencyRates = [50000.0, 3000.0, 1.5, 200.0, 1.2]
    
    var body: some View {
        VStack {
            Text("Balance")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Text("$\(balance, specifier: "%.2f")")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            HStack {
                Text("$")
                    .font(.headline)
                
                TextField("Amount of deposit", text: $depositAmount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
            }
            .padding()
            
            Picker("Cryptocurrency", selection: $selectedCryptocurrency) {
                ForEach(cryptocurrencies, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            HStack {
                Text("Rate")
                    .font(.headline)
                
                Spacer()
                
                Text("1")
                    .font(.headline)
                
                Text(cryptocurrencyAbbreviations[cryptocurrencies.firstIndex(of: selectedCryptocurrency) ?? 0])
                    .font(.headline)
                
                Text("=")
                    .font(.headline)
                
                Text("$\(cryptocurrencyRates[cryptocurrencies.firstIndex(of: selectedCryptocurrency) ?? 0], specifier: "%.2f") AUD")
                    .font(.headline)
            }
            .padding()
            
            Spacer()
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                
                Spacer()
                
                Button(action: {
                    if let amount = Double(depositAmount) {
                        balance += amount
                    }
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Confirm")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding(.bottom, 150)
            .padding()
        }
        .navigationBarTitle("Add Wallet")
    }
}

#Preview {
    AddWalletView()
}
