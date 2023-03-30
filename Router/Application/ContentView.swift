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
                VStack {
                    NavigationLink("Exercise", value: ViewType.Exercise)
                    NavigationLink("Routine", value: ViewType.Routine)
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
            Text("Hello World")
                .tabItem {
                    Image(systemName: "plus")
                    Text("hello")
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
