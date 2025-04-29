import SwiftUI

struct CombinedSleepTrackerView: View {
    @ObservedObject var viewModel: SleepLog.SleepLogViewModel
    
    @State var nameInput = ""
    @AppStorage("nameOfSleep") var nameInputPersist = ""
    @State var notesInput = ""
    @AppStorage("notesOfSleep") var notesInputPersist = ""
    @State var showStartPicker = false
    @AppStorage("startDateTime") var startDatePersist = ""
    @State var showEndPicker = false
    @AppStorage("endDateTime") var endDatePersist = ""
    @State var navigate = false
    @State var showDatePicker = false
    @State var selectedQuality = "😴"
    @Environment(\.presentationMode) var presentationMode
    
    @FocusState var focusedField: Bool
    
    @State var startDate: Date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
    @AppStorage("startTime") var startTime = ""
    @State var endDate: Date = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
    @AppStorage("endTime") var endTime = ""
    @State var selectedDate: Date = Date()
    @State var animateConfirm: Bool = false
    @State var showConfetti: Bool = false
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Enter Sleep Info")
                        .font(.largeTitle.bold())
                        .padding(.top)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .transition(.move(edge: .top))
                    
                    Group {
                        HStack {
                            Image(systemName: "person.fill")
                            TextField("Name", text: $nameInput)
                                .focused($focusedField)
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        HStack {
                            Image(systemName: "calendar")
                            Button(action: { showDatePicker = true }) {
                                HStack {
                                    Text(dateFormatter.string(from: selectedDate))
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(10)
                            }
                        }
                        
                        HStack {
                            Image(systemName: "bed.double.fill")
                            Button(action: { showStartPicker = true }) {
                                Text(timeFormatter.string(from: startDate))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(10)
                            }
                        }
                        
                        HStack {
                            Image(systemName: "alarm.fill")
                            Button(action: { showEndPicker = true }) {
                                Text(timeFormatter.string(from: endDate))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(10)
                            }
                        }
                        
                        HStack {
                            Image(systemName: "note.text")
                            TextField("Notes (optional)", text: $notesInput)
                                .focused($focusedField)
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        HStack {
                            Image(systemName: "face.smiling")
                            Picker("Mood", selection: $selectedQuality) {
                                Text("😴").tag("😴")
                                Text("😊").tag("😊")
                                Text("😫").tag("😫")
                                Text("😡").tag("😡")
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    .transition(.move(edge: .leading))
                    
                    HStack(spacing: 16) {
                        Button("Delete") {
                            clearInputs()
                            presentationMode.wrappedValue.dismiss()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .scaleEffect(animateConfirm ? 1.05 : 1)
                        .animation(.easeInOut, value: animateConfirm)
                        
                        Button(action: confirmSave) {
                            Text("Confirm")
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(nameInput.isEmpty ? Color.gray : Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .scaleEffect(animateConfirm ? 1.05 : 1)
                        }
                        .disabled(nameInput.isEmpty)
                        .animation(.easeInOut, value: nameInput)
                    }
                    .padding(.top)
                    
                    if showConfetti {
                        Text("🎉 Saved!")
                            .font(.title2.bold())
                            .foregroundColor(.green)
                            .transition(.scale)
                            .padding(.top, 10)
                    }
                    
                    Divider()
                        .padding(.vertical)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Previous Entry Summary")
                            .font(.headline)
                        Text("🛏️ Name: \(nameInputPersist)")
                        Text("🌙 Start Time: \(startDatePersist)")
                        Text("☀️ End Time: \(endDatePersist)")
                        Text("📝 Notes: \(notesInputPersist)")
                        Text("🌟 Quality: \(selectedQuality)")
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .transition(.opacity)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Sleep Tracker")
            .background(Color(.systemGroupedBackground))
            .onTapGesture { focusedField = false }
            .sheet(isPresented: $showDatePicker) { dateSheet }
            .sheet(isPresented: $showStartPicker) { startSheet }
            .sheet(isPresented: $showEndPicker) { endSheet }
        }
    }
    
     var dateSheet: some View {
        VStack {
            HStack {
                Spacer()
                Button("Done") { showDatePicker = false }
                    .padding()
            }
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
        }
        .presentationDetents([.height(300)])
    }
    
     var startSheet: some View {
        VStack {
            HStack {
                Spacer()
                Button("Done") { showStartPicker = false }
                    .padding()
            }
            DatePicker("", selection: $startDate, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
        }
        .presentationDetents([.height(300)])
    }
    
     var endSheet: some View {
        VStack {
            HStack {
                Spacer()
                Button("Done") { showEndPicker = false }
                    .padding()
            }
            DatePicker("", selection: $endDate, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
        }
        .presentationDetents([.height(300)])
    }
    
    func confirmSave() {
        guard !nameInput.isEmpty else { return }
        viewModel.addEntry(name: nameInput, notes: notesInput, start: startDate, end: endDate)
        UserDefaults.standard.set(nameInput, forKey: "nameOfSleep")
        UserDefaults.standard.set(notesInput, forKey: "notesOfSleep")
        let formatter = DateFormatter()
        formatter.dateFormat = "hh.mm.a"
        startDatePersist =  formatter.string(from: startDate)
        endDatePersist =  formatter.string(from: endDate)
        clearInputs()
        animateConfirm.toggle()
        showConfetti = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showConfetti = false
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func clearInputs() {
        nameInput = ""
        notesInput = ""
        selectedDate = Date()
        startDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        endDate = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
    }
}


