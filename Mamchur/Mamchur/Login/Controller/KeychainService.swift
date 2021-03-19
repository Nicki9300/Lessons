//
//  KeychainService.swift
//  Mamchur
//
//  Created by Kolya Mamchur on 18.03.2021.
//

import Security
import Foundation

class KeychainService {
    class func updateData(service: String, account: String, data: String) {
        guard let dataFromString = data.data(using: .utf8, allowLossyConversion: false) else {
            return
        }

        let status = SecItemUpdate(modifierQuery(service: service, account: account), [kSecValueData: dataFromString] as CFDictionary)

        checkError(status)
    }

    class func removeData(service: String, account: String) {
        let status = SecItemDelete(modifierQuery(service: service, account: account))

        checkError(status)
    }

    class func saveData(service: String, for key: String, data: String) {
        guard let dataFromString = data.data(using: .utf8, allowLossyConversion: false) else {
            return
        }

        let keychainQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                              kSecAttrService: service,
                                              kSecAttrAccount: key,
                                              kSecValueData: dataFromString]

        let status = SecItemAdd(keychainQuery as CFDictionary, nil)

        checkError(status)
    }

    class func loadData(service: String, account: String) -> String? {
        var dataTypeRef: CFTypeRef?

        let status = SecItemCopyMatching(modifierQuery(service: service, account: account), &dataTypeRef)
      

        if status == errSecSuccess,
            let retrievedData = dataTypeRef as? Data {
            return String(data: retrievedData, encoding: .utf8)
        } else {
            checkError(status)

            return nil
        }
    }

    fileprivate static func modifierQuery(service: String, account: String) -> CFDictionary {
        let keychainQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                              kSecAttrService: service,
                                              kSecAttrAccount: account,
                                              kSecReturnData: kCFBooleanTrue]

        return keychainQuery as CFDictionary
    }

    fileprivate static func checkError(_ status: OSStatus) {
        if status != errSecSuccess {
            if #available(iOS 11.3, *),
            let err = SecCopyErrorMessageString(status, nil) {
                print("Operation failed: \(err)")
            } else {
                print("Operation failed: \(status)")
            }
        }
    }
}
