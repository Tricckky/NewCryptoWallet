//
//  MarketView.swift
//  CryptoWallet
//
//  Created by user245431 on 5/12/24.
//

import SwiftUI

public struct MarketView: View {
    @ObservedObject var walletViewModel: WalletViewModel
    
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
                    if (walletViewModel.isLoading) {
                        Text("Loading")
                    }
                    ForEach(walletViewModel.marketCryptoNames, id: \.self) { cryptoName in
                        HStack {
                            Text(cryptoName)
                                .font(.headline)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                if let index = walletViewModel.marketCryptoNames.firstIndex(of: cryptoName) {
                                Text("1 \(cryptoName) = $\(walletViewModel.marketCryptoRates[index]) AUD")
                                    .font(.subheadline)
                                
                                Text(walletViewModel.marketCryptoProfitLoss[index])
                                    .font(.subheadline)
                                    .foregroundColor(walletViewModel.marketCryptoProfitLoss[index].hasPrefix("+") ? .green : .red)
                            }
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
   MarketView(walletViewModel: WalletViewModel())
    
}
