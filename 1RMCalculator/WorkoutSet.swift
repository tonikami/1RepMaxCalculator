import Foundation

/**
 * Represets workout data for one set.
 */

class WorkoutSet {
    var date: Date
    var reps: Int
    var weight: Double
    var oneRepMax: Double
    
    init(date: Date, reps: Int, weight: Double) {
        self.date = date
        self.reps = reps
        self.weight = weight
        let rm = weight / (1.0278 - (0.0278 * Double(reps)))
        self.oneRepMax = round(rm)
    }
}
