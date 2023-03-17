import SwiftUI
import RealmSwift
import Combine

class MainViewModel: ObservableObject {
    var cancelables = Set<AnyCancellable>()
}
struct ContentView: View {
    
    enum ViewType {
        case Exercise, Routine
    }
    static var customAlertPublisher = PassthroughSubject<Bool, Never>()
    @State var isCustomAlert = false
    
    @State var alertTitle = "생성"
    @State var rightText = ""
    @State var rightPlaceHolder: String = "세트"
    @State var leftText = ""
    @State var leftPlaceHolder: String = "휴식"
    
    @StateObject var vm = MainViewModel()
    var body: some View {
        ZStack {
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
            if isCustomAlert {
                Color.black.opacity(0.3).ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            self.isCustomAlert = false
                        }
                    }
                ZStack {
                    HStack {
                        TextField(rightPlaceHolder, text: $rightText)
                        Image(systemName: "poweron")
                            .resizable()
                            .scaledToFit()
                        TextField(leftPlaceHolder, text: $leftText)
                    }
                }
                .background(content: {
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(.white)
                })
                .padding(.vertical,50)
                .padding(.horizontal, 25)
            }
        }
        .onAppear() {
            print("Realm URL : \(Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? "nothing")")
            ContentView.customAlertPublisher.sink { value in
                isCustomAlert = value
            }
            .store(in: &vm.cancelables)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
