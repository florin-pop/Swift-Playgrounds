//
//  KalendarTitleView.swift
//
//
//  Created by Florin Pop on 08.07.20.
//

import SwiftUI

struct KalendarTitleView: View {
    @Binding var title: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title).padding()
            HStack(alignment: .bottom) {
                ForEach(DateFormatter.weekdaySymbols, id: \.self) { weekday in
                    HStack {
                        Spacer()
                        Text(weekday).fitWidthInCalendarCell()
                        Spacer()
                    }
                }
            }
        }
    }
}
