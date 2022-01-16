//
//  UIImageView+Extension.swift
//  ChatPill
//
//  Created by Akshat Sharma on 15/01/22.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImage(url: URL) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.image = image
            }
            
            
        }
        
        task.resume()
    }

}
