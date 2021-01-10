//
//  DaoService.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2021/1/8.
//

import Foundation
import FMDB

class DaoService {
    static let shared = DaoService()

    private var databaseQueue: FMDatabaseQueue?

    private init() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let dbPath = path + "/Assassin.db"
        let isExist = FileManager.init().fileExists(atPath: dbPath)
        if !isExist {
            if let bundle = Bundle.baseLibraryBundle() {
                if let originalPath = bundle.path(forResource: "Assassin.db", ofType: nil) {
                    do {
                        try FileManager.init().copyItem(atPath: originalPath, toPath: dbPath)
                        databaseQueue = FMDatabaseQueue.init(path: dbPath)
                    } catch {
                        print("Assassin.db file is not exist at \(dbPath)")
                    }
                }
            }
        } else {
            databaseQueue = FMDatabaseQueue.init(path: dbPath)
        }
        databaseQueue?.inDatabase({ (db) in
            
        })
    }
    
    func inDatabase(_ closure: @escaping (FMDatabase) -> Void) {
        databaseQueue?.inDatabase({ db in
            closure(db)
            db.closeOpenResultSets()
        })
    }
}
