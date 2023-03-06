//
//  WorkOutView.swift
//  Router
//
//  Created by Gaea on 2023/03/06.
//

import SwiftUI

struct WorkOutView: View {
    @StateObject var vm = WorkOutViewModel()
    @Binding var routineName: String
    var body: some View {
        VStack {
            
        }
        .onAppear() {
            self.vm.routineName = self.routineName
        }
        .navigationTitle("\(self.vm.routineName)")
    }
}

struct WorkOutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkOutView(routineName: .constant(""))
    }
}
