import SwiftUI

struct InventoryView: View {
    private struct InventoryItem: Identifiable, Hashable {
        let id = UUID()
        let name: String
        var quantity: Int
        let notes: String

        static let seed: [InventoryItem] = [
            InventoryItem(name: "VR Headsets", quantity: 8, notes: "Check lenses & foam daily"),
            InventoryItem(name: "Controllers", quantity: 16, notes: "Keep pairs charged in cabinet"),
            InventoryItem(name: "Trackers", quantity: 16, notes: "Label per station for easy swaps"),
            InventoryItem(name: "Harnesses", quantity: 8, notes: "Inspect straps before each session")
        ]
    }

    @State private var inventoryItems = InventoryItem.seed

    var body: some View {
        NavigationStack {
            List {
                ForEach($inventoryItems) { $item in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.notes)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        HStack {
                            Label("\(item.quantity) on hand", systemImage: "archivebox")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Spacer()
                            Stepper("\(item.quantity)", value: $item.quantity, in: 0...50)
                                .labelsHidden()
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Omni Inventory")
            .toolbar {
                Button("Reset") {
                    inventoryItems = InventoryItem.seed
                }
            }
        }
    }
}

#Preview {
    InventoryView()
}
