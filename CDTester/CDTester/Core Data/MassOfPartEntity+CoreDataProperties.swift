import Foundation
import CoreData


extension MassOfPartEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MassOfPartEntity> {
        return NSFetchRequest<MassOfPartEntity>(entityName: "MassOfPartEntity")
    }

    @NSManaged public var subPart: Int16
    @NSManaged public var mass: Measurement<UnitMass>?
    @NSManaged public var isMassOfPart: Widget?

}
