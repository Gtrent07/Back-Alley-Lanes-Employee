import SwiftUI

struct OmniChecklistView: View {
    private struct ChecklistItem: Identifiable {
        let id = UUID()
        let time: String?
        let title: String
        let details: String
    }

    @State private var completedItems: Set<UUID> = []

    private let openingTasks: [ChecklistItem] = [
        ChecklistItem(
            time: "10:30–10:45 AM",
            title: "Power on Omni Arena",
            details: "Flip both switches inside the computer cabinet at the same time."
        ),
        ChecklistItem(
            time: nil,
            title: "Prep controllers & trackers",
            details: "Place every hand controller and tracker in its charger and power them on."
        ),
        ChecklistItem(
            time: nil,
            title: "Clean and polish bases",
            details: "Spray bases with Omni water + soap, wipe with black towels, then apply 5 drops of EASY-WALK using the polishing pad per base."
        ),
        ChecklistItem(
            time: nil,
            title: "Detail headsets",
            details: "Clean HMD lenses with microfiber, sanitize foam face/back covers, and verify cables are routed through the rear strain relief."
        ),
        ChecklistItem(
            time: nil,
            title: "Wipe touchpoints",
            details: "Clean Omni touchscreens with alcohol wipes or Windex and windows with Omni soap solution only (no other cleaners)."
        ),
        ChecklistItem(
            time: nil,
            title: "Tidy play area",
            details: "Sweep or mop the floor, then dust interior/exterior walls with microfiber towels. Flag Gregory if supplies are running low."
        )
    ]

    private let hourlyTasks: [ChecklistItem] = [
        ChecklistItem(
            time: "1:00 PM",
            title: "Refresh waiting area",
            details: "Swiffer floors, clean benches, wipe display screens, and store all Omni shoes neatly."
        ),
        ChecklistItem(
            time: "3:00 PM",
            title: "Sanitize stations",
            details: "Wipe all four Omni stations with the approved cleaning solution."
        ),
        ChecklistItem(
            time: "5:00 PM",
            title: "Entry tidy-up",
            details: "Sweep outside the Omni near pinball & front doors, then vacuum rugs with the corded vacuum."
        ),
        ChecklistItem(
            time: "6:00 PM",
            title: "Detail cubbies & shoes",
            details: "Use handheld vacuum, rag, and glass cleaner to clear cubbies and dust the bottom of every shoe."
        ),
        ChecklistItem(
            time: "7:00 PM",
            title: "Polish glass & exterior",
            details: "Lightly spray a microfiber rag to clean inside/outside windows by the benches and dust the Omni exterior."
        ),
        ChecklistItem(
            time: "8:00 PM",
            title: "Pinball touch-up",
            details: "Use the glass rag only (no extra spray) to wipe each pinball machine playfield."
        ),
        ChecklistItem(
            time: "9:00 PM",
            title: "Pre-close floor sweep",
            details: "Vacuum in front of the Omni (pinballs + new door) and sweep inside/outside the arena."
        )
    ]

    private let closingTasks: [ChecklistItem] = [
        ChecklistItem(
            time: "10:00 PM Tue–Thu / 11:00 PM Fri–Sat",
            title: "Power down gear",
            details: "Turn off all controllers and trackers, placing each set inside the matching corner cabinets."
        ),
        ChecklistItem(
            time: nil,
            title: "Reset footwear & seating",
            details: "Clean every shoe, return pairs to their spots, and wipe down seats."
        ),
        ChecklistItem(
            time: nil,
            title: "Dry mop & vacuum",
            details: "Dry mop the entire Omni floor and station pads, then vacuum station mats and the front rug."
        ),
        ChecklistItem(
            time: nil,
            title: "Final floor pass",
            details: "Swiffer all non-station floors for a clean finish."
        ),
        ChecklistItem(
            time: nil,
            title: "Trash & shutdown",
            details: "Empty the trash can and close the arena entrance with the station belt plus standee."
        )
    ]

    var body: some View {
        NavigationStack {
            List {
                Section("Night Opening Prep") {
                    checklistSection(for: openingTasks)
                }
                Section("Hourly Walkthrough") {
                    checklistSection(for: hourlyTasks)
                }
                Section {
                    checklistSection(for: closingTasks)
                } header: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Closing Procedures")
                        Text("Start at 10 PM (Tue–Thu) or 11 PM (Fri–Sat).")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .textCase(nil)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Omni Arena Checklist")
            .toolbar {
                Button("Reset") {
                    withAnimation {
                        completedItems.removeAll()
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func checklistSection(for tasks: [ChecklistItem]) -> some View {
        ForEach(tasks) { item in
            Button {
                toggle(item)
            } label: {
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: completedItems.contains(item.id) ? "checkmark.circle.fill" : "circle")
                        .font(.title3)
                        .foregroundStyle(completedItems.contains(item.id) ? .green : .secondary)
                    VStack(alignment: .leading, spacing: 4) {
                        if let time = item.time {
                            Text(time.uppercased())
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Text(item.title)
                            .font(.headline)
                        Text(item.details)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 6)
            }
            .buttonStyle(.plain)
        }
    }

    private func toggle(_ item: ChecklistItem) {
        if completedItems.contains(item.id) {
            completedItems.remove(item.id)
        } else {
            completedItems.insert(item.id)
        }
    }
}

#Preview {
    OmniChecklistView()
}
