import SwiftUI

struct SectionLabel: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: 10, weight: .black))
            .tracking(2)
            .textCase(.uppercase)
            .foregroundStyle(FamOsTheme.neutralGrey)
    }
}

struct PrimaryButton: View {
    let title: String
    let icon: String?
    let action: () -> Void

    init(_ title: String, icon: String? = nil, action: @escaping () -> Void = {}) {
        self.title = title
        self.icon = icon
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 16, weight: .heavy))
                    .tracking(-0.3)
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 14, weight: .bold))
                }
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(FamOsTheme.primaryIndigo)
            .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium))
        }
        .buttonStyle(.plain)
    }
}

struct SecondaryButton: View {
    let title: String
    let icon: String?
    let action: () -> Void

    init(_ title: String, icon: String? = nil, action: @escaping () -> Void = {}) {
        self.title = title
        self.icon = icon
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 16, weight: .heavy))
                    .tracking(-0.3)
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 14, weight: .bold))
                }
            }
            .foregroundStyle(FamOsTheme.primaryIndigo)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .overlay(
                RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium)
                    .stroke(FamOsTheme.primaryIndigo, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

struct FamOsTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var trailingIcon: String? = nil

    @State private var showPassword = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            SectionLabel(text: label)
                .padding(.leading, 4)

            ZStack(alignment: .trailing) {
                if isSecure && !showPassword {
                    SecureField(placeholder, text: $text)
                        .textFieldStyle(.plain)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(FamOsTheme.brandDark)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(FamOsTheme.background)
                        .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusSmall))
                } else {
                    TextField(placeholder, text: $text)
                        .textFieldStyle(.plain)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(FamOsTheme.brandDark)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(FamOsTheme.background)
                        .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusSmall))
                }

                if isSecure {
                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundStyle(FamOsTheme.neutralGrey.opacity(0.6))
                    }
                    .padding(.trailing, 16)
                }

                if let icon = trailingIcon, !isSecure {
                    Image(systemName: icon)
                        .foregroundStyle(FamOsTheme.neutralGrey.opacity(0.6))
                        .padding(.trailing, 16)
                }
            }
        }
    }
}

struct MemberAvatar: View {
    let member: FamilyMember
    let size: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .fill(member.color.opacity(0.2))
            Text(member.initials)
                .font(.system(size: size * 0.4, weight: .bold))
                .foregroundStyle(member.color)
        }
        .frame(width: size, height: size)
    }
}

struct EventCard: View {
    let event: CalendarEvent
    let showAmPm: Bool

    init(event: CalendarEvent, showAmPm: Bool = true) {
        self.event = event
        self.showAmPm = showAmPm
    }

    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 2) {
                Text(event.time)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(FamOsTheme.primaryIndigo)
                if showAmPm && !event.amPm.isEmpty {
                    Text(event.amPm)
                        .font(.system(size: 8, weight: .bold))
                        .textCase(.uppercase)
                        .foregroundStyle(FamOsTheme.neutralGrey)
                }
            }
            .frame(width: 48)

            RoundedRectangle(cornerRadius: 2)
                .fill(event.accentColor)
                .frame(width: 4, height: 16)

            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(FamOsTheme.brandDark)

                if let tag = event.memberTag {
                    HStack(spacing: 6) {
                        Text(tag)
                            .font(.system(size: 10, weight: .bold))
                            .tracking(1)
                            .textCase(.uppercase)
                            .foregroundStyle(event.tagColor)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(event.tagBgColor)
                            .clipShape(Capsule())

                        if event.isUrgent {
                            Text("URGENT")
                                .font(.system(size: 10, weight: .bold))
                                .tracking(1)
                                .foregroundStyle(FamOsTheme.error)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(FamOsTheme.errorContainer)
                                .clipShape(Capsule())
                        }
                    }
                }
            }

            Spacer()

            if let icon = event.icon {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(FamOsTheme.background)
                        .frame(width: 40, height: 40)
                    Image(systemName: icon)
                        .foregroundStyle(FamOsTheme.primaryIndigo)
                }
            }
        }
        .padding(16)
        .background(FamOsTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium))
    }
}

struct FloatingActionButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.system(size: 24, weight: .medium))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(FamOsTheme.accentCoral)
                .clipShape(Circle())
                .shadow(color: FamOsTheme.accentCoral.opacity(0.3), radius: 8, y: 4)
        }
    }
}
