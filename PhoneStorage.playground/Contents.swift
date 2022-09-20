import Foundation

protocol MobileStorage {
    func getAll() -> Set<Mobile>
    func findByImei(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
}

struct Mobile: Hashable {
    let imei: String
    let model: String
}

enum StorageError: Error {
    case phoneNotFound
    case phoneAlreadyExists
}
class StorageImpl: MobileStorage{
    var storage: [String: Mobile] = [:]
    func getAll() -> Set<Mobile> {
        let array = [Mobile](storage.values)
        let set = Set(array)
        return set
    }
    
    func findByImei(_ imei: String) -> Mobile? {
        var mobile: Mobile?
        if storage.keys.contains(imei){
            mobile = storage[imei]
        }
        if mobile == nil{
            print("Imei not found")
        }
        return mobile
    }
    
    func save(_ mobile: Mobile) throws -> Mobile {
        if storage.values.contains(mobile){
            print("Phone is already saved")
            throw StorageError.phoneAlreadyExists
        } else {
            storage[mobile.imei] = mobile
            return mobile
        }
    }
    
    func delete(_ product: Mobile) throws {
        if storage.values.contains(product){
            storage[product.imei] = nil
        } else {
            print("This phone is not found")
            throw StorageError.phoneNotFound
        }
    }
    
    func exists(_ product: Mobile) -> Bool {
        let check = storage.values.contains(product) ? true : false
        return check
    }
    
}
