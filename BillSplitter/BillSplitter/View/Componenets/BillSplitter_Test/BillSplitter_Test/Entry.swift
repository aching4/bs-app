//
//  Entry.swift
//  BillSplitter_Test
//
//  
//

import Foundation
import SwiftUI

class EntryObject: ObservableObject {
    @Published var names: [String] = []
    @Published var price: Double
    @Published var item: String
    
    
    init() {
            self.names = []
            self.price = 0
            self.item = ""
        }
    
    func update(names: [String], price: Double, item: String) {
        self.names = names
        self.price = price
        self.item = item
    }
    
}
