import SwiftUI

struct HomeDashboardView: View {
    @Binding var selectedTab: TabItem
    @State private var showAddEvent = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Good morning, García family")
                            .font(.system(size: 28, weight: .heavy))
                            .foregroundStyle(FamOsTheme.brandDark)
                            .tracking(-0.5)

                        Text("TUESDAY, OCTOBER 24TH")
                            .font(.system(size: 12, weight: .medium))
                            .tracking(2)
                            .foregroundStyle(FamOsTheme.neutralGrey)
                    }
                    .padding(.bottom, 24)

                    // Module Pills
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            modulePill(icon: "calendar", label: "Calendar", isActive: true)
                            modulePill(icon: "archivebox", label: "Pantry", isActive: false)
                        }
                    }
                    .padding(.bottom, 24)

                    // Today at a Glance
                    HStack {
                        SectionLabel(text: "Today at a glance")
                        Spacer()
                        NavigationLink {
                            CalendarViewAllView(selectedTab: $selectedTab)
                                .toolbar(.hidden, for: .navigationBar)
                        } label: {
                            Text("View All")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(FamOsTheme.primaryIndigo)
                        }
                    }
                    .padding(.horizontal, 4)
                    .padding(.bottom, 16)

                    // Calendar Summary Card
                    NavigationLink {
                        FamilyCalendarView(selectedTab: $selectedTab)
                            .toolbar(.hidden, for: .navigationBar)
                    } label: {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                HStack(spacing: 12) {
                                    ZStack {
                                        Circle()
                                            .fill(FamOsTheme.primaryLight)
                                            .frame(width: 40, height: 40)
                                        Image(systemName: "calendar")
                                            .foregroundStyle(FamOsTheme.primaryIndigo)
                                    }
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Calendar")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundStyle(FamOsTheme.brandDark)
                                        Text("3 events today")
                                            .font(.system(size: 12))
                                            .foregroundStyle(FamOsTheme.neutralGrey)
                                    }
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(FamOsTheme.neutralGrey.opacity(0.5))
                            }

                            // Event items
                            VStack(spacing: 12) {
                                dashboardEventRow(time: "09:00", title: "School drop-off (Mateo)", color: FamOsTheme.secondary)
                                dashboardEventRow(time: "14:30", title: "Grocery shopping", color: FamOsTheme.semanticPositive)
                            }
                        }
                        .padding(24)
                        .background(FamOsTheme.surface)
                        .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium))
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 16)

                    // Hero / Tip Card
                    ZStack(alignment: .bottomLeading) {
                        RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium)
                            .fill(
                                LinearGradient(
                                    colors: [FamOsTheme.surfaceContainer, FamOsTheme.elevatedSection],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(height: 192)
                            .overlay(
                                Image(systemName: "fork.knife")
                                    .font(.system(size: 64))
                                    .foregroundStyle(FamOsTheme.neutralGrey.opacity(0.1))
                                    .offset(x: 60, y: -20)
                            )

                        VStack(alignment: .leading, spacing: 6) {
                            Text("WEEKLY TIP")
                                .font(.system(size: 10, weight: .black))
                                .tracking(3)
                                .foregroundStyle(FamOsTheme.neutralGrey)

                            Text("Plan your Sunday meal prep today to save 4 hours this week.")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(FamOsTheme.brandDark)
                                .lineSpacing(4)
                        }
                        .padding(24)
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal, 24)
                .padding(.top, 48)
                .padding(.bottom, 120)
            }

            // FAB
            FloatingActionButton {
                showAddEvent = true
            }
            .padding(.trailing, 24)
            .padding(.bottom, 100)
        }
        .background(FamOsTheme.background)
        .sheet(isPresented: $showAddEvent) {
            AddNewEventView(isPresented: $showAddEvent)
        }
    }

    @ViewBuilder
    private func modulePill(icon: String, label: String, isActive: Bool) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 16))
            Text(label)
                .font(.system(size: 14, weight: .bold))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(isActive ? FamOsTheme.primaryLight : FamOsTheme.surface)
        .foregroundStyle(isActive ? FamOsTheme.primaryIndigo : FamOsTheme.neutralGrey)
        .clipShape(Capsule())
    }

    @ViewBuilder
    private func dashboardEventRow(time: String, title: String, color: Color) -> some View {
        HStack(spacing: 16) {
            Text(time)
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(FamOsTheme.primaryIndigo)
                .frame(width: 48)

            RoundedRectangle(cornerRadius: 2)
                .fill(color)
                .frame(width: 4, height: 16)

            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(FamOsTheme.brandDark)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(FamOsTheme.background)
        .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusSmall))
    }
}

#Preview {
    HomeDashboardView(selectedTab: .constant(.home))
}
