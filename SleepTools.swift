//
//  SleepTools.swift
//  SleepTracker
//
//  Created by George Koroulis on 4/16/25.
//
import SwiftUI

struct SleepTools: View {
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
                
            }
        }
        
    }
}

