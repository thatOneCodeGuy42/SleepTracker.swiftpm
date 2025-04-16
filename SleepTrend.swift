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

    @State var sleepData: [SleepData] = [
        SleepData(day: "Mon", hours: 6),
        SleepData(day: "Tue", hours: 7.5),
        SleepData(day: "Wed", hours: 5),
        SleepData(day: "Thu", hours: 8),
        SleepData(day: "Fri", hours: 4.5),
        SleepData(day: "Sat", hours: 9),
        SleepData(day: "Sun", hours: 6.5)
    ]

    @State var showInfo = false

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
            ScrollView {
                VStack(spacing: 20) {
                    Text("Sleep Trend")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)

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

                    Button("More Info") {
                        showInfo = true
                    }
                    .buttonStyle(.bordered)

                    Button("Back to Home") {
                        dismiss()
                    }
                    .padding(.bottom)
                    .buttonStyle(.borderedProminent)
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

                    Button("Close") {
                        showInfo = false
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
                    .buttonStyle(.borderedProminent)
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


