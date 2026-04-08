import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: TabItem = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:
                    HomeDashboardView(selectedTab: $selectedTab)
                case .modules:
                    NavigationStack {
                        ModulesView(selectedTab: $selectedTab)
                    }
                case .alerts:
                    alertsPlaceholder
                case .profile:
                    ProfileView(selectedTab: $selectedTab)
                }
            }

            FamOsTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }

    private var alertsPlaceholder: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "bell")
                .font(.system(size: 48))
                .foregroundStyle(FamOsTheme.neutralGrey.opacity(0.3))
            Text("No alerts yet")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(FamOsTheme.brandDark)
            Text("Family notifications will appear here.")
                .font(.system(size: 14))
                .foregroundStyle(FamOsTheme.neutralGrey)
            Spacer()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(FamOsTheme.background)
    }
}

#Preview {
    MainTabView()
}
