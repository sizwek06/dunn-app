//
//  TodoCardView.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/04.
//

import SwiftUICore

extension TodoView {
    struct makeTodoListCard: View {
        
        var item: ToDoItems
        @ScaledMetric(relativeTo: .body) var dynamicTextSize = 11
        
        var body: some View {
            HStack(alignment: .center) {
                Image(systemName: item.isCompleted != "todo" ? "checkmark.circle.fill" : "circle")
                    .padding(.leading, 5)
                    .foregroundColor(.gray)
                    .frame(width: dynamicTextSize,
                           height: dynamicTextSize,
                           alignment: .center)
                createTodoTitle(item: item)
                Spacer()
                Image(systemName: item.isCompleted != "todo" ? "trash.circle.fill" : "trash.circle")
                    .foregroundColor(.red)
                    .frame(width: TodoStrings.returnDesiredWidth() / 14,
                           height: TodoStrings.returnDesiredWidth() / 14,
                           alignment: .center)
            }
            .clipShape(RoundedRectangle(cornerRadius: 24.0))
            .padding(.horizontal, 10)
            .padding(.leading, 10)
            .frame(width: 300, height: 55, alignment: .leading)
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(item.isCompleted != "todo" ? .gray : .black,
                            lineWidth: 1)
            }
        }
    }
    
    struct createTodoTitle: View {
        
        var item: ToDoItems
        @ScaledMetric(relativeTo: .body) var dynamicTextSize = 13
        
        var body: some View {
            HStack() {
                Text("\(String(describing: item.itemTitle)): \(item.itemDescription)")
                    .font(.custom(TodoStrings.sfProBold,
                                  size: dynamicTextSize))
                    .strikethrough(item.isCompleted != "todo")
                    .foregroundColor(item.returnTitleColor)
                    .padding(.leading, 5)
            }
        }
    }
}
