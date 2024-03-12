//
//  rcCurrencyInput.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/14/24.
//

import SwiftUI

enum CurrencyCode: String, CaseIterable {
    case USD = "USD" // United States Dollar
    case EUR = "EUR" // Euro
    case JPY = "JPY" // Japanese Yen
    case GBP = "GBP" // British Pound Sterling
    case AUD = "AUD" // Australian Dollar
    case CAD = "CAD" // Canadian Dollar
    case CHF = "CHF" // Swiss Franc
    case CNY = "CNY" // Chinese Yuan
    case SEK = "SEK" // Swedish Krona
    case NZD = "NZD" // New Zealand Dollar
    case KRW = "KRW" // South Korean Won
    case SGD = "SGD" // Singapore Dollar
    case NOK = "NOK" // Norwegian Krone
    case MXN = "MXN" // Mexican Peso
    case INR = "INR" // Indian Rupee
    case RUB = "RUB" // Russian Ruble
    case ZAR = "ZAR" // South African Rand
    case TRY = "TRY" // Turkish Lira
    case BRL = "BRL" // Brazilian Real
    case HKD = "HKD" // Hong Kong Dollar
}

struct rcCurrencyInput: View {
    
    @State var amount: Decimal = 0.0
    @State var currencyType: CurrencyCode = CurrencyCode.USD
    @FocusState var isFocused
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                rcDropdownSelect(selectedOption: $currencyType)
                TextField("Amount",value: $amount, format: .currency(code: currencyType.rawValue))
                    .keyboardType(.decimalPad)
                    .textFieldStyle(rcTextFieldStyle())
                    .focused($isFocused)
                    .font(.system(size: 14))
                    .overlay(rcUnderlineOverlay(underlineColor: defaultUnderlineColor()))
            }
            HStack{
                Text(amount, format: .currency(code: currencyType.rawValue))
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(.textPrimary)
                rcButton(text: "Donate"){
                    print("donate")
                }
            }
            
        }
        
                
                    
           
    }
    
    func defaultUnderlineColor() -> Color {
        return isFocused ? Color.success : Color.textPrimary
    }
}
