//
//  Image.swift
//  Tree
//
//  Created by Jae Ki Lee on 04/07/2019.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class Image {
    private var image: UIImage?
    private var imageUid: String?
    private var imageType: String?
    private var imageSize: CGSize?
    
    init(image: UIImage, imageUid: String, imageType: String, imageSize: CGSize) {
        self.image = image
        self.imageUid = imageUid
        self.imageType = imageType
        self.imageSize = imageSize
    }
    
    
}
