//
//  WalletTools.swift
//  CryptoWallet
//
//  Created by user245431 on 5/12/24.
//

import Foundation

class WalletTools {
    //Key would be hidden in a production Application
    private var apiKey = "76b72de9-d480-4a12-867f-df406e0ee05e"
    private var cryptoData: [Coin] = []
    
    init() {

    }
    
    struct Coin: Codable {
        let name: String
        let symbol: String
        let quote: Quote
    }
    
    struct Quote: Codable {
        let AUD: AUD
    }
   
    struct AUD: Codable {
        let price: Double
        let percent_change_24h: Double
        let percent_change_7d: Double
        let market_cap: Double
    }
    
    struct CoinData: Codable {
        var data: [Coin]
    }
    
    func setCryptoData(completion: @escaping () -> Void) {
        var apiUrl = URLComponents(string: "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest")!
        apiUrl.queryItems = [
            URLQueryItem(name: "limit", value: "5"),
            URLQueryItem(name: "convert", value: "AUD")
        ]
        var request = URLRequest(url: apiUrl.url!)
            request.httpMethod = "GET"
            request.addValue(apiKey, forHTTPHeaderField: "X-CMC_PRO_API_KEY")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let coinData = try decoder.decode(CoinData.self, from: data)
                    //print(coinData)
                    self.cryptoData = coinData.data
                    //print(self.cryptoData);
                    completion()
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }
            task.resume();
        }
    
    func getCryptoData() -> [Coin] {
        return self.cryptoData;
    }
    
    
}
