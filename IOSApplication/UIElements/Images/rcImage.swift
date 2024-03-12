//
//  rcImage.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 3/12/24.
//

import SwiftUI

struct rcImage: View {
    
    var imagePath: String
    var maxWidth: CGFloat? = .greatestFiniteMagnitude
    var maxHeight: CGFloat? = .greatestFiniteMagnitude
    var width: CGFloat?
    var height: CGFloat?
    var isCornersRounded: Bool = false
    var cornerRadius: CGFloat = 8.0 // Default corner radius

    var body: some View {
        Image(imagePath)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height)
            .frame(maxWidth: maxWidth, maxHeight: maxHeight)
            .cornerRadius(isCornersRounded ? cornerRadius : 0.0)
    }
}

