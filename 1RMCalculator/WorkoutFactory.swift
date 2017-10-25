import Foundation

/**
 * Creates workout data from input.txt.
 */

class WorkoutFactory {
    let DATE_COLUMN_INDEX = 0;
    let NAME_COLUMN_INDEX: Int = 1;
    let SET_COLUMN_INDEX = 2;
    let REPS_COLUMN_INDEX = 3;
    let WEIGHT_COLUMN_INDEX = 4;
    let TOTAL_COLUMNS = 5;
    let DATE_FORMAT = "MMM dd yyyy"
    
    let dateFormatter: DateFormatter
    
    init() {
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = DATE_FORMAT
        self.dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    }
    
    func getWorkouts() -> [Workout] {
        var workouts = [String: Workout]()
        if let dataList = workoutDataList() {
            for line in dataList {
                let components = line.components(separatedBy: ",")
                if components.count == TOTAL_COLUMNS {
                    if let set = workoutSet(components: components) {
                        let workoutName = components[NAME_COLUMN_INDEX]
                        if let workout = workouts[workoutName] {
                            workout.addSet(set: set)
                        } else {
                            let workout = Workout(name: workoutName)
                            workout.addSet(set: set)
                            workouts[workoutName] = workout
                        }
                    }
                }
            }
        }
        return Array(workouts.values)
    }
    
    private func workoutDataList() -> [String]? {
        if let path = Bundle.main.path(forResource: "input", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                return data.components(separatedBy: "\r\n")
            } catch {
                print("Could not read input file.")
            }
        }
        return nil
    }
    
    private func workoutSet(components: [String]) -> WorkoutSet? {
        if let reps = Int(components[REPS_COLUMN_INDEX]),
            let weight = Double(components[WEIGHT_COLUMN_INDEX]),
            let date = self.dateFormatter.date(from: components[DATE_COLUMN_INDEX]) {
            return WorkoutSet(date: date, reps: reps, weight: weight)
        } else {
            print("Could not create WorkoutSet object from components.")
            return nil
        }
    }
}
