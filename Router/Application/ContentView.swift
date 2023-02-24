import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                NavigationLink("Exercise") {
                    ExerciseView()
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
