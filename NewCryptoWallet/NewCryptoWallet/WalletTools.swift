//
//  WalletTools.swift
//  CryptoWallet
//
//  Created by user245431 on 5/12/24.
//

import Foundation

public class WalletTools {
    private var apiKey: String;
    private var cryptoData: [Coin];
    
    init() {
        //In a production application this would be hidden
        self.apiKey = "76b72de9-d480-4a12-867f-df406e0ee05e"
        self.cryptoData = [];
        setCryptoData();
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
        let data: [Coin]
    }
    
    func setCryptoData() {
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
                    print(coinData)
                    self.cryptoData = coinData.data
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
