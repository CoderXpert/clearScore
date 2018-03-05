import Foundation

protocol DataInteractorInterface: InteractorInterface {
    weak var delegate: DataInteractorDelegateInterface? { get set }
}
