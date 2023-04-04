import SwiftUI
import RealmSwift
import Combine

struct ContentView: View {
    
    enum ViewType {
        case Exercise, Routine
    }
    var body: some View {
        TabView {
            NavigationStack {
                ZStack {
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                RoundedRectangle(cornerRadius: 13)
                                    .frame(width: UIScreen.main.bounds.width-48)
                                RoundedRectangle(cornerRadius: 13)
                                    .frame(width: UIScreen.main.bounds.width-48)
                                RoundedRectangle(cornerRadius: 13)
                                    .frame(width: UIScreen.main.bounds.width-48)
                            }
                            .foregroundColor(.gray)
                            .padding(.horizontal, 12)
                        }
                        .padding(.top, 100)
                        .padding(.bottom, 400)
                    }
                    VStack {
                        NavigationLink(value: ViewType.Routine) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 13)
                                Text("루틴 만들기")
                                    .foregroundColor(.white)
                            }
                        }
                        NavigationLink(value: ViewType.Exercise) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 13)
                                Text("운동 만들기")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.top, 500)
                    .padding(.bottom, 60)
                    .padding(.horizontal, 24)
                }
                .navigationDestination(for: ViewType.self) {
                    switch $0 {
                    case .Exercise:
                        ExerciseView()
                    case .Routine:
                        RoutineView()
                    }
                }
            }
            .tabItem {
                Image(systemName: "plus")
                Text("work out")
            }
        }
        .onAppear() {
            print("Realm URL : \(Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? "nothing")")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
