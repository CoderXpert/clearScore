import UIKit

final class ScoreGraphPresenter {

    // MARK: - Private properties
    
    /// View that will receive updates from the presenter about any state change
    fileprivate weak var view: ScoreGraphViewInterface?
    
    /// Interactor responsible to request reports
    fileprivate var dataInteractor: ScoreGraphDataInteractorInterface
    
    /// Wireframe is responsible for navigation
    fileprivate var wireframe: ScoreGraphWireframeInterface
    
    /// Credit report information
    fileprivate var creditReportInfo: CreditReportInfo?
    
    // MARK: - Lifecycle
    init(wireframe: ScoreGraphWireframeInterface, view: ScoreGraphViewInterface, dataInteractor: ScoreGraphDataInteractorInterface) {
        self.wireframe = wireframe
        self.view = view
        self.dataInteractor = dataInteractor
    }
    
    
    /// Called by the view - ScoreGraphViewInterface when its corresponding life cycle method it's executed
    func viewDidLoad() {
        dataInteractor.fetchCreditScoreInfo()
    }
}

// MARK: - Extensions
extension ScoreGraphPresenter: ScoreGraphPresenterInterface {}

extension ScoreGraphPresenter: DataInteractorDelegateInterface {
    
    
    /// Called by the dataInteractor when the network request was succesfull
    ///
    /// - Parameter model: Entity returned by the dataInteractor
    func dataInteractorDidFinishFetch(model: Any) {
        guard let creditReportInfo = model as? CreditReportInfo else {
            return
        }
        
        self.creditReportInfo = creditReportInfo
        view?.reload(with: creditReportInfo)
    }
    
    
    /// Called by the dataInteractor when the request was not succesfull
    ///
    /// - Parameter error: error describing the issue encountered when fetching the item
    func dataInteractorDidFinishFetchWithFailure(error: Error) {
        print("There was an error: ", error.localizedDescription)
    }
}
