//
//  PixelTitleView.swift
//  Chakras
//
//  Created by Pierre Untas on 09/11/2024.
//

import SwiftUI

struct PixelTitleView: View {
    let pixelSize: CGFloat = 2
    // Tableau représentant "HELLO WORLD" en style pixel art
    let colors: [[Color]] = [
        [.clear, .white, .clear, .white, .clear, .white, .white, .white, .clear, .white, .clear, .clear, .clear, .white, .clear, .clear, .clear, .white, .white, .white, .clear, .clear, .clear, .white, .clear, .white, .clear, .white, .white, .white, .clear, .white, .white, .white, .clear, .white, .clear, .clear, .clear, .white, .white, .clear, .clear, .clear, .clear, .white, .clear],
        [.clear, .white, .clear, .white, .clear, .white, .clear, .clear, .clear, .white, .clear, .clear, .clear, .white, .clear, .clear, .clear, .white, .clear, .white, .clear, .clear, .clear, .white, .clear, .white, .clear, .white, .clear, .white, .clear, .white, .clear, .white, .clear, .white, .clear, .clear, .clear, .white, .clear, .white, .clear, .clear, .clear, .white, .clear],
        [.clear, .white, .white, .white, .clear, .white, .white, .clear, .clear, .white, .clear, .clear, .clear, .white, .clear, .clear, .clear, .white, .clear, .white, .clear, .clear, .clear, .white, .white, .white, .clear, .white, .clear, .white, .clear, .white, .white, .white, .clear, .white, .clear, .clear, .clear, .white, .clear, .white, .clear, .clear, .clear, .white, .clear],
        [.clear, .white, .clear, .white, .clear, .white, .clear, .clear, .clear, .white, .clear, .clear, .clear, .white, .clear, .clear, .clear, .white, .clear, .white, .clear, .clear, .clear, .white, .white, .white, .clear, .white, .clear, .white, .clear, .white, .white, .clear, .clear, .white, .clear, .clear, .clear, .white, .clear, .white, .clear, .clear, .clear, .clear, .clear],
        [.clear, .white, .clear, .white, .clear, .white, .white, .white, .clear, .white, .white, .white, .clear, .white, .white, .white, .clear, .white, .white, .white, .clear, .clear, .clear, .white, .clear, .white, .clear, .white, .white, .white, .clear, .white, .clear, .white, .clear, .white, .white, .white, .clear, .white, .white, .clear, .clear, .clear, .clear, .white, .clear],
    ]
    
    var body: some View {
        VStack(spacing: 0.5) {
            ForEach(0..<colors.count) { row in
                HStack(spacing: 0.5) {
                    ForEach(0..<colors[row].count) { col in
                        Rectangle()
                            .fill(colors[row][col])
                            .frame(width: pixelSize, height: pixelSize)
                    }
                }
            }
        }
        .padding()
    }
}
