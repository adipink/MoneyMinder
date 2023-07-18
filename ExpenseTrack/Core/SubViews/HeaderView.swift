//
//  HeaderView.swift
//  ExpenseTrack
//
//  Created by Kristina & Adi
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    let angle: Double
    let background: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(background))
                .rotationEffect(Angle(degrees: angle))
            VStack{
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
                    .bold()
                Text(subtitle)
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
            }
        }
        .frame(width: UIScreen.main.bounds.width,height: 200)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Title", subtitle: "Subtitle", angle: 15, background: "Green")
    }
}
