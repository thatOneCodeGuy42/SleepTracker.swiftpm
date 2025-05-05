import SwiftUI
import HealthKit

struct ProfileView: View {
    @StateObject var healthVM = HealthDataViewModel()
    @State var profileImage: Image = Image(systemName: "person.circle.fill")
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack {
                    Text("Some name")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.blue, lineWidth: 4))
                        .shadow(radius: 7)
                }
                .padding(.top, 40)
                
                if healthVM.isAuthorized {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 20) {
                        HealthMetricCard(
                            title: "Steps",
                            value: "\(Int(healthVM.stepCount))",
                            unit: "steps",
                            color: .orange
                        )
                        
                        HealthMetricCard(
                            title: "Heart Rate",
                            value: String(format: "%.0f", healthVM.heartRate),
                            unit: "bpm",
                            color: .red
                        )
                        
                        HealthMetricCard(
                            title: "Calories",
                            value: String(format: "%.0f", healthVM.activeEnergy),
                            unit: "kcal",
                            color: .green
                        )
                    }
                    .padding()
                } else {
                    VStack {
                        ProgressView()
                        Text("Requesting HealthKit access...")
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }
            }
        }
        .task {
            await healthVM.requestAuthorization()
        }
        .alert("HealthKit Error", isPresented: .constant(healthVM.errorMessage != nil)) {
            Button("OK") { }
        } message: {
            Text(healthVM.errorMessage ?? "")
        }
    }
}

struct HealthMetricCard: View {
    let title: String
    let value: String
    let unit: String
    let color: Color
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            
            Text(value)
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.white)
                .padding(.vertical, 4)
            
            Text(unit)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(color.gradient)
        .cornerRadius(15)
    }
}
