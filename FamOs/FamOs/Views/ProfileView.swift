import SwiftUI

struct ProfileView: View {
    @Binding var selectedTab: TabItem

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Header Section
                HStack(spacing: 24) {
                    ZStack(alignment: .bottomTrailing) {
                        ZStack {
                            RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium)
                                .fill(FamOsTheme.primaryLight)
                                .frame(width: 96, height: 96)
                            Image(systemName: "person.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(FamOsTheme.primaryIndigo)
                        }

                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(FamOsTheme.primaryIndigo)
                                .frame(width: 28, height: 28)
                            Image(systemName: "checkmark.shield.fill")
                                .font(.system(size: 12))
                                .foregroundStyle(.white)
                        }
                        .offset(x: 4, y: 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(FamOsTheme.background, lineWidth: 4)
                                .frame(width: 28, height: 28)
                                .offset(x: 4, y: 4)
                        )
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Elena García")
                            .font(.system(size: 28, weight: .heavy))
                            .foregroundStyle(FamOsTheme.brandDark)
                            .tracking(-0.5)

                        Text("PARENT / ADMINISTRATOR")
                            .font(.system(size: 12, weight: .medium))
                            .tracking(2)
                            .foregroundStyle(FamOsTheme.neutralGrey)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // Family Members
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        SectionLabel(text: "Family Members")
                        Spacer()
                        Text("3 ACTIVE")
                            .font(.system(size: 12, weight: .bold))
                            .tracking(2)
                            .foregroundStyle(FamOsTheme.primaryIndigo)
                    }
                    .padding(.horizontal, 4)

                    VStack(spacing: 12) {
                        familyMemberRow(name: "Mateo", age: "8 years old", color: FamOsTheme.semanticPositive)
                        familyMemberRow(name: "Sofía", age: "14 years old", color: FamOsTheme.memberMiel)
                    }
                }

                // Account Settings
                VStack(alignment: .leading, spacing: 16) {
                    SectionLabel(text: "Account Settings")
                        .padding(.horizontal, 4)

                    VStack(spacing: 0) {
                        settingsRow(icon: "person", label: "Personal Information")
                        settingsRow(icon: "lock.shield", label: "Privacy & Security")
                        settingsRow(icon: "bell.badge", label: "Notification Preferences")
                        settingsRow(icon: "rectangle.portrait.and.arrow.right", label: "Log Out", isDestructive: true, isLast: true)
                    }
                    .background(FamOsTheme.surface)
                    .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium))
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 48)
            .padding(.bottom, 120)
        }
        .background(FamOsTheme.background)
    }

    @ViewBuilder
    private func familyMemberRow(name: String, age: String, color: Color) -> some View {
        HStack {
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium)
                        .fill(color.opacity(0.2))
                        .frame(width: 56, height: 56)
                    Text(String(name.prefix(1)))
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(color)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(name)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(FamOsTheme.brandDark)
                    Text(age)
                        .font(.system(size: 12))
                        .foregroundStyle(FamOsTheme.neutralGrey)
                }
            }

            Spacer()

            Button {} label: {
                Text("Manage Permissions")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(FamOsTheme.primaryIndigo)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(FamOsTheme.primaryLight)
                    .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium))
            }
        }
        .padding(16)
        .background(FamOsTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium))
    }

    @ViewBuilder
    private func settingsRow(icon: String, label: String, isDestructive: Bool = false, isLast: Bool = false) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundStyle(isDestructive ? FamOsTheme.error : FamOsTheme.primaryIndigo)

                Text(label)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(isDestructive ? FamOsTheme.error : FamOsTheme.brandDark)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundStyle(isDestructive ? FamOsTheme.error.opacity(0.3) : FamOsTheme.neutralGrey.opacity(0.5))
            }
            .padding(20)

            if !isLast {
                Rectangle()
                    .fill(FamOsTheme.background)
                    .frame(height: 1)
            }
        }
    }
}

#Preview {
    ProfileView(selectedTab: .constant(.profile))
}
