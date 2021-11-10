//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Baptiste Cadoux on 10/11/2021.
//

import SwiftUI

@main
struct BookwormApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
