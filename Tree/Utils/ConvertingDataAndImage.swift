//
//  ConvertingDataAndImage.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/28/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

struct ConvertingDataAndImage {
    
    func convertingFromImageToUrl(image: UIImage) -> String? {
        //1. UIImage 를 입력받는다.
        //2. Image 의 고유아이디를 만든다(확장자와 같이)
        let uuid = UUID().uuidString
        let uuidWithTypeOfFile: String = "\(uuid).png"
        
        //3.유저 홈 디렉토리 url 를 가져온다.
        let fileManger = FileManager.default
        let homeDirectory = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first
        
        //4.디렉토리 도메인 주소에 이미지 고유 아이디를 붙여 이미지에 대한 도메인을 완성 시킨다.
        guard let fileUrl = homeDirectory?.appendingPathComponent(uuidWithTypeOfFile) else { return nil }
        
        do{
            //5.이미지를 데이터로 전환한다.
            let selectedImageData: Data? = image.pngData()
            //6.전환된 데이터에 도메인을 쓴다.
            try selectedImageData?.write(to: fileUrl)
        } catch {
                print("it would be a problem with fileUrl or Image")
        }
        
        return uuidWithTypeOfFile
    }

    func convertingFromUrlToImage(uniqueId: String) -> UIImage? {
        
        var imageData: UIImage?
        
        //1.이미지유알엘을 입력받는다.
        //2.유저 홈 디렉토리를 가져온다.
        let fileManger = FileManager.default
        let homeDirectory = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first
        //3.이미지에 대한 도메인을 완성시킨다.
        guard let fileUrl = homeDirectory?.appendingPathComponent(uniqueId) else { return nil }
        //4.도메인을 데이터로 변환한다.
        do{
            let data = try Data(contentsOf: fileUrl)
            //5.데이터를 UIImage 로 변환한다.
            imageData = UIImage(data: data)
        } catch {
            print("check the imageId and fileUrl")
        }
        
        //6.UIImage 를 반환한다.
        return imageData
    }
}
