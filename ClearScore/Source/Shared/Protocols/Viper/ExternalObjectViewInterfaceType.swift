import UIKit

protocol ExternalObjectViewInterfaceType {
    
    associatedtype ViewControllerType: UIViewController, ViewInterface
    
    weak var viewController: ViewControllerType! { get set }
}

