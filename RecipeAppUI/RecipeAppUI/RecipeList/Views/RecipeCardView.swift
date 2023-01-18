//
//  RecipeCardView.swift
//  RecipeAppUI
//
//  Created by Jorge Menco on 1/17/23.
//

import Foundation
import SwiftUI

struct RecipeCardView: View {
    
    var image: URL?
    var title: String
    var identifier: String
    
    var body: some View {
        HStack(alignment: .center) {
            
            AsyncImage(url: image) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100)
                    .clipShape(Circle())
                
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 22, weight: .bold, design: .default))
                    .foregroundColor(.black)
                HStack {
                    Text(identifier)
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.black)
                        .padding(.top, 8)
                }
            }.padding(.trailing, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.all, 10)
    }
}
