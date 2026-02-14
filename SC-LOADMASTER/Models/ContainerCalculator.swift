import Foundation

class ContainerCalculator {
    static let containerSizes = [16, 8, 4, 2, 1]

    /// Calculate optimal container distribution for given SCU amount
    /// - Parameters:
    ///   - totalSCU: Total cargo units to transport
    ///   - maxContainerSize: Maximum container size available for this contract
    /// - Returns: Container distribution showing count of each size needed
    static func calculateContainers(totalSCU: Int, maxContainerSize: Int) -> ContainerDistribution {
        var distribution = ContainerDistribution()
        var remainingSCU = totalSCU

        // Filter to only use containers <= maxContainerSize
        let availableSizes = containerSizes.filter { $0 <= maxContainerSize }

        // Greedy algorithm: Use largest containers first
        for size in availableSizes {
            if remainingSCU >= size {
                let count = remainingSCU / size
                remainingSCU -= count * size

                switch size {
                case 16:
                    distribution.size16 = count
                case 8:
                    distribution.size8 = count
                case 4:
                    distribution.size4 = count
                case 2:
                    distribution.size2 = count
                case 1:
                    distribution.size1 = count
                default:
                    break
                }
            }
        }

        return distribution
    }

    /// Validate that container calculation matches expected total
    /// - Parameters:
    ///   - distribution: Container distribution to validate
    ///   - expectedTotal: Expected total SCU
    /// - Returns: True if calculation is correct
    static func validateCalculation(distribution: ContainerDistribution, expectedTotal: Int) -> Bool {
        let calculatedTotal = (distribution.size16 * 16) +
                             (distribution.size8 * 8) +
                             (distribution.size4 * 4) +
                             (distribution.size2 * 2) +
                             (distribution.size1 * 1)
        return calculatedTotal == expectedTotal
    }
}
