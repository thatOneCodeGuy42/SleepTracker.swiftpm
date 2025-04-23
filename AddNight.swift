//
//  AddNight.swift
//  SleepTracker
//
//  Created by Abhi Sorathiya on 4/16/25.
//

import SwiftUI

struct CombinedSleepTrackerView: View {
    
    @ObservedObject var viewModel: SleepLog.SleepLogViewModel

    @State var nameInput = ""
    @State var notesInput = ""
    @State var showStartPicker = false
    @State var showEndPicker = false
    @State var navigate = false
    @Environment(\.presentationMode) var presentationMode
    @State var startDate: Date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
    @State var endDate: Date = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!

    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Enter Sleep Info")
                        .font(.title2)
                        .bold()
                        .padding(.top)

                    HStack {
                        Image(systemName: "person.fill")
                        TextField("Name", text: $nameInput)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                    HStack {
                        Image(systemName: "bed.double.fill")
                        Button(action: { showStartPicker = true }) {
                            HStack {
                                Text(timeFormatter.string(from: startDate))
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    HStack {
                        Image(systemName: "alarm.fill")
                        Button(action: { showEndPicker = true }) {
                            HStack {
                                Text(timeFormatter.string(from: endDate))
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    HStack {
                        Image(systemName: "note.text")
                        TextField("Notes (optional)", text: $notesInput)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                    Text("Tip: Tap the time fields to select times")
                        .font(.footnote)
                        .foregroundColor(.gray)

                    HStack(spacing: 16) {
                        Button("Delete") {
                            clearInputs()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        Button("Confirm") {
                            viewModel.addEntry(name: nameInput, notes: notesInput, start: startDate, end: endDate)

                            clearInputs()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                    }

                    Divider().padding(.vertical)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Previous Entry Summary")
                            .font(.headline)
                        Text("🛏️ Name: —")
                        Text("🌙 Start Time: —")
                        Text("☀️ End Time: —")
                        Text("📝 Notes: —")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)

                    Spacer()
                }
                .padding()
                .navigationTitle("Sleep Tracker")
            }
            .sheet(isPresented: $showStartPicker) {
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Button("Done") { showStartPicker = false }
                            .padding()
                    }
                    DatePicker(
                        "Start Time",
                        selection: $startDate,
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxHeight: 200)
                    Spacer()
                }
                .presentationDetents([.height(300)])
            }
            .sheet(isPresented: $showEndPicker) {
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Button("Done") { showEndPicker = false }
                            .padding()
                    }
                    DatePicker(
                        "End Time",
                        selection: $endDate,
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxHeight: 200)
                    Spacer()
                }
                .presentationDetents([.height(300)])
            }
        }
    }

    func clearInputs() {
        nameInput = ""
        notesInput = ""
        if let startOfDay = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date()) {
            startDate = startOfDay
        }
        if let noon = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date()) {
            endDate = noon
        }
    }
}
