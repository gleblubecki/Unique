import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Color.white
                .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top)

            ScrollView {
                Image("mmf_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding(.top, 20)
                
                VStack {
                    Text("О приложении")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color("CardColor"))
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 350, height: 200)
                            .foregroundColor(Color("GroupSettings"))
                        
                        Text("Данное приложение создано студентом для студентов. В нем Вы сможете просматривать последние новости факультета, узнавать расписание и найти основную контактную информацию.")
                            .multilineTextAlignment(.center)
                            .frame(width: 270)
                            .foregroundColor(.white)
                            .padding(.horizontal, 5)
                            .padding(.top, 5)
                    }
                }
                .padding(.top, 15)
                .edgesIgnoringSafeArea(.all)
                
                
                VStack {
                    Text("Официальные сайты")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color("CardColor"))
                        .padding(.top, 15)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 350, height: 150)
                            .foregroundColor(Color("GroupSettings"))
                        
                        VStack {
                            Text("Сайт ММФ")
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("AboutText"))
                                .padding(.bottom, 1)
                            
                            Link("mmf.bsu.by", destination: URL(string: "https://mmf.bsu.by/ru/")!)   .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 15)
                            
                            Text("Сайт БГУ")
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("AboutText"))
                                .padding(.top, 3)
                                .padding(.bottom, 1)
                            
                            Link("bsu.by", destination: URL(string: "https://bsu.by")!)   .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 15)
                        }
                        .padding(.top, 15)
                    }
                }
                
                VStack {
                    Text("Instagram")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color("CardColor"))
                    
                    Link("Студ Союз МехМат БГУ", destination: URL(string: "https://www.instagram.com/mmf_bsu/")!)   .foregroundColor(Color("GroupSettings"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 15)
                        .padding(.top, 5)
                    
                    Link("Официальный аккаунт ММФ БГУ", destination: URL(string: "https://www.instagram.com/mmf.bsu/")!)   .foregroundColor(Color("GroupSettings"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 15)
                        .padding(.top, 5)
                    
                    Link("Официальный аккаунт БГУ", destination: URL(string: "https://www.instagram.com/official.bsu/")!)   .foregroundColor(Color("GroupSettings"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 15)
                        .padding(.top, 5)
                }
                .padding(.top, 15)
                
                VStack {
                    Text("Деканат")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color("CardColor"))
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 350, height: 150)
                            .foregroundColor(Color("GroupSettings"))
                        
                        VStack {
                            HStack {
                                Image(systemName: "phone.fill")
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color("AboutText"))
                                
                                Link("+375 (17) 209-50-46 (к. 426)", destination: URL(string: "tel:+375172095046")!)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.horizontal, 5)
                            .padding(.top, 5)
                            
                            HStack {
                                Image(systemName: "phone.fill")
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color("AboutText"))
                                
                                Link("+375 (17) 209-52-49 (к. 421)", destination: URL(string: "tel:+375172095249")!)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                
                            }
                            .padding(.horizontal, 5)
                            .padding(.top, 5)
                            
                            HStack {
                                Image(systemName: "phone.fill")
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color("AboutText"))
                                
                                Link("+375 (17) 209-53-91 (заоч/о)", destination: URL(string: "tel:+375172095391")!)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.horizontal, 15)
                            .padding(.top, 5)
                        }
                    }
                }
                .padding(.top, 15)
                
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
