//
//  statisticView.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/30/25.
//

import SwiftUI

struct statisticView: View {
    
    let stat: statisticModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            
            HStack{
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                Text(stat.percentageChange?.asPercentageString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle((stat.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

struct statisticView_Previews: PreviewProvider {
    static var previews: some View {
        statisticView(stat: dev.stat1)
    }
}
