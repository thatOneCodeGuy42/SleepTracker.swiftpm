import SwiftUI

struct SleepScience: View {
    let firstURL = "https://www.youtube.com/watch?v=IzQ2siryQrM"
    let secondURL = "https://www.youtube.com/watch?v=3mufsteNrTI"
    let thirdURL = "https://pmc.ncbi.nlm.nih.gov/articles/PMC6281147/"
    let fourthURL = "https://sleep.hms.harvard.edu/education-training/public-education/sleep-and-health-education-program/sleep-health-education-47"
    var body: some View {
        ZStack {
            Color(red: 0.051, green: 0.106, blue: 0.165)
                .ignoresSafeArea()
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 350, height: 100)
                    .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                    .overlay {
                        Text("Sleep Science")
                            .font(.custom("American Typewriter", size: 50))
                            .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                    }
                Spacer()
                VStack {
                    Text("--Youtube Videos--")
                        .font(.custom("American Typewriter", size: 25))
                        .foregroundStyle(Color.white)
                    Link( destination: URL(string: firstURL)!, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 350, height: 50)
                                .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                            Text("How Sleep Affects Your Brain")
                                .font(.custom("American Typewriter", size: 20))
                                .foregroundStyle(Color.white)
                        }
                    })
                    Link( destination: URL(string: secondURL)!, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 350, height: 50)
                                .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                            Text("Why Do We Have To Sleep?")
                                .font(.custom("American Typewriter", size: 20))
                                .foregroundStyle(Color.white)
                        }
                    })
                    Text("--Articles--")
                        .font(.custom("American Typewriter", size: 25))
                        .foregroundStyle(Color.white)
                    Link( destination: URL(string: thirdURL)!, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 350, height: 50)
                                .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                            Text("The Extraordinary importance of Sleep")
                                .font(.custom("American Typewriter", size: 17))
                                .foregroundStyle(Color.white)
                        }
                    })
                    Link( destination: URL(string: fourthURL)!, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 350, height: 50)
                                .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                            Text("Science of Sleep: What is Sleep?")
                                .font(.custom("American Typewriter", size: 20))
                                .foregroundStyle(Color.white)
                        }
                    })
                }
                
                Spacer()
                Spacer()
            }
        }
    }
}
