//
//  ImageConverter.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit

public class ImageConverter {
    //ImageDto -> Image
    
    static let shared = ImageConverter()
    
    func convert(input: ImageDto) -> Image? {
        
        var image = Image()
        image.id = input.id
        image.description = input.description
        image.filePath = input.filePath
        image.image = UIImage(data: Data()) //Add API call
        
        return image
    }
}
