import SwiftUI

public class MassOfSubpart: NSObject, Codable {
    
    var subPart: Int
    var mass: Measurement<UnitMass>
    
    override init() {
        self.subPart = 1
        self.mass = Measurement(value: 0.0, unit: UnitMass.grams)
    }
    
    init(subpart: Int, mass: Measurement<UnitMass>){
        self.subPart = subpart
        self.mass = mass
    }
    
    init(massOfSubpart: MassOfSubpart) {
        self.subPart = massOfSubpart.subPart
        self.mass = massOfSubpart.mass
    }
}
