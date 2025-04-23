import SwiftUI

struct SleepEntry: Identifiable {
    let id = UUID()
    let name: String
    let notes: String
    let startDate: Date
    let endDate: Date
}

struct SleepLog: View {
    @StateObject var viewModel = SleepLogViewModel()
    @State var selectedEntry: SleepEntry?
    @State var showPopup = false

    var body: some View {
<<<<<<< HEAD
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
=======
        ZStack {
            Color(red: 0.051, green: 0.106, blue: 0.165)
                .ignoresSafeArea()
            VStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 350, height: 100)
                    .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                    .overlay {
                        Text("Sleep Log")
                            .font(.custom("American Typewriter", size: 50))
                            .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                List {
                    ForEach(1...13, id: \.self) { number in
                        Text("\(number)")
                    }
                }
                .frame(height: 400)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                NavigationLink(destination: CombinedSleepTrackerView()) {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 120, height: 40)
                        .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                        .overlay {
                            Text("AddNight")
                                .font(.custom("American Typewriter", size: 20))
>>>>>>> main
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
                .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0))
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
