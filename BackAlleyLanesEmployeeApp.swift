import SwiftUI

@main
struct BackAlleyLanesEmployeeApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}

private enum MainTab: Hashable {
    case dashboard
    case inventory
    case checklist
}

struct MainTabView: View {
    @State private var selectedTab: MainTab = .dashboard

    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tag(MainTab.dashboard)
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar.xaxis")
                }

            InventoryView()
                .tag(MainTab.inventory)
                .tabItem {
                    Label("Inventory", systemImage: "shippingbox")
                }

            OmniChecklistView()
                .tag(MainTab.checklist)
                .tabItem {
                    Label("Omni Checklist", systemImage: "checklist")
                }
        }
    }
}

#Preview {
    MainTabView()
}
