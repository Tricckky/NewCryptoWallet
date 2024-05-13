//
//  ContentView.swift
//  CryptoWallet
//
//  Created by user245431 on 5/11/24.
//

import SwiftUI

struct HomeView: View {

    init() {
        var wallet = WalletTools();
        wallet.setCryptoData {
            var topThreeGains: [(String, Double)] = wallet.getTopThree();
        }
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
