//
//  ContentView.swift
//  Units
//
//  Created by Loi Pham on 5/1/21.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    let categories = ["Volume", "Length"]
    let units = [
        ["mL", "L", "cup", "pint", "gal"],
        ["m", "km", "ft", "yd", "mi"]
    ]
    
    @State private var unitType = 0
    @State private var inputAmount = ""
    @State private var unitFrom = 0
    @State private var unitTo = 1
    
    
    
    func getUnitLengthEnum(type: String) -> UnitLength {
        switch type {
            case "m":
                return .meters
            case "km":
                return .kilometers
            case "ft":
                return .feet
            case "yd":
                return .yards
            default:
                return .miles
        }
    }
    
    func getUnitVolumeEnum(type: String) -> UnitVolume {
        switch type {
        case "mL":
            return .milliliters
        case "L":
            return .liters
        case "cup":
            return .cups
        case "pint":
            return .pints
        case "gal":
            fallthrough
        default:
            return .gallons
        }
    }
        
    var result: Double {
        let amount = Double(inputAmount) ?? 0
        
        switch unitType {
        case 0:
            let from: UnitVolume = getUnitVolumeEnum(type: units[unitType][unitFrom])
            let to: UnitVolume = getUnitVolumeEnum(type: units[unitType][unitTo])
            return Measurement(value: amount, unit: from).converted(to: to).value
        case 1:
            fallthrough
        default:
            let from: UnitLength = getUnitLengthEnum(type: units[unitType][unitFrom])
            let to: UnitLength = getUnitLengthEnum(type: units[unitType][unitTo])
            return Measurement(value: amount, unit: from).converted(to: to).value
        }
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            Form {
                // UNIT CATEGORY PICKER
                Section(header: Text("Category")) {
                    Picker("Unit category", selection: $unitType) {
                        ForEach(0..<categories.count) {
                            Text("\(categories[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // AMOUNT TEXT-FIELD
                Section {
                    TextField("Amount", text: $inputAmount)
                        .keyboardType(.decimalPad)
                    
                    
                }
                
                // CONVERTED FROM PICKER
                Section(header: Text("Converted from")) {
                    Picker("Convert from", selection: $unitFrom) {
                        ForEach(0..<units[unitType].count) {
                            Text("\(units[unitType][$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // CONVERTED TO PICKER
                Section(header: Text("To")) {
                    Picker("Convert from", selection: $unitTo) {
                        ForEach(0..<units[unitType].count) {
                            Text("\(units[unitType][$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // RESULT
                Section {
                    Text("\(result, specifier: "%.4f")")
                }
            } // FORM
            .navigationBarTitle("Unit Conversions")
        } // NAVIGATION-VIEW
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
