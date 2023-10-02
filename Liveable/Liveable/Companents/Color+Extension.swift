//
//  Color+Extension.swift
//  Liveable
//
//  Created by engin gülek on 2.10.2023.
//

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
