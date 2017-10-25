import UIKit
import Charts

class OneRepMaxHistoryViewController: UIViewController {
    let GRAPH_DATE_FORMAT = "MMM y"
    
    @IBOutlet weak var lineChartView: LineChartView!
    var workout: Workout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = workout.name
        
        displayDataPoints()
    }

    private func displayDataPoints() {
        let chartDataSet = LineChartDataSet()
        var xAxisValues = [String]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = GRAPH_DATE_FORMAT
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        var i = 0;
        for (date, oneRepMax) in workout.historicOneRepMax() {
            xAxisValues.append(dateFormatter.string(from: date))
            let entry = ChartDataEntry(x: Double(i), y: oneRepMax)
            let _ = chartDataSet.addEntry(entry)
            i = i + 1
        }
        
        chartDataSet.setColor(UIColor.black)
        chartDataSet.setCircleColor(UIColor.black)
        
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:xAxisValues)
        lineChartView.xAxis.granularity = 1
        
        lineChartView.legend.enabled = false
        lineChartView.chartDescription?.enabled = false
        
        let lineChartdata = LineChartData(dataSet: chartDataSet)
        lineChartdata.setDrawValues(false)
        lineChartView.data = lineChartdata
    }
}
