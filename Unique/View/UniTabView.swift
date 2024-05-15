import SwiftUI

struct UniTabView: View {
    var body: some View {
        TabView {
            NewsView()
                .tabItem {
                    Label("Новости", systemImage: "newspaper")
                }
            
            ScheduleView()
                .tabItem {
                    Label("Расписание", systemImage: "calendar.badge.clock")
                }

            AboutView()
                .tabItem {
                    Label("О Нас", systemImage: "info.square")
                }
        }
    }
}

struct UniTabView_Previews: PreviewProvider {
    static var previews: some View {
        UniTabView()
    }
}
