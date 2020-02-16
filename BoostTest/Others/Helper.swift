//
//  Helper.swift
//  BoostTest
//
//  Created by Ayus Salleh on 15/02/2020.
//  Copyright © 2020 Ayus_Salleh. All rights reserved.
//

import UIKit

enum HelperError: String, Error {
    case error = "Something wrong happened!"
}

class Helper: NSObject {

    private var jsonFilePath: URL? {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            return nil
        }
        
        let pathURL = URL(fileURLWithPath: path)
        return pathURL
    }
    
    func getContactData(completion: @escaping (_ contacts: [Contact], _ error: HelperError? )->()) {
        guard let filePath = jsonFilePath else {
            completion([], .error)
            return
        }

        do {
            let data = try Data(contentsOf: filePath)
            let contacts = try JSONDecoder().decode([Contact].self, from: data)
            completion(contacts, nil)
        } catch {
            completion([], .error)
        }
    }
    
    func updateContactData(contacts: [Contact], completion: @escaping (_ error: HelperError? )->()) {
        guard let filePath = jsonFilePath else {
            completion(.error)
            return
        }
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(contacts)
            try jsonData.write(to: filePath)
            completion(nil)
        } catch {
            completion(.error)
        }
    }
    
}
