//
//  homeStatsView.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/30/25.
//

import SwiftUI

struct homeStatsView: View {
    
    @EnvironmentObject private var vm: homeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack{
            ForEach(vm.statistic){ stat in
                statisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3 )
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

struct homeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        homeStatsView(showPortfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
