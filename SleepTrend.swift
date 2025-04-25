//
//  SleepTrend.swift
//  SleepTracker
//
//  Created by Abhi Sorathiya on 4/14/25.
//

import SwiftUI
import Charts

struct SleepData: Identifiable {
    let id = UUID()
    let day: String
    let hours: Double
}

struct SleepTrendView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var sleepLogViewModel: SleepLog.SleepLogViewModel
    @State var showInfo = false

    var sleepData: [SleepData] {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE" // Short weekday name

        var dailySleep: [String: Double] = [:]

        for entry in sleepLogViewModel.entries {
            let duration = entry.endDate.timeIntervalSince(entry.startDate)
            let hoursSlept = duration / 3600
            let weekday = dateFormatter.string(from: entry.startDate)
            dailySleep[weekday, default: 0] += hoursSlept
        }

        let orderedDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        return orderedDays.map { day in
            SleepData(day: day, hours: dailySleep[day] ?? 0)
        }
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
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 60, trailing: 0))

                    Chart {
                        ForEach(sleepData) { data in
                            BarMark(
                                x: .value("Day", data.day),
                                y: .value("Hours", data.hours)
                            )
                            .foregroundStyle(Gradient(colors: [.purple.opacity(0.4), .purple]))
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
                    .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0))

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
                        Text("🌟 Best Night: \(best.day) – \(String(format: "%.1f", best.hours)) hrs")
                    }

                    if let worst = worstNight {
                        Text("😴 Worst Night: \(worst.day) – \(String(format: "%.1f", worst.hours)) hrs")
                    }

                    Text("🔴 The red dashed line on the chart shows the ideal goal of 8 hours of sleep.")

                    Button {
                        showInfo = false
                    } label: {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 65, height: 30)
                            .foregroundStyle(Color(red: 0.424, green: 0.478, blue: 0.537))
                            .padding(EdgeInsets(top: 0, leading: 90, bottom: 0, trailing: 0))
                            .overlay {
                                Text("Close")
                                    .foregroundStyle(Color(red: 0.788, green: 0.839, blue: 0.875))
                                    .padding(EdgeInsets(top: 0, leading: 90, bottom: 0, trailing: 0))
                            }
                    }
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
}
