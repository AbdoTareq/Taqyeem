import Foundation

struct APIResponse<T: Decodable, U: Decodable>: Decodable {
    var sucess: Bool!
    var message: String?
    var data: T?
    var meta: Meta<U>?
}

struct Meta<T: Decodable>: Decodable {
    var pagination: PaginationN?
    var custom: T?
}
