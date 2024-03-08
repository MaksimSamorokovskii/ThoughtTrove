//
//  BackgroundColorView.swift
//  ThoughtTrove
//
//  Created by Максим Самороковский on 08.03.2024.
//

import SwiftUI

struct BackgroundColorView: View {
    var body: some View {
        LinearGradient(colors: [.black, .indigo], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundColorView()
}
