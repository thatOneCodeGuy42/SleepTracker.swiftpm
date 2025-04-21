//
//  SleepTools.swift
//  SleepTracker
//
//  Created by George Koroulis on 4/16/25.
//
import SwiftUI

struct SleepTools: View {
    @State var url1 = "https://www.youtube.com/watch?v=2f5mRTjkHJ4"
    @State var url2 = "https://www.youtube.com/watch?v=fk-_SwHhLLc"
    @State var url3 = "https://www.mayoclinic.org/healthy-lifestyle/adult-health/in-depth/sleep/art-20048379"
    @State var url4 = "https://www.verywellmind.com/how-to-get-better-sleep-5094084"
    @State var url5 = "https://www.youtube.com/watch?v=zrPbSmhxUbg"
    @State var url6 = "https://open.spotify.com/playlist/37i9dQZF1DWZ8HCIPoGGKp"
    @State var url7 = "https://www.pandora.com/podcast/8-hour-sleep-music/green-noise-rain-drops-8-hours-of-green-noise-with-rain-sounds-under-an-umbrella-for-adhd-relief-focus-mental-clarity-and-relaxation/PE:1316770851"
    @State var url8 = "https://music.apple.com/us/album/green-noise-nature-frequencies/1742860755"
    var body: some View {
        ZStack {
            Color(red: 0.051, green: 0.106, blue: 0.165)
                .ignoresSafeArea()
            VStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 350, height: 100)
                    .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                    .overlay {
                        Text("Sleep Tools")
                            .font(.custom("American Typewriter", size: 50))
                            .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                Text("-- YouTube Videos --")
                    .font(.custom("American Typewriter", size: 30))
                    .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                Link(destination: URL(string: url1)!) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 250, height: 40)
                        .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                        .overlay {
                            Text("Guided Sleep Meditation")
                                .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                        }
                }
                Link(destination: URL(string: url2)!) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 250, height: 40)
                        .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                        .overlay {
                            Text("Sleep Hygiene")
                                .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                        }
                }
                Text("-- Articles --")
                    .font(.custom("American Typewriter", size: 30))
                    .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                Link(destination: URL(string: url3)!) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 250, height: 40)
                        .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                        .overlay {
                            Text("Mayo Clinic Article")
                                .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                        }
                }
                Link(destination: URL(string: url4)!) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 250, height: 40)
                        .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                        .overlay {
                            Text("Very Well Mind Article")
                                .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                        }
                }
                Text("-- Playlists --")
                    .font(.custom("American Typewriter", size: 30))
                    .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                Link(destination: URL(string: url5)!) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 250, height: 40)
                        .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                        .overlay {
                            Text("Green Noise - Youtube")
                                .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                        }
                }
                Link(destination: URL(string: url6)!) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 250, height: 40)
                        .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                        .overlay {
                            Text("Green Noise - Spotify")
                                .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                        }
                }
                Link(destination: URL(string: url7)!) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 250, height: 40)
                        .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                        .overlay {
                            Text("Green Noise - Pandora")
                                .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                        }
                }
                Link(destination: URL(string: url8)!) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 250, height: 40)
                        .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                        .overlay {
                            Text("Green Noise - Apple Music")
                                .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                        }
                }
            }
        }
        
    }
}

