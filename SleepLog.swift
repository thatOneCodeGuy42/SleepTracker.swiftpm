//
//  AddNight.swift
//  SleepTracker
//
//  Created by Abhi Sorathiya on 4/16/25.
//


import SwiftUI

struct SleepEntry: Identifiable {
    let id = UUID()
    let name: String
    let notes: String
    let startDate: Date
    let endDate: Date
}

struct SleepLog: View {
//    @Published var entries: [SleepEntry] = []
    @StateObject var viewModel = SleepLogViewModel()
    @State var selectedEntry: SleepEntry?
    @State var showPopup = false

    enum SortingOption {
        case alphabeticalAZ
        case alphabeticalZA
        case dateOldNew
        case dateNewOld
        case mostHours
        case leastHours
    }
//
//    var sortedNights: [nights] {
//        switch SortingOption {
//        case .alphabeticalAZ:
//            return
//        case .alphabeticalZA:
//            return
//        case .dateNewOld:
//            return
//        case .dateOldNew:
//            return
//        case .mostHours:
//            return
//        case .leastHours:
//            return
//        }
//    }
//

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.051, green: 0.106, blue: 0.165)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 350, height: 100)
                        .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                        .overlay {
                            Text("Sleep Log")
                                .font(.custom("American Typewriter", size: 50))
                                .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                        }

                    NavigationLink(destination: CombinedSleepTrackerView(viewModel: viewModel)) {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 225, height: 50)
                            .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                            .overlay {
                                Text("Add Night")
                                    .font(.custom("American Typewriter", size: 30))
                                    .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                            }
                    }

                    List(viewModel.entries) { entry in
                        Button {
                            selectedEntry = entry
                            withAnimation {
                                showPopup = true
                            }
                        } label: {
                            Text(entry.name)
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear)
                }

                if let entry = selectedEntry, showPopup {
                    ZStack {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation {
                                    showPopup = false
                                }
                            }

                        VStack(spacing: 16) {
                            Text("🛏️ \(entry.name)")
                                .font(.title)
                                .bold()
                            Text("🌙 Start: \(formatted(entry.startDate))")
                            Text("☀️ End: \(formatted(entry.endDate))")
                            if !entry.notes.isEmpty {
                                Text("📝 Notes: \(entry.notes)")
                                    .italic()
                            }

                            Button("Close") {
                                withAnimation {
                                    showPopup = false
                                }
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .frame(maxWidth: 300)
                        .transition(.scale.combined(with: .opacity))
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }

    func formatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    class SleepLogViewModel: ObservableObject {
        @Published var entries: [SleepEntry] = []

        func addEntry(name: String, notes: String, start: Date, end: Date) {
            let newEntry = SleepEntry(name: name, notes: notes, startDate: start, endDate: end)
            entries.append(newEntry)
        }
    }
}


