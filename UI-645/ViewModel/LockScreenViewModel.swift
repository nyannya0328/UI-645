//
//  LockScreenViewModel.swift
//  UI-645
//
//  Created by nyannyan0328 on 2022/08/16.
//

import SwiftUI
import SDWebImageSwiftUI
import PhotosUI

class LockScreenViewModel: ObservableObject {
   
    @Published var scale : CGFloat = 1
    @Published var lastScale : CGFloat = 0
    
    @Published var pickedItem : PhotosPickerItem?{
        
        didSet{
            
            extractImage()
            
            
        }
        
    }
    
    
    @Published var compressedImage : UIImage?
    @Published var detectedPerson : UIImage?
    
    
    @Published var view : UIView = .init()
    
    func extractImage(){
        
        
        if let pickedItem{
            
            
            Task{
                
                guard let imageData = try? await pickedItem.loadTransferable(type: Data.self) else{return}
                
                let size = await UIApplication.shared.screenSize()
                
                
                let image = UIImage(data: imageData)?.sd_resizedImage(with: CGSize(width: size.width * 2, height: size.height * 2), scaleMode: .aspectFill)
                
                await MainActor.run(body: {
                    
                    self.compressedImage = image
                    
                })
            
            }
        }
        
    }
}

extension UIApplication{
    
    func screenSize()->CGSize{
        
        guard let window = connectedScenes.first as? UIWindowScene else {return .zero}
        
        return window.screen.bounds.size
    }
}


