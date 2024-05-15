import SwiftUI

struct SelectionView: View {
    @EnvironmentObject var selection: Selection
    @ObservedObject var taskModel: TaskModel

    var body: some View {
        ZStack {
            Color("CardColor")
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Text("Дневное отделение")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, 50)
                
                Text("Выберите курс и группу для своего получения расписания")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    .padding(.top, 20)
                

                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 256, height: 128)
                        .foregroundColor(Color("GroupSettings"))

                    VStack {
                        HStack(spacing: 3) {
                            Text("Выберите курс")
                                .foregroundColor(.white)
                                .bold()
                            
                            Picker("Курс", selection: $selection.selectedCourse) {
                                Text("1").tag(1)
                                Text("2").tag(2)
                                Text("3").tag(3)
                                Text("4").tag(4)
                            }
                            .pickerStyle(MenuPickerStyle())
                            .onChange(of: selection.selectedCourse) { newValue in
                                selection.selectedCourse = newValue
                                updateSelection()
                            }
                        }
                        .accentColor(.white)
                        
                        HStack(spacing: 3) {
                            Text("Выберите группу")
                                .foregroundColor(.white)
                                .bold()
                            
                            Picker("Группа", selection: $selection.selectedGroup) {
                                ForEach(selection.availableGroups, id: \.self) { group in
                                    Text(group).tag(group)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .onChange(of: selection.selectedGroup) { newValue in
                                selection.selectedGroup = newValue
                                updateSelection()
                            }
                        }
                        .accentColor(.white)
                    }
                }
                
                Spacer()
                Spacer()
            }
        }
    }
    private func updateSelection() {
        taskModel.selection = selection
        taskModel.parseData()
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        let selection = Selection()
        let taskModel = TaskModel(selection: selection)
        return SelectionView(taskModel: taskModel)
            .environmentObject(selection)
            .environmentObject(taskModel)
    }
}
