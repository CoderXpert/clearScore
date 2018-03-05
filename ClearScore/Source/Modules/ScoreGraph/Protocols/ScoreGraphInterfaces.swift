import UIKit

typealias NetworkingCompletion = (NetworkingError?, Any?) -> Void

enum ScoreGraphNavigationOption {
}

enum NetworkingError: Error {
    case failed(message: String)
}

protocol ScoreGraphWireframeInterface: WireframeInterface {
    func navigate(to option: ScoreGraphNavigationOption)
}

protocol ScoreGraphViewInterface: ViewInterface {
    var presenter: ScoreGraphPresenterInterface! { get }
    func reload(with reportInfo: CreditReportInfo)
}

protocol ScoreGraphPresenterInterface: PresenterInterface {
}

protocol ScoreGraphDataInteractorInterface: DataInteractorInterface {
    func fetchCreditScoreInfo()
}

protocol ScoreGraPhNetworkingServiceInterface {
    func fetchCreditScoreInfo(completion: @escaping NetworkingCompletion)
}
