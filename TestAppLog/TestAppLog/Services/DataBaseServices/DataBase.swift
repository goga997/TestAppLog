//
//  DataBase.swift
//  TestAppLog
//
//  Created by Grigore on 02.08.2023.
//

import Foundation

class DataBase {
    
    static let shared = DataBase()
    private var dataContainer: [String]
    
    private init() {
        self.dataContainer = []
    }
    
    //MARK: - Methods
    func addData(data: String) {
        var temporarContainer = getData()
        temporarContainer.append(data)
        dataContainer = temporarContainer
        let result = saveData()
        
        if result {
            print("Data saved succesfullly")
        }
        else
        {
            print("Data failled to save")
        }
    }
    
    
    func getData() -> [String] {
        guard let decodedData = UserDefaults.standard.data(forKey: "password") else { return [] }
        let decoder = JSONDecoder()
        
        do {
            let finalDataDecoded = try decoder.decode([String].self, from: decodedData)
            return finalDataDecoded
        } catch( let error ) {
            print(error.localizedDescription)
        }
        return []
    }
    
    
    func saveData() -> Bool {
        let temporarContainer = dataContainer
        let userDefaults = UserDefaults.standard
        
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(temporarContainer)
            userDefaults.set(encodedData, forKey: "password")
        } catch( let error ) {
            print(error)
        }
        
        return userDefaults.synchronize()
    }
    
}
