//
//  SharedData.swift
//  BillSplitter
//
//  Created by Ashley C on 5/21/24.
//

import SwiftUI
import Combine
import Foundation

class SharedData: ObservableObject {
    @Published var peopleNames: [String] = []
    @Published var entries: [Entry] = []
    @Published var fee: Double = 0
    @Published var tax: Double = 0
    @Published var tip: Double = 0
}
