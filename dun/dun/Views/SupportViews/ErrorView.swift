//
//  LoadingView.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var viewModel = ErrorViewModel()
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "exclamationmark.circle.fill")
                .resizable()
                .frame(width: 90.0, height: 90.0)
                .foregroundColor(.red)
            Text(self.viewModel.errorCode ?? "0000")
                .font(.custom(TodoStrings.sfProRounded,
                              size: 20,
                              relativeTo: .title))
                .padding(.top, 20)
                .frame(alignment: .center)
                .frame(width: TodoStrings.returnDesiredWidth() - 10,
                       alignment: .top)
            Text(self.viewModel.errorDescription ?? TodoStrings.generalUnknownError)
                .font(.custom(TodoStrings.sfProRounded,
                              size: 15,
                              relativeTo: .title))
                .frame(alignment: .center)
                .frame(width: TodoStrings.returnDesiredWidth() - 10,
                       height: UIScreen.main.bounds.height / 3,
                       alignment: .top)
        }
        .frame(height: UIScreen.main.bounds.height)
        .onTapGesture {
            viewModel.state = .loading
        }
    }
}

#Preview {
    struct Preview: View {
            @State var bool = true
            var body: some View {
                ErrorView(viewModel: ErrorViewModel(),
                          isPresented: $bool)
            }
        }

        return Preview()
}

/// [Sizwe K.] - Removing the last digit of the API KEY (Plist) triggers this view
