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
        SleepData(day: "Fri", hours: 4.5)
    ]
    
    var averageSleep: Double {
        guard !sleepData.isEmpty else { return 0 }
        return sleepData.map { $0.hours }.reduce(0, +) / Double(sleepData.count)
    }
    
    var body: some View {
        VStack {
            Text("Sleep Trend")
                .font(.title)
                .bold()
                .padding(.top)
            
            if sleepData.isEmpty {
                Text("No sleep data available.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                Chart {
                    ForEach(sleepData) { data in
                        BarMark(
                            x: .value("Day", data.day),
                            y: .value("Hours", data.hours)
                        )
                        .foregroundStyle(.purple)
                    }
                }
                .frame(height: 300)
                .padding()
                
                Text(String(format: "Average sleep: %.1f hours", averageSleep))
                    .font(.headline)
                    .padding(.bottom)
            }
            
            Button("Back to Home") {
                dismiss()
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

