
import SwiftUI

extension Color {
    static subscript(name: String) -> Color {
         switch name {
             case "gray":
                 return Color.gray
             case "black":
                 return Color.black
             default:
                 return Color.accentColor
         }
     }
}
