import SwiftUI

struct ModulesView: View {
    @Binding var selectedTab: TabItem

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Modules")
                        .font(.system(size: 30, weight: .heavy))
                        .foregroundStyle(FamOsTheme.brandDark)
                        .tracking(-0.5)

                    Text("Customize your family ecosystem with integrated tools and shared workspaces.")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(FamOsTheme.neutralGrey)
                        .lineSpacing(4)
                }
                .padding(.bottom, 40)

                // Module Grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    // Calendar Module
                    NavigationLink {
                        FamilyCalendarView(selectedTab: $selectedTab)
                            .toolbar(.hidden, for: .navigationBar)
                    } label: {
                        VStack(alignment: .leading, spacing: 16) {
                            ZStack {
                                RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium)
                                    .fill(FamOsTheme.primaryLight)
                                    .frame(width: 56, height: 56)
                                Image(systemName: "calendar")
                                    .font(.system(size: 24))
                                    .foregroundStyle(FamOsTheme.primaryIndigo)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Calendar")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundStyle(FamOsTheme.brandDark)
                                SectionLabel(text: "Shared Schedules")
                            }
                        }
                        .padding(24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(FamOsTheme.surface)
                        .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium))
                    }
                    .buttonStyle(.plain)

                    // Add Module Placeholder
                    VStack(spacing: 8) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 24))
                            .foregroundStyle(FamOsTheme.neutralGrey)
                        Text("ADD MODULE")
                            .font(.system(size: 10, weight: .bold))
                            .tracking(2)
                            .foregroundStyle(FamOsTheme.neutralGrey)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 48)
                    .background(FamOsTheme.surface.opacity(0.5))
                    .overlay(
                        RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium)
                            .stroke(FamOsTheme.outlineVariant.opacity(0.3), style: StrokeStyle(lineWidth: 2, dash: [8]))
                    )
                    .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium))
                    .opacity(0.6)
                }
                .padding(.bottom, 48)

                // Automation Hub Feature Card
                VStack(spacing: 0) {
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
                                Image(systemName: "house.fill")
                                    .font(.system(size: 64))
                                    .foregroundStyle(FamOsTheme.neutralGrey.opacity(0.08))
                                    .offset(x: 60, y: -30)
                            )

                        VStack(alignment: .leading, spacing: 8) {
                            Text("NEW UPDATE")
                                .font(.system(size: 10, weight: .bold))
                                .tracking(2)
                                .foregroundStyle(FamOsTheme.primaryIndigo)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(FamOsTheme.primaryLight)
                                .clipShape(Capsule())

                            Text("Automation Hub")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(FamOsTheme.brandDark)

                            Text("Integrate smart home devices with your FamOS dashboard.")
                                .font(.system(size: 14))
                                .foregroundStyle(FamOsTheme.neutralGrey)
                                .lineSpacing(2)
                        }
                        .padding(24)
                    }
                }
                .background(FamOsTheme.surface)
                .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium))
            }
            .padding(.horizontal, 24)
            .padding(.top, 48)
            .padding(.bottom, 120)
        }
        .background(FamOsTheme.background)
    }
}

#Preview {
    ModulesView(selectedTab: .constant(.modules))
}
