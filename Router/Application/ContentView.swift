import SwiftUI
import RealmSwift
enum ViewType {
    case Exercise, Routine
}
struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
				VStack {
                    NavigationLink("Exercise", value: ViewType.Exercise)
                    NavigationLink("Routine", value: ViewType.Routine)
				}
                .tabItem {
                    Image(systemName: "plus")
                    Text("work out")
                }
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
