import Foundation

class Selection: ObservableObject {
    @Published var selectedCourse: Int
    @Published var selectedGroup: String
    @Published var availableGroups: [String]

    private let selectedCourseKey = "SelectedCourse"
    private let selectedGroupKey = "SelectedGroup"
    
    init() {
        selectedCourse = 1
        selectedGroup = "1"
        availableGroups = []

        availableGroups = getAvailableGroups(for: selectedCourse) // Перемещаем инициализацию сюда
    }
    
    func saveSelection() {
        UserDefaults.standard.set(selectedCourse, forKey: selectedCourseKey)
        UserDefaults.standard.set(selectedGroup, forKey: selectedGroupKey)
    }

    func loadSelection() {
        selectedCourse = UserDefaults.standard.integer(forKey: selectedCourseKey)
        selectedGroup = UserDefaults.standard.string(forKey: selectedGroupKey) ?? ""
    }

    func getAvailableGroups(for course: Int) -> [String] {
        switch course {
        case 1:
            return ["1", "2", "3", "4", "5", "6", "7", "8", "9", "ВФ"]
        case 2:
            return ["1", "2", "3", "4", "5", "6", "7", "8", "9", "ВФ"]
        case 3:
            return ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "ВФ"]
        case 4:
            return ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "ВФ"]
        default:
            return []
        }
    }
}
