//
//  ContentView.swift
//  PasswordValidation_may2025
//
//  Created by mac on 18/05/25.
//

import SwiftUI

enum validationRow: String {
    case minChar = "Minimum 8 characters"
    case letter = "Al least one letter"
    case number = "Number"
    case specialChar = "(!@#$%^&)"
}

struct ContentView: View {
    @State var password = ""
    var body: some View {
        VStack(alignment: .leading) {
            SecureInputView(text: $password)
                .textFieldStyle(.roundedBorder)
            
            validationRow(text: password, row: .minChar)
            validationRow(text: password, row: .letter)
            validationRow(text: password, row: .specialChar)
            validationRow(text: password, row: .number)
            
        }
        .padding()
    }
    
    func validationRow(text: String, row: validationRow) -> some View {
        HStack {
            Image(systemName: isValid(str: text, row: row) ? "checkmark.circle.fill" : "circle")
            Text(row.rawValue)
        }
    }
    
    func isValid(str: String, row: validationRow) -> Bool {
        switch row {
        case .minChar:
            return str.count >= 8
        case .letter:
            return str.contains { $0.isLetter }
        case .number:
            return str.contains { $0.isNumber }
        case .specialChar:
            return str.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*()")) != nil ? true : false
            
        }
    }
}

#Preview {
    ContentView()
}


struct SecureInputView: View {
    @Binding var text: String
    @State private var isSecure: Bool = true

    var body: some View {
        HStack {
            Group {
                if isSecure {
                    SecureField("Password", text: $text)
                } else {
                    TextField("Password", text: $text)
                }
            }
            .autocapitalization(.none)
            .disableAutocorrection(true)

            Button(action: {
                isSecure.toggle()
            }) {
                Image(systemName: isSecure ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.5))
        )
    }
}
