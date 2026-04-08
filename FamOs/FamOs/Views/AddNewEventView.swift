import SwiftUI

struct AddNewEventView: View {
    @Binding var isPresented: Bool
    @State private var eventTitle = ""
    @State private var eventDescription = ""
    @State private var selectedDate = Date()
    @State private var eventTime = Date()
    @State private var timeEnabled = true
    @State private var repetition = "Weekly"
    @State private var privacy = "Public"
    @State private var selectedMembers: Set<String> = ["Dad", "Mom", "Leo"]

    private let members = [
        ("Dad", FamOsTheme.primaryIndigo),
        ("Mom", FamOsTheme.accentCoral),
        ("Leo", FamOsTheme.semanticPositive),
        ("Mia", FamOsTheme.memberMiel)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Title & Description Card
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            SectionLabel(text: "Event Title")
                            TextField("Weekly Family Dinner", text: $eventTitle)
                                .font(.system(size: 24, weight: .heavy))
                                .foregroundStyle(FamOsTheme.brandDark)
                        }

                        Rectangle()
                            .fill(FamOsTheme.background)
                            .frame(height: 1)

                        VStack(alignment: .leading, spacing: 8) {
                            SectionLabel(text: "Description")
                            TextField("Add some details about this event...", text: $eventDescription, axis: .vertical)
                                .font(.system(size: 16))
                                .foregroundStyle(FamOsTheme.neutralGrey)
                                .lineLimit(3...6)
                        }
                    }
                    .padding(24)
                    .background(FamOsTheme.surface)
                    .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium))

                    // Family Members
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            SectionLabel(text: "Family Members")
                            Spacer()
                            Text("\(selectedMembers.count) SELECTED")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(FamOsTheme.primaryIndigo)
                        }
                        .padding(.horizontal, 4)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(members, id: \.0) { name, color in
                                    memberChip(name: name, color: color, isSelected: selectedMembers.contains(name))
                                }

                                // Add button
                                VStack(spacing: 8) {
                                    ZStack {
                                        Circle()
                                            .stroke(FamOsTheme.outlineVariant, style: StrokeStyle(lineWidth: 2, dash: [6]))
                                            .frame(width: 64, height: 64)
                                        Image(systemName: "plus")
                                            .foregroundStyle(FamOsTheme.neutralGrey)
                                    }
                                    Text("NEW")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundStyle(FamOsTheme.neutralGrey)
                                }
                            }
                        }
                    }

                    // Date and Time
                    HStack(spacing: 16) {
                        // Date
                        VStack(alignment: .leading, spacing: 16) {
                            SectionLabel(text: "Date")
                            HStack(spacing: 12) {
                                Image(systemName: "calendar")
                                    .foregroundStyle(FamOsTheme.primaryIndigo)
                                Text(selectedDate.formatted(.dateTime.month(.abbreviated).day().year()))
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundStyle(FamOsTheme.brandDark)
                            }
                        }
                        .padding(24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(FamOsTheme.surface)
                        .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium))

                        // Time
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                SectionLabel(text: "Time")
                                Spacer()
                                Toggle("", isOn: $timeEnabled)
                                    .tint(FamOsTheme.primaryIndigo)
                                    .labelsHidden()
                                    .scaleEffect(0.8)
                            }
                            HStack(spacing: 12) {
                                Image(systemName: "clock")
                                    .foregroundStyle(FamOsTheme.primaryIndigo)
                                Text("07:00 PM")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundStyle(FamOsTheme.brandDark)
                            }
                        }
                        .padding(24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(FamOsTheme.surface)
                        .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium))
                    }

                    // Repetition & Privacy
                    HStack(spacing: 16) {
                        // Repetition
                        VStack(alignment: .leading, spacing: 0) {
                            SectionLabel(text: "Repetition")
                                .padding(.bottom, 32)

                            HStack {
                                Text(repetition)
                                    .font(.system(size: 20, weight: .heavy))
                                    .foregroundStyle(FamOsTheme.brandDark)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundStyle(FamOsTheme.brandDark)
                            }
                        }
                        .padding(24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(FamOsTheme.elevatedSection)
                        .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium))

                        // Privacy
                        VStack(alignment: .leading, spacing: 0) {
                            SectionLabel(text: "Privacy")
                                .padding(.bottom, 32)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(privacy)
                                    .font(.system(size: 20, weight: .heavy))
                                    .foregroundStyle(FamOsTheme.brandDark)
                                Text("VISIBLE TO ALL FAMILY MEMBERS")
                                    .font(.system(size: 10, weight: .bold))
                                    .tracking(0.5)
                                    .foregroundStyle(FamOsTheme.neutralGrey)
                                    .lineLimit(2)
                            }
                        }
                        .padding(24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(FamOsTheme.surface)
                        .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 120)
            }
            .background(FamOsTheme.background)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 16) {
                        Button {
                            isPresented = false
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(FamOsTheme.brandDark)
                                .frame(width: 40, height: 40)
                                .background(FamOsTheme.elevatedSection)
                                .clipShape(Circle())
                        }

                        Text("New Event")
                            .font(.system(size: 28, weight: .heavy))
                            .foregroundStyle(FamOsTheme.brandDark)
                            .tracking(-0.5)
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isPresented = false
                    } label: {
                        Text("Add Event")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(FamOsTheme.primaryIndigo)
                            .clipShape(Capsule())
                    }
                }
            }
            .toolbarBackground(FamOsTheme.background, for: .navigationBar)
        }
    }

    @ViewBuilder
    private func memberChip(name: String, color: Color, isSelected: Bool) -> some View {
        Button {
            if selectedMembers.contains(name) {
                selectedMembers.remove(name)
            } else {
                selectedMembers.insert(name)
            }
        } label: {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .stroke(isSelected ? FamOsTheme.primaryIndigo : Color.clear, lineWidth: 2)
                        .frame(width: 64, height: 64)
                    Circle()
                        .fill(color.opacity(0.2))
                        .frame(width: 56, height: 56)
                    Text(String(name.prefix(1)))
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(color)
                }
                Text(name.uppercased())
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(isSelected ? FamOsTheme.primaryIndigo : FamOsTheme.neutralGrey)
            }
            .opacity(isSelected ? 1.0 : 0.4)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AddNewEventView(isPresented: .constant(true))
}
