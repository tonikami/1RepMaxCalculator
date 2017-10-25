import Foundation

class Workout {
    var name: String
    var sets: [WorkoutSet]
    var maxOneRepMax: Double

    init(name: String) {
        self.name = name
        self.sets = [WorkoutSet]()
        self.maxOneRepMax = 0
    }
    
    func addSet(set: WorkoutSet) {
        self.sets.append(set)
        self.maxOneRepMax = max(set.oneRepMax, self.maxOneRepMax)
    }
    
    func historicOneRepMax() -> [(Date, Double)] {
        var data = [(Date, Double)]()

        if sets.count == 0 {
            return data
        }
        
        var currentDate = sets[0].date
        var highest1RMForCurrentDate =  sets[0].oneRepMax
        
        for set in sets {
            if currentDate != set.date {
                data.append((currentDate, highest1RMForCurrentDate))
                currentDate = set.date
                highest1RMForCurrentDate = set.oneRepMax
            } else if set.oneRepMax > highest1RMForCurrentDate {
                highest1RMForCurrentDate = set.oneRepMax
            }
        }
        
        data.append((currentDate, highest1RMForCurrentDate))
        
        return data.reversed();
    }
}

