import SwiftUI

struct FamilySetupView: View {
    var onStartFamily: () -> Void = {}
    var onJoinFamily: () -> Void = {}
    var onGoPersonal: () -> Void = {}

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 8) {
                    Text("Welcome to FamOS")
                        .font(.system(size: 30, weight: .heavy))
                        .foregroundStyle(FamOsTheme.brandDark)
                        .tracking(-0.5)

                    Text("How would you like to start?")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(FamOsTheme.neutralGrey)
                }
                .padding(.top, 64)
                .padding(.bottom, 48)

                // Cards
                VStack(spacing: 24) {
                    // Start a New Family (disabled)
                    setupCard(
                        icon: "house.fill",
                        title: "Start a New Family",
                        description: "Create a new household and invite your family members.",
                        buttonStyle: .primary,
                        buttonTitle: "Start Plan",
                        buttonIcon: "arrow.right",
                        showAccentDot: true,
                        isDisabled: true,
                        action: onStartFamily
                    )

                    // Join an Existing Family (disabled)
                    setupCard(
                        icon: "person.2.fill",
                        title: "Join an Existing Family",
                        description: "Join a family that already uses FamOS via an invite link or code.",
                        buttonStyle: .secondary,
                        buttonTitle: "Join Family",
                        buttonIcon: "qrcode",
                        isDisabled: true,
                        action: onJoinFamily
                    )

                    // Use Individually
                    setupCard(
                        icon: "person.fill",
                        title: "Use Individually",
                        description: "Keep your personal life organized without sharing a workspace.",
                        buttonStyle: .secondary,
                        buttonTitle: "Go Personal",
                        buttonIcon: "person",
                        action: onGoPersonal
                    )
                }
                .padding(.horizontal, 24)

                // Footer
                Text("THE DISCIPLINED HOUSEHOLD MANAGEMENT SYSTEM")
                    .font(.system(size: 10, weight: .black))
                    .tracking(3)
                    .foregroundStyle(FamOsTheme.neutralGrey)
                    .padding(.top, 64)
                    .padding(.bottom, 40)
            }
        }
        .background(FamOsTheme.background)
    }

    private enum ButtonStyle {
        case primary, secondary
    }

    @ViewBuilder
    private func setupCard(
        icon: String,
        title: String,
        description: String,
        buttonStyle: ButtonStyle,
        buttonTitle: String,
        buttonIcon: String,
        showAccentDot: Bool = false,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            // Icon
            ZStack {
                Circle()
                    .fill(FamOsTheme.primaryLight)
                    .frame(width: 48, height: 48)
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundStyle(FamOsTheme.primaryIndigo)
            }
            .padding(.bottom, 24)

            // Title & Description
            HStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(FamOsTheme.brandDark)
                if isDisabled {
                    Text("COMING SOON")
                        .font(.system(size: 10, weight: .bold))
                        .tracking(1)
                        .foregroundStyle(FamOsTheme.neutralGrey)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(FamOsTheme.elevatedSection)
                        .clipShape(Capsule())
                }
            }
            .padding(.bottom, 8)

            Text(description)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(FamOsTheme.neutralGrey)
                .lineSpacing(4)
                .padding(.bottom, 24)

            // Decorative Image Placeholder
            RoundedRectangle(cornerRadius: FamOsTheme.radiusSmall)
                .fill(FamOsTheme.surfaceContainerLow)
                .frame(height: 160)
                .overlay(
                    Image(systemName: "photo")
                        .font(.system(size: 32))
                        .foregroundStyle(FamOsTheme.neutralGrey.opacity(0.3))
                )
                .padding(.bottom, 24)

            // Button
            switch buttonStyle {
            case .primary:
                PrimaryButton(buttonTitle, icon: buttonIcon, action: action)
                    .opacity(isDisabled ? 0.4 : 1.0)
            case .secondary:
                SecondaryButton(buttonTitle, icon: buttonIcon, action: action)
                    .opacity(isDisabled ? 0.4 : 1.0)
            }
        }
        .padding(32)
        .background(FamOsTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium))
        .opacity(isDisabled ? 0.7 : 1.0)
        .allowsHitTesting(!isDisabled)
        .overlay(alignment: .topTrailing) {
            if showAccentDot {
                Circle()
                    .fill(FamOsTheme.accentCoral)
                    .frame(width: 8, height: 8)
                    .padding(16)
            }
        }
    }
}

#Preview {
    FamilySetupView()
}
