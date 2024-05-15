import Foundation
import SwiftSoup

struct Task: Identifiable, Hashable {
    let id = UUID()
    let timeStart: String
    let timeEnd: String
    let subject: String
    let room: String
    let week: String
    let type: String

    func getWeekday() -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // формат даты
        dateFormatter.locale = Locale(identifier: "ru_RU") // устанавливаем локаль
        if let date = dateFormatter.date(from: timeStart) {
            let calendar = Calendar.current
            return calendar.component(.weekday, from: date)
        }
        return nil
    }
}

class TaskModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var isLoading = false
    @Published var error: Error? = nil

    var selection: Selection

    init(selection: Selection) {
        self.selection = selection
    }

//    func parseData() {
//        isLoading = true
//
//        let urlMain = "https://mmf.bsu.by/ru/raspisanie-zanyatij/dnevnoe-otdelenie/"
//        let urlCourse = "\(selection.selectedCourse)-kurs/"
//        var urlGroup = ""
//
//        if selection.selectedGroup == "ВФ" {
//            urlGroup = "vf/"
//        } else {
//            urlGroup = "\(selection.selectedGroup)-gruppa/"
//        }
//
//        let fullURL = urlMain + urlCourse + urlGroup
//
//        guard let url = URL(string: fullURL) else {
//            isLoading = false
//            error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
//            guard let self = self else { return }
//
//            DispatchQueue.main.async {
//                self.isLoading = false
//
//                if let error = error {
//                    self.error = error
//                    return
//                }
//
//                guard let data = data else {
//                    self.error = NSError(domain: "Data is nil", code: 0, userInfo: nil)
//                    return
//                }
//
//                do {
//                    let htmlString = String(data: data, encoding: .utf8)
//                    let doc = try SwiftSoup.parse(htmlString ?? "")
//                    let tableRows = try doc.select("table tr")
//
//                    var parsedTasks: [Task] = []
//
//                    for row in tableRows {
//                        let columns = try row.select("td")
//                        guard columns.size() >= 6 else { continue }
//
//                        let timeStart = try columns[0].text()
//                        let timeEnd = try columns[1].text()
//                        let week = try columns[2].text()
//                        let subject = try columns[3].text()
//                        let type = try columns[4].text()
//                        let room = try columns[5].text()
//
//                        let task = Task(timeStart: timeStart, timeEnd: timeEnd, subject: subject, room: room, week: week, type: type)
//                        parsedTasks.append(task)
//                    }
//
//                    self.tasks = parsedTasks
//                } catch {
//                    self.error = error
//                }
//            }
//        }
//
//        task.resume()
//    }
    func parseData() {
        isLoading = true

        let urlMain = "https://mmf.bsu.by/ru/raspisanie-zanyatij/dnevnoe-otdelenie/"
        let urlCourse = "\(selection.selectedCourse)-kurs/"
        var urlGroup = ""

        if selection.selectedGroup == "ВФ" {
            urlGroup = "vf/"
        } else {
            urlGroup = "\(selection.selectedGroup)-gruppa/"
        }

        let fullURL = urlMain + urlCourse + urlGroup
        print("URL для загрузки данных: \(fullURL)")  // Логирование URL

        guard let url = URL(string: fullURL) else {
            isLoading = false
            error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.isLoading = false

                if let error = error {
                    self.error = error
                    return
                }

                guard let data = data else {
                    self.error = NSError(domain: "Data is nil", code: 0, userInfo: nil)
                    return
                }

                do {
                    let htmlString = String(data: data, encoding: .utf8)
                    let doc = try SwiftSoup.parse(htmlString ?? "")
                    let tableRows = try doc.select("table tr")

                    var parsedTasks: [Task] = []

                    for row in tableRows {
                        let columns = try row.select("td")
                        guard columns.size() >= 6 else { continue }

                        let timeStart = try columns[0].text()
                        let timeEnd = try columns[1].text()
                        let week = try columns[2].text()
                        let subject = try columns[3].text()
                        let type = try columns[4].text()
                        let room = try columns[5].text()

                        let task = Task(timeStart: timeStart, timeEnd: timeEnd, subject: subject, room: room, week: week, type: type)
                        parsedTasks.append(task)
                    }

                    print("Получено занятий: \(parsedTasks.count)") // Логирование количества полученных заданий

                    self.tasks = parsedTasks
                } catch {
                    self.error = error
                }
            }
        }
        task.resume()
    }
}
