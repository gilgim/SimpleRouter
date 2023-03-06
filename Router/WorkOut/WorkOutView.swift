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
			Circle()
				.padding()
			Text("00:00")
			HStack {
				TextField("무게", text: $vm.weight)
					.multilineTextAlignment(.center)
				TextField("횟수", text: $vm.count)
					.multilineTextAlignment(.center)
			}
			Button("1세트 완료") {
				
			}
        }
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button("완료") {}
			}
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
