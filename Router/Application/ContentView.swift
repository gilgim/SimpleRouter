import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
				VStack {
					NavigationLink("Exercise") {
						ExerciseView()
					}
					NavigationLink("Routine") {
						RoutineView()
					}
				}
                .tabItem {
                    Image(systemName: "plus")
                    Text("work out")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
