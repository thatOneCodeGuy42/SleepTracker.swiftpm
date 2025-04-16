import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.051, green: 0.106, blue: 0.165)
                    .ignoresSafeArea()
                VStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 350, height: 100)
                        .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                        .overlay {
                            Text("Sleep Tracker")
                                .font(.custom("American Typewriter", size: 50))
                                .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 300, trailing: 0))
                    Button {
                        print("button works")
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 225, height: 50)
                            .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                            .overlay {
                                Text("Sleep Log")
                                    .font(.custom("American Typewriter", size: 30))
                                    .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                            }
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    Button {
                        print("button works")
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 225, height: 50)
                            .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                            .overlay {
                                Text("Sleep Trend")
                                    .font(.custom("American Typewriter", size: 30))
                                    .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                            }
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    NavigationLink(destination: SleepScience()) {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 225, height: 50)
                            .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                            .overlay {
                                Text("Sleep Science")
                                    .font(.custom("American Typewriter", size: 30))
                                    .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                            }
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    Button {
                        print("button works")
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 225, height: 50)
                            .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                            .overlay {
                                Text("Sleep Tools")
                                    .font(.custom("American Typewriter", size: 30))
                                    .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                            }
                    }
                }
            }
        }
    }
}
