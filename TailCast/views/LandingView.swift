//
//  LandingView.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-09-06.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        Image("TailcastLanding")
            .resizable()
            .frame(width: 150, height: 150)
            .offset(y:-30)
    }
}

#Preview {
    LandingView()
}
