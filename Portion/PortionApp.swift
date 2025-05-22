//
//  PortionApp.swift
//  Portion
//
//  Created by David Amedeka on 3/2/25.
//

import SwiftUI

@main
struct PortionApp: App {
    @State private var urlProcessor = URLProcessor()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(urlProcessor)
        }
    }
}
