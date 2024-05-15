import SwiftUI

@main
struct UniqueApp: App {
    @StateObject private var selection = Selection()

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
//            ContentView()
                .environmentObject(selection)
                .onAppear {
                    selection.loadSelection()
                }
        }
    }
}
