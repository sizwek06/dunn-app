//
//  TodoCardView.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/04.
//

import SwiftUICore

extension TodoView {
    func makeTodoListCard(item: ToDoItem) -> some View {
        HStack() {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .padding(.leading, 5)
                .foregroundColor(returnColour(using: item.isCompleted))
                .frame(width: dynamicTextSize,
                       height: dynamicTextSize,
                       alignment: .center)
                .onTapGesture {
                    print("Complete OK")
                }
            createTodoTitle(item: item)
            Spacer()
            Image(systemName: item.isCompleted ? "trash.circle.fill" : "trash.circle")
                .foregroundColor(.red)
                .frame(width: TodoStrings.returnDesiredWidth() / 14,
                       height: TodoStrings.returnDesiredWidth() / 14,
                       alignment: .center)
                .onTapGesture {
                    print("Delete OK")
                }
        }
        .padding(.horizontal, 10)
        .frame(width: 325, height: 55, alignment: .leading)
        .overlay {
            RoundedRectangle(cornerRadius: 4)
                .stroke(item.isCompleted ? .gray : .blue,
                        lineWidth: 1)
        }
    }
    
    private func createTodoTitle(item: ToDoItem) -> some View {
        HStack() {
            
            Text("\(item.itemTitle):")
                .font(.custom(TodoStrings.sfProBold,
                              size: dynamicTextSize))
                .strikethrough(item.isCompleted)
                .foregroundColor(returnColour(using: item.isCompleted))
                .padding(.leading, 5)
            Text(item.itemDescription)
                .font(.custom(TodoStrings.sfProRegular,
                              size: dynamicTextSize))
                .strikethrough(item.isCompleted)
                .foregroundColor(returnColour(using: item.isCompleted))
        }
    }
    
    func returnColour(using isCompleted: Bool) -> Color {
        return isCompleted ? .gray : .appearanceColor
    }
}
