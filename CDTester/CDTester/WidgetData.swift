import SwiftUI
import CoreData

struct WidgetData: Hashable, Codable, Identifiable {
    
    var id: UUID
    var manufacturer: String
    var title: String
    var massOfPartArray: [MassOfSubpart]
    
    
    init(){
        self.id = UUID()
        self.manufacturer = ""
        self.title = ""
        self.massOfPartArray = [MassOfSubpart()]
    }
   
    init?(widget: Widget) {
        
        self.id = widget.wrappedId
        self.manufacturer = widget.wrappedIsMadeBy
        self.title = widget.wrappedTitle
        self.massOfPartArray = widget.wrappedMassOfPartArray
            }
    
    
        
}

