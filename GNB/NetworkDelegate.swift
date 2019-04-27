import Foundation

protocol NetworkDelegate: AnyObject {
    func startLoading(_ idRequest: String)
    func stopLoadingWithSucces(_ idRequest: String)
    func stopLoadingWithError(_ idRequest: String, error: Error)
}
