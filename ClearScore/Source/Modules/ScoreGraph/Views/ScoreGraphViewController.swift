import UIKit

final class ScoreGraphViewController: UIViewController {

    // MARK: - Properties
    var presenter: ScoreGraphPresenterInterface!
    
    /// Graph View to represent the score depicted in the credit report
    @IBOutlet var circleView: CircleView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - Extensions
extension ScoreGraphViewController: ScoreGraphViewInterface {
    
    /// Called by the presenter to request an update after new content is provided
    ///
    /// - Parameter reportInfo: credit report informations
    func reload(with reportInfo: CreditReportInfo) {
        circleView.update(with: reportInfo)
    }
}
