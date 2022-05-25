//
//  DayView.swift
//
//
//  Created by Florin Pop on 08.07.20.
//

import SwiftUI

struct DayView: View {
    let date: Date

    var textColor: Color {
        self.date.isToday() ? .todayForeground : .textForeground
    }

    var backgroundColor: Color {
        self.date.isToday() ? .todayBackground : .textBackground
    }

    var body: some View {
        Text(date.formatDayOfMonth())
            .foregroundColor(textColor)
            .fitWidthInCalendarCell()
            .background(backgroundColor)
            .cornerRadius(.cellWidth / 2)
            .fitWidthInCalendarCell()
            .fitHeightInCalendarCell()
    }
}
