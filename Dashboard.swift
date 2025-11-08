import SwiftUI

struct DashboardView: View {
    private struct Metric: Identifiable {
        let id = UUID()
        let title: String
        let value: String
        let trend: String
        let trendIsPositive: Bool
    }

    private let metrics: [Metric] = [
        Metric(title: "Monthly Revenue", value: "$42,560", trend: "+12.4% vs last month", trendIsPositive: true),
        Metric(title: "Monthly Expenses", value: "$18,920", trend: "+4.1% vs last month", trendIsPositive: false),
        Metric(title: "Net Profit", value: "$23,640", trend: "+8.3% vs last month", trendIsPositive: true),
        Metric(title: "Average Lane Utilization", value: "78%", trend: "+6 pts vs last month", trendIsPositive: true)
    ]

    private let activityFeed: [(title: String, subtitle: String, timestamp: String)] = [
        ("League Night Booked", "12 lanes reserved • 6:00 PM", "15m ago"),
        ("Corporate Event Inquiry", "Pending approval • 30 guests", "1h ago"),
        ("Inventory Check", "Pins +8% • Balls -3%", "3h ago")
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                header
                metricsGrid
                revenueBreakdownCard
                activityFeedCard
            }
            .padding(24)
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Back Alley Lanes")
                .font(.largeTitle).bold()
            Text("Operational overview • Updated just now")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var metricsGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            ForEach(metrics) { metric in
                VStack(alignment: .leading, spacing: 8) {
                    Text(metric.title)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    Text(metric.value)
                        .font(.title2)
                        .bold()
                    Label(metric.trend,
                          systemImage: metric.trendIsPositive ? "arrow.up.right" : "arrow.down.right")
                        .font(.caption)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .background(metric.trendIsPositive ? Color.green.opacity(0.15) : Color.red.opacity(0.15))
                        .foregroundStyle(metric.trendIsPositive ? .green : .red)
                        .clipShape(Capsule())
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.background)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 6)
            }
        }
    }

    private var revenueBreakdownCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Revenue Breakdown")
                .font(.headline)
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Lanes")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("$27,300 · 64%")
                        .font(.title3)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 6) {
                    Text("Food & Beverage")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("$11,080 · 26%")
                        .font(.title3)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 6) {
                    Text("Pro Shop")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("$4,180 · 10%")
                        .font(.title3)
                }
            }
            Divider()
            HStack {
                VStack(alignment: .leading) {
                    Text("Top Expense")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("Staffing · $9,450")
                        .bold()
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Next Payroll")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("Due in 4 days")
                        .bold()
                }
            }
        }
        .padding()
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 6)
    }

    private var activityFeedCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Activity")
                .font(.headline)
            ForEach(activityFeed.indices, id: \.self) { idx in
                if idx > 0 { Divider() }
                VStack(alignment: .leading, spacing: 4) {
                    Text(activityFeed[idx].title)
                        .font(.subheadline).bold()
                    Text(activityFeed[idx].subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(activityFeed[idx].timestamp)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 6)
    }
}

#Preview {
    DashboardView()
}
