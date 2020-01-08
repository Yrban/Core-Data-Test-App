import Foundation
import CoreData


extension Widget {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Widget> {
        return NSFetchRequest<Widget>(entityName: "Widget")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var isMadeBy: Manufacturer?
    @NSManaged public var hasMassOfPart: Set<MassOfSubpart>?
    
    public var wrappedId : UUID {
        id ?? UUID()
    }
    
    public var wrappedMassOfPartArray : [MassOfSubpart] {
        Array(hasMassOfPart ?? [MassOfSubpart()])
    }
    
    public var wrappedTitle : String {
        title ?? "Unnamed Widget"
    }
    
    public var wrappedIsMadeBy : String {
        isMadeBy?.name ?? "Unknown Manufacturer"
    }


}

// MARK: Generated accessors for hasMassOfPart
extension Widget {

    @objc(addHasMassOfPartObject:)
    @NSManaged public func addToHasMassOfPart(_ value: MassOfPartEntity)

    @objc(removeHasMassOfPartObject:)
    @NSManaged public func removeFromHasMassOfPart(_ value: MassOfPartEntity)

    @objc(addHasMassOfPart:)
    @NSManaged public func addToHasMassOfPart(_ values: NSSet)

    @objc(removeHasMassOfPart:)
    @NSManaged public func removeFromHasMassOfPart(_ values: NSSet)

}
