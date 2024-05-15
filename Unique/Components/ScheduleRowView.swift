import SwiftUI
import SwiftSoup

struct ScheduleRowView: View {
    var task: Task

    var body: some View {
        HStack(alignment: .top, spacing: 25) {
            HStack(spacing: 8) {
                VStack {
                    Text(task.timeEnd)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                    Text("Понедельник")
                        .font(.system(size: 14))
                        .foregroundColor(.white)

                    Spacer()
                }

                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 2)
            }
            
            VStack {
                HStack(alignment: .top, spacing: 5) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(task.subject)
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                        
                        if task.room == "" {
                            
                        } else {
                            HStack {
                                Image(systemName: "location.square.fill")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 12, height: 12)
                                
                                Text(task.room)
                                    .font(.system(size: 13))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        HStack {
                            if task.week == "" {
                                
                            } else if task.week == "а" || task.week == "б" {
                                HStack {
                                    Image(systemName: "person.3.sequence.fill")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 18, height: 9)
                                    
                                    Text("\(task.week)")
                                        .font(.system(size: 15))
                                        .foregroundColor(.white)
                                }
                            } else {
                                HStack {
                                    Image(systemName: "studentdesk")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 12, height: 11)
                                    
                                    Text(task.week)
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        
                        if task.type == "" {
                            
                        } else {
                            HStack {
                                Image(systemName: "calendar")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 12, height: 11)
                                
                                Text(task.type)
                                    .font(.system(size: 13))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Spacer()

                    }
                    .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("CardColor"), Color("CardColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .cornerRadius(20)
            )
        }
    }
}

struct ScheduleRowView_Previews: PreviewProvider {
    static var previews: some View {
        let task = Task(timeStart: "", timeEnd: "11:05 - 12:35", subject: "КМиСО", room: "419", week: "а", type: "п")
        ScheduleRowView(task: task)
    }
}
