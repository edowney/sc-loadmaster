//
//  Ship.swift
//  SC-LOADMASTER
//
//  Ship data model for managing user's fleet
//

import Foundation

struct Ship: Identifiable {
    let id: UUID
    var name: String
    var cargoCapacitySCU: Int

    init(
        id: UUID = UUID(),
        name: String,
        cargoCapacitySCU: Int
    ) {
        self.id = id
        self.name = name
        self.cargoCapacitySCU = cargoCapacitySCU
    }
}

// MARK: - Validation
extension Ship {
    var isValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty && cargoCapacitySCU > 0
    }

    static func validate(name: String, cargo: String) -> ValidationResult {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)

        guard !trimmedName.isEmpty else {
            return .failure("Ship name is required")
        }

        guard trimmedName.count <= 50 else {
            return .failure("Ship name is too long (max 50 characters)")
        }

        guard let cargoValue = Int(cargo), cargoValue > 0 else {
            return .failure("Cargo capacity must be a positive number")
        }

        return .success
    }

    enum ValidationResult {
        case success
        case failure(String)

        var isValid: Bool {
            if case .success = self {
                return true
            }
            return false
        }

        var errorMessage: String? {
            if case .failure(let message) = self {
                return message
            }
            return nil
        }
    }
}

// MARK: - Sample Data for Preview
extension Ship {
    static let sampleData: [Ship] = [
        Ship(name: "ARGO RAFT", cargoCapacitySCU: 196),
        Ship(name: "MISC HULL A", cargoCapacitySCU: 64),
        Ship(name: "HERCULES C2", cargoCapacitySCU: 495),
        Ship(name: "DRAKE CUTLASS BLACK", cargoCapacitySCU: 45)
    ]
}
