import SwiftUI

struct MainTabView: View {

    // MARK: - State
    @State private var selectedTab = 0


    // MARK: - Body
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                DashboardView()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            .tag(0)

            AppNavigationStack {
                GarageView()
            }
            .tabItem {
                Label("Garaje", systemImage: "car.side")
            }
            .tag(1)

            NavigationStack {
                HistoryView()
            }
            .tabItem {
                Label("History", systemImage: "clock.arrow.circlepath")
            }
            .tag(2)

            NavigationStack {
                MoreView()
            }
            .tabItem {
                Label("Other", systemImage: "ellipsis")
            }
            .tag(3)
        }
    }

}

// MARK: - Preview
#Preview {
    MainTabView()
}
