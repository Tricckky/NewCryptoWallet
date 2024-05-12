//
//  ContentView.swift
//  CryptoWallet
//
//  Created by user245431 on 5/11/24.
//

import SwiftUI

struct HomeView: View {

    init() {
        let wallet = WalletTools();
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
