import Foundation

struct APIResponse<T: Decodable>: Decodable {
    var sucess: Bool!
    var message: String?
    var data: T?
}
