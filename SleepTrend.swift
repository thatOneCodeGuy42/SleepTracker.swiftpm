import SwiftUI
import Charts

struct SleepData: Identifiable {
    let id = UUID()
    let date: Date
    let hours: Double
}

struct SleepTrendView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var sleepLogViewModel: SleepLog.SleepLogViewModel
    @State var showInfo = false
    @State var animateChart = false
    
    var sleepData: [SleepData] {
        let sortedEntries = sleepLogViewModel.entries.sorted { $0.startDate > $1.startDate }
        let latestEntries = Array(sortedEntries.prefix(7))
        return latestEntries.map { entry in
            let duration = entry.endDate.timeIntervalSince(entry.startDate)
            let hoursSlept = abs(duration / 3600)
            return SleepData(date: entry.startDate, hours: hoursSlept)
        }.sorted { $0.date < $1.date }
    }
    
    var averageSleep: Double {
        guard !sleepData.isEmpty else { return 0 }
        return sleepData.map { $0.hours }.reduce(0, +) / Double(sleepData.count)
    }
    
    var totalSleep: Double {
        sleepData.map { $0.hours }.reduce(0, +)
    }
    
    var bestNight: SleepData? {
        sleepData.max(by: { $0.hours < $1.hours })
    }
    
    var worstNight: SleepData? {
        sleepData.min(by: { $0.hours < $1.hours })
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.051, green: 0.106, blue: 0.165)
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 350, height: 100)
                        .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                        .overlay {
                            Text("Sleep Trend")
                                .font(.custom("American Typewriter", size: 50))
                                .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                        }
                        .padding(.bottom, 60)
                    
                    Chart {
                        ForEach(Array(sleepData.enumerated()), id: \.1.id) { index, data in
                            let displayIndex = sleepData.count - index
                            BarMark(
                                x: .value("Entry", "\(displayIndex)"),
                                y: .value("Hours", animateChart ? data.hours : 0)
                            )
                            .foregroundStyle(Gradient(colors: [.purple.opacity(0.4), .purple]))
//                            .animation(.easeOut(duration: 0.6), value: animateChart)
                        }
                        
                        RuleMark(y: .value("Ideal", 8))
                            .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundStyle(.red)
                            .annotation(position: .top, alignment: .leading) {
                                Text("Target: 8 hrs")
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                    }
                    .frame(height: 300)
                    .padding()
                    .onAppear {
                        withAnimation {
                            animateChart = true
                        }
                    }
                    
                    Button {
                        showInfo = true
                    } label: {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 100, height: 30)
                            .foregroundStyle(Color(red: 0.424, green: 0.478, blue: 0.537))
                            .overlay {
                                Text("More Info")
                                    .foregroundStyle(Color(red: 0.788, green: 0.839, blue: 0.875))
                            }
                    }
                    .padding(.top, 100)
                }
                .padding()
            }
            
            if showInfo {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {}
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Sleep Summary")
                        .font(.headline)
                    
                    Text(String(format: "🛏 Total Sleep: %.1f hours", totalSleep))
                    Text(String(format: "📊 Average: %.1f hrs/night", averageSleep))
                    
                    if let best = bestNight {
                        Text("🌟 Best Night: \(formattedDate(best.date)) – \(String(format: "%.1f", best.hours)) hrs")
                    }
                    
                    if let worst = worstNight {
                        Text("😴 Worst Night: \(formattedDate(worst.date)) – \(String(format: "%.1f", worst.hours)) hrs")
                    }
                    
                    Text("🔴 The red dashed line on the chart shows the ideal goal of 8 hours of sleep.")
                    
                    Button {
                        showInfo = false
                    } label: {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 65, height: 30)
                            .foregroundStyle(Color(red: 0.424, green: 0.478, blue: 0.537))
                            .overlay {
                                Text("Close")
                                    .foregroundStyle(Color(red: 0.788, green: 0.839, blue: 0.875))
                            }
                    }
                    .padding(.top, 10)
                }
                .padding()
                .frame(maxWidth: 300)
                .background(.white)
                .cornerRadius(16)
                .shadow(radius: 10)
            }
        }
        .animation(.easeInOut, value: showInfo)
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date)
    }
}


