import SwiftUI

enum AppScreen {
    case createAccount
    case familySetup
    case main
}

struct ContentView: View {
    @State private var currentScreen: AppScreen = .createAccount

    var body: some View {
        Group {
            switch currentScreen {
            case .createAccount:
                CreateAccountView(
                    onContinue: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentScreen = .familySetup
                        }
                    },
                    onLogin: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentScreen = .main
                        }
                    }
                )

            case .familySetup:
                FamilySetupView(
                    onStartFamily: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentScreen = .main
                        }
                    },
                    onJoinFamily: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentScreen = .main
                        }
                    },
                    onGoPersonal: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentScreen = .main
                        }
                    }
                )

            case .main:
                MainTabView()
            }
        }
        .transition(.opacity)
    }
}

#Preview {
    ContentView()
}
