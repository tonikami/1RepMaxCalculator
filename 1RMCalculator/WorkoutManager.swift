import Foundation

/**
 * Contains a list of all workout data.
 */

class WorkoutManager {
    static let shared = WorkoutManager()
    
    var workoutUpdateDelegate: WorkoutManagerDelegate?
    var workouts: [Workout]
    
    init() {
        workouts = [Workout]()
        DispatchQueue.global(qos: .background).async {
            self.workouts =  WorkoutFactory().getWorkouts()
            DispatchQueue.main.async {
                if self.workoutUpdateDelegate != nil {
                    self.workoutUpdateDelegate?.workoutsUpdated()
                }
            }
        }
    }
}

protocol WorkoutManagerDelegate {
    func workoutsUpdated()
}
