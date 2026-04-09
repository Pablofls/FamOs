import SwiftUI

enum TabItem: Int, CaseIterable {
    case home, modules, alerts, profile

    var label: String {
        switch self {
        case .home: "HOME"
        case .modules: "MODULES"
        case .alerts: "ALERTS"
        case .profile: "PROFILE"
        }
    }

    var icon: String {
        switch self {
        case .home: "house"
        case .modules: "square.grid.2x2"
        case .alerts: "bell"
        case .profile: "person"
        }
    }

    var iconFilled: String {
        switch self {
        case .home: "house.fill"
        case .modules: "square.grid.2x2.fill"
        case .alerts: "bell.fill"
        case .profile: "person.fill"
        }
    }
}

struct FamOsTabBar: View {
    @Binding var selectedTab: TabItem

    var body: some View {
        HStack {
            ForEach(TabItem.allCases, id: \.rawValue) { tab in
                Spacer()
                tabButton(for: tab)
                Spacer()
            }
        }
        .padding(.horizontal, 4)
        .padding(.top, 12)
        .padding(.bottom, 28)
        .background(
            FamOsTheme.surface
                .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]))
                .shadow(color: .black.opacity(0.05), radius: 16, y: -4)
        )
    }

    var onTabTapped: ((TabItem) -> Void)? = nil

    @ViewBuilder
    private func tabButton(for tab: TabItem) -> some View {
        let isSelected = selectedTab == tab
        Button {
            withAnimation(.easeInOut(duration: 0.15)) {
                onTabTapped?(tab)
                selectedTab = tab
            }
        } label: {
            Image(systemName: isSelected ? tab.iconFilled : tab.icon)
                .font(.system(size: 24))
                .foregroundStyle(isSelected ? FamOsTheme.primaryIndigo : FamOsTheme.neutralGrey)
                .frame(width: 48, height: 48)
                .background(
                    isSelected ? FamOsTheme.primaryLight : Color.clear
                )
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
