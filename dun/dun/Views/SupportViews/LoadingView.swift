//
//  LoadingView.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import SwiftUI

struct LoadingView: View {
    @State private var isRotating = 0.0
    
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(.linear)
                .rotationEffect(.degrees(isRotating))
                .onAppear {
                    withAnimation(.linear(duration: 2)
                        .repeatForever(autoreverses: false)) {
                            isRotating = 360.0
                        }
                }
            ProgressView()
                .progressViewStyle(.linear)
                .rotationEffect(.degrees(isRotating))
                .onAppear {
                    withAnimation(.linear(duration: 2)
                        .repeatForever(autoreverses: false)) {
                            isRotating = 360.0
                        }
                }
            Text("Loading...")
                .font(.custom(TodoStrings.sfProRounded,
                              size: 20,
                              relativeTo: .title))
                .padding(.top, 150)
                .frame(width: TodoStrings.returnDesiredWidth(),
                       height: UIScreen.main.bounds.height / 20,
                       alignment: .center)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
