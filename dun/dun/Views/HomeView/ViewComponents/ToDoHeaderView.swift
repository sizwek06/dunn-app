//
//  ToDoHeaderView.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/05.
//

import SwiftUICore
import UIKit

extension TodoView {
    func createHeader(title: String, isTodo: Bool = false) -> some View {
        HStack() {
            Text(title)
                .font(.custom(TodoStrings.sfProRounded,
                              size: dynamicHeaderSize,
                              relativeTo: .title))
                .frame(width: TodoStrings.returnDesiredWidth() - (isTodo ? 90 : 50),
                       height: UIScreen.main.bounds.height / 3,
                       alignment: .leading)
            if isTodo {
                Image(systemName: "plus.square.on.square")
                    .resizable()
                    .foregroundColor(.accentColor)
                    .frame(width: 20, height: 20)
                    .padding(.vertical)
                    .onTapGesture {
                        showAdd.toggle()
                    }
            }
        }
        .frame(width: 325, height: 50, alignment: .leading)
        .sheet(isPresented: $showAdd) {
            AddToDoView()
                .presentationDetents([.height(200)])
        }
    }
}
