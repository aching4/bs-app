//
//  SharedData.swift
//  BillSplitter_Test
//
//
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
