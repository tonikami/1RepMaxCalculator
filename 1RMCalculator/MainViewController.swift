import UIKit

class MainTableViewController: UITableViewController, WorkoutManagerDelegate {
    var workoutManager = WorkoutManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        workoutManager.workoutUpdateDelegate = self
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutManager.workouts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCellReuseIdentifier", for: indexPath) as! WorkoutTableViewCell
        
        let workout = workoutManager.workouts[indexPath.row]
        cell.workoutNameLabel.text = workout.name
        cell.oneRepMaxLabel.text = String(workout.maxOneRepMax) + "lbs"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let oneRepMaxHistoryViewController = storyboard.instantiateViewController(withIdentifier: "OneRepMaxHistoryViewController") as! OneRepMaxHistoryViewController
        oneRepMaxHistoryViewController.workout = workoutManager.workouts[indexPath.row]
        self.navigationController?.pushViewController(oneRepMaxHistoryViewController, animated: true)
    }
    
    func workoutsUpdated() {
        self.tableView.reloadData()
    }
}

class WorkoutTableViewCell: UITableViewCell {
    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var oneRepMaxLabel: UILabel!
}

