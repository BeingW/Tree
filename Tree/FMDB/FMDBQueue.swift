//
//  FMDBQueue.swift
//  Tree
//
//  Created by Jae Ki Lee on 17/06/2019.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit
import FMDB

class FMDBQueue {
    
    private var fileName: String
    private var fileIdentifier: String
    
    //파일 경로를 이용해 fmdb객체를 만든다.
    lazy var fmdb: FMDatabase! = {
        let fileManager = FileManager()
        let file = "\(fileName).\(fileIdentifier)"
        let filePath: String

        //1.핸드폰의 document 디렉토리 경로를 가져온다.
        var documentPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        //2.경로뒤에 파일을 붙여 파일경로를 완성한다.
        filePath = documentPath!.appendingPathComponent(file).path
        print("\(filePath)")
        //3.파일경로내에 데이터베이스가 존재하는지 확인한다.
        if fileManager.fileExists(atPath: filePath) == false {
            //3.1.데이터베이스가 존재하지 않는다면
            if let dbSource = Bundle.main.path(forResource: self.fileName, ofType: self.fileIdentifier) {
                //3.1.1.프로그램 내에 있는 db를 파일경로에 복사한다.
                do{
                    try fileManager.copyItem(atPath: dbSource, toPath: filePath)
                } catch {
                    print("\(file) should be error")
                }
                
            }
            
        }
        //4.파일경로에 있는 DB를 이용해 fmdb객체를 생성한다.
        let fmdb = FMDatabase(path: filePath)
        
        return fmdb
    }()
    
    init() {
        
    }
    
    deinit {
        
    }
    
}
