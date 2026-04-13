import SwiftUI

struct FamilyCalendarView: View {
    @State private var selectedDate = 6
    @State private var showAddEvent = false
    @Binding var selectedTab: TabItem

    private let daysOfWeek = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]

    // Calendar data: day number -> member dot colors
    private let eventDots: [Int: [Color]] = [
        3: [FamOsTheme.accentCoral, FamOsTheme.semanticPositive],
        6: [.white],
        11: [FamOsTheme.primaryIndigo],
        15: [FamOsTheme.memberMiel]
    ]

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    // Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Family Schedule")
                            .font(.system(size: 30, weight: .heavy))
                            .foregroundStyle(FamOsTheme.brandDark)
                            .tracking(-0.5)

                        HStack {
                            Text("OCTOBER 2023")
                                .font(.system(size: 12, weight: .medium))
                                .tracking(2)
                                .foregroundStyle(FamOsTheme.neutralGrey)

                            Spacer()

                            HStack(spacing: 8) {
                                navButton(icon: "chevron.left")
                                navButton(icon: "chevron.right")
                            }
                        }
                    }

                    // Calendar Grid
                    VStack(spacing: 16) {
                        // Day headers
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                            ForEach(daysOfWeek, id: \.self) { day in
                                Text(day)
                                    .font(.system(size: 10, weight: .bold))
                                    .tracking(2)
                                    .foregroundStyle(FamOsTheme.neutralGrey)
                                    .frame(maxWidth: .infinity)
                            }
                        }

                        // Day cells
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 7), spacing: 4) {
                            // Previous month days
                            ForEach(26...31, id: \.self) { day in
                                dayCell(day: day, isCurrentMonth: false)
                            }
                            // Current month days
                            ForEach(1...15, id: \.self) { day in
                                dayCell(day: day, isCurrentMonth: true)
                            }
                        }
                    }
                    .padding(24)
                    .background(FamOsTheme.surface)
                    .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium))

                    // Upcoming Events
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            SectionLabel(text: "Upcoming Events")
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

                        // Event Cards
                        ForEach(SampleData.upcomingCalendarEvents) { event in
                            upcomingEventCard(event: event)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 48)
                .padding(.bottom, 120)
            }

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
    private func navButton(icon: String) -> some View {
        Button {} label: {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(FamOsTheme.primaryIndigo)
                .frame(width: 32, height: 32)
                .background(FamOsTheme.surfaceContainerLow)
                .clipShape(Circle())
        }
    }

    @ViewBuilder
    private func dayCell(day: Int, isCurrentMonth: Bool) -> some View {
        let isSelected = isCurrentMonth && day == selectedDate
        let dots = isCurrentMonth ? (eventDots[day] ?? []) : []

        Button {
            if isCurrentMonth { selectedDate = day }
        } label: {
            VStack(spacing: 4) {
                Text("\(day)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(
                        !isCurrentMonth ? FamOsTheme.neutralGrey.opacity(0.3) :
                        isSelected ? .white :
                        FamOsTheme.brandDark
                    )

                HStack(spacing: 2) {
                    ForEach(0..<dots.count, id: \.self) { i in
                        Circle()
                            .fill(dots[i])
                            .frame(width: 5, height: 5)
                    }
                }
                .frame(height: 6)
            }
            .frame(maxWidth: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .background(
                isSelected ? FamOsTheme.primaryIndigo :
                isCurrentMonth ? FamOsTheme.surfaceContainerLow :
                Color.clear
            )
            .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusSmall))
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private func upcomingEventCard(event: CalendarEvent) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                HStack(spacing: 16) {
                    if let member = event.member {
                        MemberAvatar(member: member, size: 48)
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        Text(event.title)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(FamOsTheme.brandDark)
                        if let location = event.location {
                            Text("\(event.time) - \(location)")
                                .font(.system(size: 12))
                                .foregroundStyle(FamOsTheme.neutralGrey)
                        }
                    }
                }

                Spacer()

                if let tag = event.memberTag {
                    Text(tag)
                        .font(.system(size: 10, weight: .black))
                        .tracking(1)
                        .foregroundStyle(event.tagColor)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(event.tagBgColor)
                        .clipShape(Capsule())
                }
            }

            // Sub-event row
            HStack(spacing: 16) {
                Text(event.time)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(FamOsTheme.primaryIndigo)
                    .frame(width: 48)

                RoundedRectangle(cornerRadius: 2)
                    .fill(event.accentColor)
                    .frame(width: 4, height: 16)

                Text(event.title == "Project Sync with Team" ? "Review quarterly objectives" : "Vinyasa Flow Class")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(FamOsTheme.brandDark)
            }
            .padding(12)
            .background(FamOsTheme.background)
            .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusSmall))
        }
        .padding(24)
        .background(FamOsTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusMedium))
    }
}

#Preview {
    FamilyCalendarView(selectedTab: .constant(.modules))
}
