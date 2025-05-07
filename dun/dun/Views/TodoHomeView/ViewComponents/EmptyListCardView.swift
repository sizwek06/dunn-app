//
//  TodoCardView.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/04.
//

import SwiftUICore

extension TodoView {
    struct makeEmptyTodoListCard: View {
        @ScaledMetric(relativeTo: .body) var dynamicTextSize = 12
        
        var body: some View {
            HStack(alignment: .center) {
                Text("You have no To Do Items in this list, Get Stared!")
                    .font(.custom(TodoStrings.sfProRounded,
                                  size: dynamicTextSize))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 10)
            .padding(.leading, 10)
            .frame(width: 300, height: 55, alignment: .leading)
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.black,
                            lineWidth: 1)
            }
            
        }
    }
}
