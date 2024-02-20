//
//  Object.swift
//  sleuth
//
//  Created by Justin Lawrence on 2/17/24.
//

import Foundation
import SwiftUI

class ClueObject: ObservableObject, Hashable {
    static func == (lhs: ClueObject, rhs: ClueObject) -> Bool {
        return lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: String
    var imageName: String
    var color: Color
    var title: String
    var view: AnyView// View
    
    init<T: View>(title: String, imageName: String, color: Color, view: T) {
        self.imageName = imageName
        self.color = color
        self.title = title
        self.id = "_\(title)_\(imageName)+\(color.description)"
        self.view = AnyView(view)
    }
    
    init<T: View>(id: String, title: String, imageName: String, color: Color, view: T) {
        self.imageName = imageName
        self.color = color
        self.title = title
        self.id = id
        self.view = AnyView(view)
    }
}
