//
//  HealthkitView.swift
//  sleeptrackertester2
//
//  Created by Abhi Sorathiya on 5/1/25.
//

import Foundation
import HealthKit

@MainActor
class HealthDataViewModel: ObservableObject {
    @Published var stepCount: Double = 0
    @Published var heartRate: Double = 0
    @Published var activeEnergy: Double = 0
    @Published var isAuthorized: Bool = false
    @Published var errorMessage: String?

    init() {
        Task { await requestAuthorization() }
    }

    func requestAuthorization() async {
        do {
            let success = try await HealthKitManager.shared.requestAuthorization()
            self.isAuthorized = success
            if success {
                await fetchAllHealthData()
            }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }

    func fetchAllHealthData() async {
        async let steps: () = fetchStepCount()
        async let rate: () = fetchHeartRate()
        async let energy: () = fetchActiveEnergy()
        _ = await (steps, rate, energy)
    }

    func fetchStepCount() async {
        if let sample = try? await HealthKitManager.shared.fetchMostRecentSample(for: .stepCount) {
            let value = sample.quantity.doubleValue(for: HKUnit.count())
            self.stepCount = value
        }
    }

    func fetchHeartRate() async {
        if let sample = try? await HealthKitManager.shared.fetchMostRecentSample(for: .heartRate) {
            let value = sample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
            self.heartRate = value
        }
    }

    func fetchActiveEnergy() async {
        if let sample = try? await HealthKitManager.shared.fetchMostRecentSample(for: .activeEnergyBurned) {
            let value = sample.quantity.doubleValue(for: HKUnit.kilocalorie())
            self.activeEnergy = value
        }
    }
}
