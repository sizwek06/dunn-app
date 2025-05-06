//
//  ToDoHeaderView.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/05.
//

import SwiftUICore
import UIKit
import SwiftUI

extension TodoView {
    func createHeader(currentSection: HeaderDetails) -> some View {
        HStack() {
            Text(currentSection.text)
                .font(.custom(TodoStrings.sfProRounded,
                              size: dynamicHeaderSize,
                              relativeTo: .title))
                .frame(width: TodoStrings.returnDesiredWidth() - (currentSection == .todo ? 90 : 50),
                       height: UIScreen.main.bounds.height / 3,
                       alignment: .leading)
            if currentSection == .todo {
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
        .frame(width: 325, height: 30, alignment: .leading)
        .sheet(isPresented: $showAdd) {
            AddToDoView()
                .presentationDetents([.height(275)])
        }
    }
    
    enum HeaderDetails {
        case weather
        case todo
        case completed
        
        var text: String {
            switch self {
            case .todo: return TodoStrings.todoListTitle
            case .weather: return TodoStrings.weatherTitle
            case .completed: return TodoStrings.completedListTitle
            }
        }
        
        var width: CGFloat {
            switch self {
            case .todo: return 90
            default: return 50
            }
        }
    }
}
