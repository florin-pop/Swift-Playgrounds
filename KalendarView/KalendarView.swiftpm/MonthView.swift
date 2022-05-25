//
//  MonthView.swift
//
//
//  Created by Florin Pop on 07.07.20.
//

import SwiftUI

struct MonthView<Accessory: View>: View {
    let month: Date
    let accessoryBuilder: (_ date: Date) -> Accessory
    var selection: KalendarSelection

    init(month: Date, selection: KalendarSelection, @ViewBuilder accessoryBuilder: @escaping (_ date: Date) -> Accessory) {
        self.month = month
        self.selection = selection
        self.accessoryBuilder = accessoryBuilder
    }

    var weeks: [[Date]] {
        self.month.weeksInMonth()
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(weeks[0], id: \.self) { column in
                    HStack {
                        Spacer()
                        Text(column.isBeginningOfMonth() ? column.formatMonth() : "").fitWidthInCalendarCell()
                        Spacer()
                    }
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
            ForEach(weeks, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { column in
                        HStack {
                            Spacer()
                            if self.month.isSameMonth(as: column) {
                                VStack(alignment: .center, spacing: 0) {
                                    DayView(date: column)
                                    self.accessoryBuilder(column)
                                }.onTapGesture { self.onDayTapped(date: column) }
                            } else {
                                EmptyView()
                            }
                            Spacer()
                        }
                    }
                }
            }
        }.frame(minWidth: 0, maxWidth: .infinity)
    }

    private func onDayTapped(date: Date) {
        if self.selection.date != date {
            self.selection.date = date
        }
    }
}

extension MonthView where Accessory == EmptyView {
    init(month: Date, selection: KalendarSelection) {
        self.month = month
        self.selection = selection
        self.accessoryBuilder = { _ in EmptyView() }
    }

    func buildContent<Accessory: View>(@ViewBuilder content: () -> Accessory) -> MonthView<EmptyView> {
        MonthView<EmptyView>(month: self.month, selection: self.selection) { _ in
            EmptyView()
        }
    }
}
