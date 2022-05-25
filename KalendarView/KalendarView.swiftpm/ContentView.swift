import SwiftUI

struct ContentView: View {
    private static let emojis = Array(0x1F300...0x1F3F0)
    @ObservedObject var selection = KalendarSelection()
    private var fromDate: Date = Date().addingTimeInterval(-60*60*24*365)
    private var toDate: Date = Date().addingTimeInterval(60*60*24*14*5)
    @State private var showEmoji: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: .none) {
            Button("Toggle Emoji") {
                showEmoji.toggle()
            }.padding()
            KalendarView(fromDate: fromDate, toDate: toDate, scrollToBottom: true, selection: self.selection) { date in
                if showEmoji {
                    Text(String(UnicodeScalar(ContentView.emojis[ Int(date.timeIntervalSinceReferenceDate) % ContentView.emojis.count])!)).font(.title)
                }
            }
            Text(getTextFromDate(date: self.selection.date))
        }
    }
    
    func getTextFromDate(date: Date?) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return date == nil ? "No Selection" : "Selection: " + formatter.string(from: date!)
    }
}
