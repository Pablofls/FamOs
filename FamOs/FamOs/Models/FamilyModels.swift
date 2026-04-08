import SwiftUI

struct FamilyMember: Identifiable {
    let id = UUID()
    let name: String
    let role: String
    let age: Int?
    let color: Color
    let imageName: String

    var initials: String {
        String(name.prefix(1)).uppercased()
    }
}

struct CalendarEvent: Identifiable {
    let id = UUID()
    let title: String
    let time: String
    let amPm: String
    let location: String?
    let member: FamilyMember?
    let memberTag: String?
    let tagColor: Color
    let tagBgColor: Color
    let accentColor: Color
    let isUrgent: Bool
    let icon: String?

    init(
        title: String,
        time: String,
        amPm: String = "",
        location: String? = nil,
        member: FamilyMember? = nil,
        memberTag: String? = nil,
        tagColor: Color = FamOsTheme.primaryIndigo,
        tagBgColor: Color = FamOsTheme.primaryLight,
        accentColor: Color = FamOsTheme.primaryIndigo,
        isUrgent: Bool = false,
        icon: String? = nil
    ) {
        self.title = title
        self.time = time
        self.amPm = amPm
        self.location = location
        self.member = member
        self.memberTag = memberTag
        self.tagColor = tagColor
        self.tagBgColor = tagBgColor
        self.accentColor = accentColor
        self.isUrgent = isUrgent
        self.icon = icon
    }
}

struct DayEvents: Identifiable {
    let id = UUID()
    let dateLabel: String
    let events: [CalendarEvent]
    let isToday: Bool
}

enum SampleData {
    static let dad = FamilyMember(name: "Dad", role: "Parent / Administrator", age: nil, color: FamOsTheme.primaryIndigo, imageName: "person.fill")
    static let mom = FamilyMember(name: "Mom", role: "Parent", age: nil, color: FamOsTheme.accentCoral, imageName: "person.fill")
    static let mateo = FamilyMember(name: "Mateo", role: "Child", age: 8, color: FamOsTheme.semanticPositive, imageName: "person.fill")
    static let sofia = FamilyMember(name: "Sofía", role: "Child", age: 14, color: FamOsTheme.memberMiel, imageName: "person.fill")

    static let elena = FamilyMember(name: "Elena García", role: "Parent / Administrator", age: nil, color: FamOsTheme.primaryIndigo, imageName: "person.fill")

    static let allMembers = [dad, mom, mateo, sofia]

    static let todayEvents: [CalendarEvent] = [
        CalendarEvent(
            title: "School Drop-off",
            time: "08:00",
            amPm: "AM",
            memberTag: "MENTA",
            tagColor: FamOsTheme.semanticPositive,
            tagBgColor: FamOsTheme.semanticPositiveBg,
            accentColor: FamOsTheme.secondary,
            isUrgent: true
        ),
        CalendarEvent(
            title: "Weekly Groceries",
            time: "12:30",
            amPm: "PM",
            memberTag: "HOUSEHOLD",
            tagColor: FamOsTheme.primaryIndigo,
            tagBgColor: FamOsTheme.primaryLight,
            accentColor: FamOsTheme.primaryIndigo
        ),
        CalendarEvent(
            title: "Soccer Practice",
            time: "07:00",
            amPm: "PM",
            memberTag: "CORAL",
            tagColor: Color(hex: "822804"),
            tagBgColor: FamOsTheme.surfaceContainerLow,
            accentColor: FamOsTheme.accentCoral,
            icon: "sportscourt.fill"
        )
    ]

    static let tomorrowEvents: [CalendarEvent] = [
        CalendarEvent(
            title: "Dentist Appointment",
            time: "10:00",
            amPm: "AM",
            memberTag: "MIEL",
            tagColor: FamOsTheme.primaryIndigo,
            tagBgColor: FamOsTheme.primaryLight,
            accentColor: Color(hex: "B1C5FF")
        ),
        CalendarEvent(
            title: "Piano Lesson",
            time: "04:30",
            amPm: "PM",
            memberTag: "MENTA",
            tagColor: FamOsTheme.semanticPositive,
            tagBgColor: FamOsTheme.semanticPositiveBg,
            accentColor: FamOsTheme.semanticPositive,
            icon: "music.note"
        )
    ]

    static let upcomingCalendarEvents: [CalendarEvent] = [
        CalendarEvent(
            title: "Project Sync with Team",
            time: "14:30",
            location: "Workspace",
            member: dad,
            memberTag: "DAD",
            tagColor: FamOsTheme.primaryIndigo,
            tagBgColor: FamOsTheme.primaryLight,
            accentColor: FamOsTheme.primaryIndigo
        ),
        CalendarEvent(
            title: "Yoga Session",
            time: "18:00",
            location: "Downtown Studio",
            member: mom,
            memberTag: "MOM",
            tagColor: FamOsTheme.secondary,
            tagBgColor: FamOsTheme.secondaryFixed,
            accentColor: FamOsTheme.accentCoral
        )
    ]
}
