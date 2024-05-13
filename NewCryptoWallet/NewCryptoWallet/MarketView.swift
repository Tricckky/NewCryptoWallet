//
//  MarketView.swift
//  CryptoWallet
//
//  Created by user245431 on 5/12/24.
//

import SwiftUI

public struct MarketView: View {
    @State private var cryptoNames = ["ETH", "BTC", "XRP", "ADA", "DOT"]
    @State private var cryptoRates = ["4496.88", "51234.56", "0.78", "1.23", "15.67"]
    @State private var cryptoProfitLoss = ["+2.5%", "-1.8%", "+3.2%", "+0.9%", "-0.5%"]
    
    public var body: some View {
        VStack {
            Text("Cryptocurrencies")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Text("7 Days Range")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 30)
            
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(0..<cryptoNames.count, id: \.self) { index in
                        HStack {
                            TextField("", text: $cryptoNames[index])
                                .font(.headline)
                                .placeholder(when: cryptoNames[index].isEmpty) {
                                    Text(cryptoNames[index]).foregroundColor(.gray)
                                }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("1 \(cryptoNames[index]) = $\(cryptoRates[index]) AUD")
                                    .font(.subheadline)
                                
                                Text(cryptoProfitLoss[index])
                                    .font(.subheadline)
                                    .foregroundColor(cryptoProfitLoss[index].hasPrefix("+") ? .green : .red)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("Market")
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
    }

#Preview {
    MarketView()
}
