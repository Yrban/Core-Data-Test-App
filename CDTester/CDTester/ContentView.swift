import SwiftUI

struct MeasurementUnits {
    
    static let area: [UnitArea] = [.squareCentimeters, .squareInches]
    
    static let length: [UnitLength] = [.centimeters, .inches]
    
    static let mass: [UnitMass] = [.grams, .ounces]
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    // TextFields are currently not working properly with non text bindings
    @State private var title = ""
    @State private var manufacturer = ""
    @State private var massOfSubpartString = ""
    @State private var massOfSubpartMeasurementDict: [Int:String] = [:]
    @State private var numberOfSubparts = 1
    @State private var subpartIndex = 1
    @State private var massUnit = UnitMass.grams
    
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
    
    private var measurementFormatter: MeasurementFormatter {
        let formatter = MeasurementFormatter ()
        formatter.unitStyle = .short
        return formatter
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Manufacturer", text: $manufacturer)
                    TextField("Name of Widget", text: $title)
                }
                
                Section {
                    Stepper("Number of Subparts: \(numberOfSubparts)", value: $numberOfSubparts)
                    if numberOfSubparts > 1 {
                        Picker(selection: $subpartIndex, label: Text("Subpart:")) {
                            ForEach(1...numberOfSubparts, id: \.self) {pickerSubpart in
                                Text(pickerSubpart.description)
                            }
                        }
                        HStack {
                            TextField("Mass of Subpart", text: $massOfSubpartString, onEditingChanged: { (changed) in
                                if changed {
                                    // This is where to save to the dictionary
                                    guard let _ = Double(self.massOfSubpartString) else {
                                        self.massOfSubpartString = ""
                                        return
                                    }
                                    self.massOfSubpartMeasurementDict[self.subpartIndex] = self.massOfSubpartString
                                } else {
                                    guard let _ = Double(self.massOfSubpartString) else {
                                        self.massOfSubpartString = ""
                                        return
                                    }
                                    self.massOfSubpartMeasurementDict[self.subpartIndex] = self.massOfSubpartString
                                }
                            })
                                .keyboardType(.decimalPad)
                            Picker(selection: $massUnit, label: Text("")) {
                                ForEach(MeasurementUnits.mass, id: \.self) {mass in
                                    Text(self.measurementFormatter.string(from: mass))
                                }
                            }
                        }
                    } else {
                        HStack{
                            TextField("Mass of Widget", text: $massOfSubpartString, onEditingChanged: { (changed) in
                                if changed {
                                    // This is where to save to the dictionary
                                    guard let _ = Double(self.massOfSubpartString) else {
                                        self.massOfSubpartString = ""
                                        return
                                    }
                                    self.massOfSubpartMeasurementDict[1] = self.massOfSubpartString
                                } else {
                                    guard let _ = Double(self.massOfSubpartString) else {
                                        self.massOfSubpartString = ""
                                        return
                                    }
                                    self.massOfSubpartMeasurementDict[1] = self.massOfSubpartString
                                }
                            })
                                .keyboardType(.decimalPad)
                            Text(massOfSubpartString)
                            Picker(selection: $massUnit, label: Text("")) {
                                ForEach(MeasurementUnits.mass, id: \.self) {mass in
                                    Text(self.measurementFormatter.string(from: mass))
                                }
                            }
                        }
                    }
                }
                Section {
                    HStack{
                        Spacer()
                        Button(action: {
                            self.saveWidget()
                        }) {
                            Text("Save Widget")
                        }
                        Spacer()
                    }
                }
                .navigationBarTitle("New Widget")
            }
        }
    }
        
        func saveWidget(){
            print("saveWidget() entered")
            if self.massOfSubpartMeasurementDict.count > 0,
                self.massOfSubpartMeasurementDict.count == self.numberOfSubparts,
                self.manufacturer != "",
                self.title != "" {
                
                var massPerSubpartMeasurementArray: [MassOfSubpart]
                massPerSubpartMeasurementArray = massOfSubpartMeasurementDict.map {
                    return MassOfSubpart(subpart: $0.key, mass: Measurement(value: Double($0.value)!, unit: self.massUnit))
                }
                
                let widget = Widget(context: self.managedObjectContext)
                widget.id = UUID()
                widget.isMadeBy?.name = self.manufacturer
                widget.addToHasMassOfPart(Set(massPerSubpartMeasurementArray) as NSSet) // FIXME: Tha crash is here
                widget.title = self.title
                
                do {
                    print("SaveWidget() attempted/n")
                    try self.managedObjectContext.save()
                } catch {
                    print("SaveWidget() failed/n")
                    // handle the Core Data error
                    // Show alert as to status
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
