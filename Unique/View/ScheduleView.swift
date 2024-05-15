import SwiftUI
import SwiftSoup

struct ScheduleView: View {
    @StateObject private var selection = Selection()
    @StateObject private var taskModel: TaskModel
    @State private var selectedWeekday: Int = {
        let calendar = Calendar.current
        return calendar.component(.weekday, from: Date())
    }()
    @State private var isShowingSelectionView = false

    init() {
        let selection = Selection()
        _taskModel = StateObject(wrappedValue: TaskModel(selection: selection))
    }

    var filteredTasks: [Task] {
        taskModel.tasks.filter { task in
            task.getWeekday() == selectedWeekday
        }
    }

    var body: some View {
        VStack {
            HStack {
                Text("Расписание занятий")
                    .foregroundColor(Color("CardColor"))
                    .padding(2)
                    .font(.title3)
                    .bold()
                Spacer()
                Button(action: {
                    isShowingSelectionView = true
                }) {
                    Label(
                        title: { Text("Settings") },
                        icon: { Image(systemName: "gearshape.fill").foregroundColor(Color("CardColor")) }
                    )
                    .labelStyle(IconOnlyLabelStyle())
                    .padding(.horizontal)
                }
            }
            .padding([.bottom, .leading], 5)
            .sheet(isPresented: $isShowingSelectionView, content: {
                settingsSheet
            })

            VStack {
                HStack {
                    ForEach(2...7, id: \.self) { weekday in
                        Button(action: {
                            selectedWeekday = weekday
                        }) {
                            VStack(spacing: 10) {
                                Text(getWeekdayName(weekday))
                                    .font(.system(size: 14))
                                    .foregroundColor(selectedWeekday == weekday ? .white : .primary)
                                    .fontWeight(.semibold)
                                Text(getCurrentDayText(weekday))
                                    .font(.system(size: 14))
                                    .foregroundColor(selectedWeekday == weekday ? .white : .secondary)
                            }
                            .font(.system(size: 12))
                            .frame(width: 45, height: 80)
                            .background(
                                ZStack {
                                    if weekday == selectedWeekday {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color("CardColor"))
                                    } else {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.white)
                                            .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
                                    }
                                }
                            )
                        }
                    }
                }
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("DaysColor"))
                    .frame(width: 600, height: 2)
            }
            .padding(.bottom, 4)
            .padding(.horizontal)

            ScrollView {
                LazyVStack(spacing: 10) {
                    if filteredTasks.isEmpty {
                        VStack(spacing: 25) {
                            Image("NoStudy")
                                .resizable()
                                .frame(width: 256, height: 256)
                            Text("Похоже, что в данный момент у Вас нет занятий!")
                                .foregroundColor(Color("CardColor"))
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 100)
                    } else {
                        ForEach(filteredTasks) { task in
                            ScheduleRowView(task: task)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }

            Spacer()
        }
        .onAppear {
            taskModel.parseData()
        }
    }

    var settingsSheet: some View {
        NavigationView {
            SelectionView(taskModel: taskModel)
                .environmentObject(selection)
                .navigationBarItems(
                    trailing: Button("Готово") {
                        isShowingSelectionView = false
                    }
                    .foregroundColor(.white)
                    .onAppear {
                        selection.loadSelection()
                        taskModel.parseData()
                    }
                    .onChange(of: selection.selectedCourse) { _ in
                        selection.saveSelection()
                        taskModel.parseData()
                    }
                    .onChange(of: selection.selectedGroup) { _ in
                        selection.saveSelection()
                        taskModel.parseData()
                    }
                )
        }
    }

    func getCurrentDayText(_ weekday: Int) -> String {
        let calendar = Calendar.current
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) else {
            return ""
        }
        let startWeekday = calendar.component(.weekday, from: startOfWeek)
        guard let date = calendar.date(byAdding: .day, value: weekday - startWeekday, to: startOfWeek) else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }

    func getWeekdayName(_ weekday: Int) -> String {
        let calendar = Calendar.current
        let today = calendar.component(.weekday, from: Date())
        let daysToAdd = (weekday - today + 7) % 7
        guard let date = calendar.date(byAdding: .day, value: daysToAdd, to: Date()) else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: date)
    }
}


struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
