//
//  ContentView.swift
//  SleepTracker
//
//  Created by Abhi Sorathiya on 4/16/25.
//

import SwiftUI

struct ContentView: View {
        @StateObject var sleepLogViewModel = SleepLog.SleepLogViewModel()
        
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
                                            .padding(.bottom, 300)
                                        
                                        // Home Button
                                        NavigationLink(destination: SettingsView()) {
                                                RoundedRectangle(cornerRadius: 15)
                                                    .frame(width: 225, height: 50)
                                                    .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                                                    .overlay {
                                                            Text("Settings")
                                                                .font(.custom("American Typewriter", size: 30))
                                                                .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                                                        }
                                            }
                                        .padding(.bottom, 10)
                    
                                        // Health Profile Button
                                        NavigationLink(destination: ProfileView()) {
                                                RoundedRectangle(cornerRadius: 15)
                                                    .frame(width: 225, height: 50)
                                                    .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                                                    .overlay {
                                                            Text("Health Profile")
                                                                .font(.custom("American Typewriter", size: 30))
                                                                .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                                                        }
                                            }
                                        .padding(.bottom, 10)
                    
                                        // Sleep Log Button
                                        NavigationLink(destination: SleepLog(viewModel: sleepLogViewModel)) {
                                                RoundedRectangle(cornerRadius: 15)
                                                    .frame(width: 225, height: 50)
                                                    .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                                                    .overlay {
                                                            Text("Sleep Log")
                                                                .font(.custom("American Typewriter", size: 30))
                                                                .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                                                        }
                                            }
                                        .padding(.bottom, 10)
                                        
                                        // Sleep Trend Button
                                        NavigationLink(destination: SleepTrendView(sleepLogViewModel: sleepLogViewModel)) {
                                                RoundedRectangle(cornerRadius: 15)
                                                    .frame(width: 225, height: 50)
                                                    .foregroundStyle(Color(red: 0.722, green: 0.663, blue: 0.788))
                                                    .overlay {
                                                            Text("Sleep Trend")
                                                                .font(.custom("American Typewriter", size: 30))
                                                                .foregroundStyle(Color(red: 0.918, green: 0.918, blue: 0.918))
                                                        }
                                            }
                                        .padding(.bottom, 10)
                    
                                        // Sleep Science Button
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
                                        .padding(.bottom, 10)
                    
                                        // Sleep Tools Button
                                        NavigationLink(destination: SleepTools()) {
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





