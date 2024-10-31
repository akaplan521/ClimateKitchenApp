//
//  settings.swift
//  recipe
//
//  Created by user268927 on 10/17/24.
//
import SwiftUICore

class Settings: ObservableObject {
    // apliance type
    let appliances = ["Gas", "Induction", "Electric"]
    @Published var applianceType: String
    // Food Review
    @Published var foodTemp: Float
    @Published var difficulty: Float
    @Published var spiceLevel: Float
    @Published var appearance: [String]
    @Published var aroma: [String]
    @Published var flavor: [String]
    @Published var texture: [String]

    // zip code or geolocation
    @Published var location: Int
    init() {
        self.location = 05401
        self.applianceType = appliances[0]
        self.foodTemp = 0
        self.spiceLevel = 0
        self.difficulty = 0
        self.appearance = []
        self.aroma = []
        self.flavor = []
        self.texture = []
    }
}
