//
//  AddFundsView.swift
//  CryptoWallet
//
//  Created by user245431 on 5/12/24.
//

import SwiftUI

public struct AddFundsView: View {
    @ObservedObject var walletViewModel: WalletViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var depositAmount: String = ""
    @State private var nameOnCard: String = ""
    @State private var cardNumber: String = ""
    @State private var expiryDate: String = ""
    @State private var cvv: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    public var body: some View {
        VStack {
            Text("Current Balance:")
                .padding()
            
            Text("$\(walletViewModel.getBalance(), specifier: "%.2f")")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 30)
            
            TextField("Amount of deposit", text: $depositAmount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.decimalPad)
                .overlay(
                    HStack {
                        Text("$")
                            .padding(.leading, 10)
                        Spacer()
                    }
                )
                .onChange(of: depositAmount) { newValue in
                    if !newValue.isNumeric {
                        depositAmount = String(depositAmount.filter { "0123456789".contains($0) })
                        alertMessage = "Please enter only numbers for the deposit amount."
                        showAlert = true
                    }
                }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Payment Details")
                    .font(.headline)
                
                TextField("Name on Card", text: $nameOnCard)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: nameOnCard) { newValue in
                        if newValue.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil {
                            nameOnCard = String(nameOnCard.filter { !"0123456789".contains($0) })
                            alertMessage = "Please enter only letters for the name on card."
                            showAlert = true
                        }
                    }
                
                TextField("Card No.", text: $cardNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .onChange(of: cardNumber) { newValue in
                        if !newValue.isNumeric {
                            cardNumber = String(cardNumber.filter { "0123456789".contains($0) })
                            alertMessage = "Please enter only numbers for the card number."
                            showAlert = true
                        }
                    }
                
                HStack {
                    TextField("Exp. Date (MM/YY)", text: $expiryDate)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .onChange(of: expiryDate) { newValue in
                            if newValue.count > 5 {
                                expiryDate = String(expiryDate.prefix(5))
                            }
                        }
                    
                    TextField("CVV", text: $cvv)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .onChange(of: cvv) { newValue in
                            if newValue.count > 3 {
                                cvv = String(cvv.prefix(3))
                            }
                            if !newValue.isNumeric {
                                cvv = String(cvv.filter { "0123456789".contains($0) })
                                alertMessage = "Please enter only numbers for the CVV."
                                showAlert = true
                            }
                        }
                }
            }
            .padding()
            
            VStack(alignment: .center, spacing: 10) {
                Text("Balance After Deposit:")
                    .font(.headline)
                
                Text("$\(walletViewModel.getBalance() + (Double(depositAmount) ?? 0), specifier: "%.2f")")
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(true)
            }
            .padding()
            
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
                .padding()
                
                Spacer()
                
                Button(action: {
                    if depositAmount.isEmpty || nameOnCard.isEmpty || cardNumber.isEmpty || expiryDate.isEmpty || cvv.isEmpty {
                        alertMessage = "Please fill in all the required fields."
                        showAlert = true
                    } else {
                        walletViewModel.addBalance(amount: Double(depositAmount) ?? 0)
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Confirm")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
            }
            .padding()
        }
        .navigationBarTitle("Add Funds")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Invalid Input"),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
}

extension String {
    var isNumeric: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}

#Preview {
    AddFundsView(walletViewModel: WalletViewModel())
}
