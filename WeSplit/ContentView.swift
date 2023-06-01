//
//  ContentView.swift
//  WeSplit
//
//  Created by Davit Natenadze on 29.05.23.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    private var locale = Locale.current.currency?.identifier ?? "EUR"
    
    var total: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount * tipSelection / 100
        let total = checkAmount + tipValue
        
        return total
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: locale))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("Select tip percentage")
                }
                
                // Total amount
                Section {
                    Text(total, format: .currency(code: locale))
                        .background(tipPercentage == 0 ? .red : .clear)
                } header: {
                    Text("Total amount")
                }
                
                
                // Amount Per Person
                Section {
                    Text(total / Double(numberOfPeople + 2), format: .currency(code: locale))
                } header: {
                    Text("Amount per person")
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
    
}
