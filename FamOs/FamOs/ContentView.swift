import SwiftUI

enum AppScreen {
    case login
    case createAccount
    case familySetup
    case main
}

struct ContentView: View {
    @State private var currentScreen: AppScreen = .login

    var body: some View {
        Group {
            switch currentScreen {
            case .login:
                LoginView(
                    onLogin: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentScreen = .main
                        }
                    },
                    onCreateAccount: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentScreen = .createAccount
                        }
                    }
                )

            case .createAccount:
                CreateAccountView(
                    onContinue: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentScreen = .familySetup
                        }
                    },
                    onLogin: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentScreen = .login
                        }
                    }
                )

            case .familySetup:
                FamilySetupView(
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
