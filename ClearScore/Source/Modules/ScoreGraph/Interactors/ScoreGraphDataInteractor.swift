import Foundation

/// Interactor responsible to request reports to the networking service and pass the results to its delegate
final class ScoreGraphDataInteractor: ScoreGraphDataInteractorInterface {
    
    /// Delegate will be notified whether the request to the network was succesfull or not.
    weak var delegate: DataInteractorDelegateInterface?
    
    /// Service is the object designated to make requests to the network
    private var service: ScoreGraPhNetworkingServiceInterface = ScoreGraPhNetworkingService()
    
    /// Fetches the credit score informations from the server
    func fetchCreditScoreInfo() {
        service.fetchCreditScoreInfo { (error, info) in
            if let error = error {
               self.delegate?.dataInteractorDidFinishFetchWithFailure(error: error)
               return
            }
            
            if let info = info {
                self.delegate?.dataInteractorDidFinishFetch(model: info)
            }
        }
    }
    
}
