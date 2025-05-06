//
//  LoadingView.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import SwiftUI

struct ErrorView: View {
    @Binding var isPresented: Bool
    @Environment(\.dismiss) var dismiss
    
    var errorTitle: String?
    var errorDescription: String?
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "exclamationmark.circle.fill")
                .resizable()
                .frame(width: 95.0, height: 95.0)
                .foregroundColor(.red)
            Text(self.errorTitle ?? "0000")
                .font(.custom(TodoStrings.sfProRounded,
                              size: 20,
                              relativeTo: .title))
                .padding(.top, 20)
                .frame(alignment: .center)
                .frame(width: TodoStrings.returnDesiredWidth() - 5,
                       alignment: .top)
            Text(self.errorDescription ?? TodoStrings.generalUnknownError)
                .font(.custom(TodoStrings.sfProRounded,
                              size: 15,
                              relativeTo: .title))
                .frame(alignment: .center)
                .frame(width: TodoStrings.returnDesiredWidth() - 5,
                       height: UIScreen.main.bounds.height / 3,
                       alignment: .top)
        }
        .frame(height: UIScreen.main.bounds.height)
        .onTapGesture {
            dismiss()
        }
    }
}


#Preview {
    struct Preview: View {
            @State var bool = true
            var body: some View {
                ErrorView(isPresented: $bool)
            }
        }

        return Preview()
}

/// [Sizwe K.] - Removing the last digit of the API KEY (Plist) triggers this view
/// [Sizwe K.] - Location Services Prompt & Disabling them allows this
