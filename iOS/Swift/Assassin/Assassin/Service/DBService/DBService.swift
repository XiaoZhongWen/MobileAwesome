//
//  DBService.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/11.
//

import Foundation
import FMDB

class DBService {
    static let shared = DBService.init()

    var databaseQueue: FMDatabaseQueue?

    private init() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let dbFilePath = path.appending("/\(AssassinDBName)")
        let fileManager = FileManager.init()
        let isExist = fileManager.fileExists(atPath: dbFilePath)
        if !isExist {
            let bundlePath = Bundle.main.bundlePath.appending("/\(AssassinDBName)")
            do {
                try fileManager.copyItem(atPath: bundlePath, toPath: dbFilePath)
                databaseQueue = FMDatabaseQueue.init(path: dbFilePath)
            } catch  {}
        } else {
            databaseQueue = FMDatabaseQueue.init(path: dbFilePath)
        }
    }

    func inDatabase(_ closure: (FMDatabase) -> Void) {
        self.databaseQueue?.inDatabase({ (db) in
            closure(db)
            db.closeOpenResultSets()
        })
    }
}
