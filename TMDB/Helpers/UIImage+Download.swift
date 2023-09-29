//
//  UIImage+Download.swift
//  TMDB
//
//  Created by Radwa Ahmed on 18/09/2023.
//

import UIKit

extension UIImage {
    static func download(from url: URL?, completion: ((UIImage?) -> Void)?) {
        DispatchQueue.global().async {
            guard
                let url,
                let data = try? Data(contentsOf: url)
            else {
                DispatchQueue.main.async {
                    completion?(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                completion?(image)
            }
        }
    }
}
