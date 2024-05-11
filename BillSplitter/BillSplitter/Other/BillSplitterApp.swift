//
//  BillSplitterApp.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//

import SwiftUI
//import MongoSwiftSync

@main
struct BillSplitterApp: App {
    //init(){
        //defer {
            // free driver resources
            //cleanupMongoSwift()
        //}
        // replace the following string with your connection uri
        //let uri = "mongodb+srv://<username>:<password>@<cluster-address>/test?w=majority"
        //let client = try MongoClient(uri)
    //}
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
