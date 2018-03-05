import UIKit

final class ScoreGraphWireframe: BaseWireframe {

    // MARK: - Private properties
    private let _storyboard: UIStoryboard = UIStoryboard(name: Constants.Storyboard.name, bundle: nil)

    // MARK: - Module setup
    func configureModule(with viewController: ScoreGraphViewController) {
        let dataInteractor = ScoreGraphDataInteractor()
        let presenter = ScoreGraphPresenter(wireframe: self, view: viewController, dataInteractor: dataInteractor)
        dataInteractor.delegate = presenter
        viewController.presenter = presenter
    }

    // MARK: - Transitions
    func show(with transition: Transition, animated: Bool = true) {
        
        guard let navigationController = _storyboard.instantiateInitialViewController() as? UINavigationController,
            let moduleViewController = navigationController.viewControllers.first as? ScoreGraphViewController else {
                fatalError("Could not instantiate ScoreGraphViewController!")
        }
        
        self.navigationController = navigationController
        configureModule(with: moduleViewController)
        show(navigationController, with: transition, animated: animated)
    }
}

// MARK: - Extensions
extension ScoreGraphWireframe: ScoreGraphWireframeInterface {
    func navigate(to option: ScoreGraphNavigationOption) {}
}

// MARK: - Constants
extension ScoreGraphWireframe {
    struct Constants {
        struct Storyboard {
            static let name = "ScoreGraph"
        }
    }
}
