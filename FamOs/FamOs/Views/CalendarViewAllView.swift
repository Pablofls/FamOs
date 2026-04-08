import SwiftUI

struct CalendarViewAllView: View {
    @Binding var selectedTab: TabItem
    @State private var showAddEvent = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Top bar
                    HStack {
                        Spacer()
                        HStack(spacing: 12) {
                            Button {} label: {
                                Image(systemName: "calendar")
                                    .foregroundStyle(FamOsTheme.primaryIndigo)
                                    .padding(8)
                                    .background(FamOsTheme.surfaceContainerHigh)
                                    .clipShape(Circle())
                            }

                            ZStack {
                                Circle()
                                    .fill(FamOsTheme.primaryLight)
                                    .frame(width: 40, height: 40)
                                Image(systemName: "person.fill")
                                    .foregroundStyle(FamOsTheme.primaryIndigo)
                            }
                        }
                    }
                    .padding(.bottom, 24)

                    // Title
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Calendar")
                            .font(.system(size: 30, weight: .heavy))
                            .foregroundStyle(FamOsTheme.brandDark)
                            .tracking(-0.5)

                        Text("THE FAMILY SCHEDULE FOR OCTOBER")
                            .font(.system(size: 12, weight: .medium))
                            .tracking(2)
                            .foregroundStyle(FamOsTheme.neutralGrey)
                    }
                    .padding(.bottom, 40)

                    // Today Section
                    daySection(
                        dateLabel: "Today, Oct 24",
                        eventCount: "3 EVENTS",
                        events: SampleData.todayEvents,
                        isToday: true
                    )

                    // Tomorrow Section
                    daySection(
                        dateLabel: "Tomorrow, Oct 25",
                        eventCount: "2 EVENTS",
                        events: SampleData.tomorrowEvents,
                        isToday: false
                    )
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
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
    private func daySection(dateLabel: String, eventCount: String, events: [CalendarEvent], isToday: Bool) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            // Sticky Header
            HStack(alignment: .firstTextBaseline) {
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(isToday ? FamOsTheme.primaryIndigo : FamOsTheme.neutralGrey.opacity(0.3))
                        .frame(width: 4, height: 20)
                    Text(dateLabel)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(FamOsTheme.brandDark)
                }
                Spacer()
                Text(eventCount)
                    .font(.system(size: 10, weight: .black))
                    .tracking(2)
                    .foregroundStyle(FamOsTheme.neutralGrey)
            }

            // Events
            VStack(spacing: 12) {
                ForEach(events) { event in
                    EventCard(event: event)
                }
            }
        }
        .padding(.bottom, 40)
    }
}

#Preview {
    CalendarViewAllView(selectedTab: .constant(.modules))
}
