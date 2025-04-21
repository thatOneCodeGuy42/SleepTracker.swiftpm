import SwiftUI

struct SleepLog: View {
    var body: some View {
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
                                .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                        }
                }
                .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
}
