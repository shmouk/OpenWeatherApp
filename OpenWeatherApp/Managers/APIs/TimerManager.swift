import Foundation

class TimerManager {
    static let shared = TimerManager()
    let timerTolerance: TimeInterval = 1.0
    var timer: Timer?
    
    private init(timer: Timer? = nil) {
        self.timer = timer
    }
    
    func startTimer(target: Any, selector: Selector) {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: target,
                                     selector: selector,
                                     userInfo: nil,
                                     repeats: true)
        timer?.tolerance = timerTolerance
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}


