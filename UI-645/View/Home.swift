//
//  Home.swift
//  UI-645
//
//  Created by nyannyan0328 on 2022/08/16.
//

import SwiftUI
import SDWebImageSwiftUI
import PhotosUI

struct Home: View {
    @EnvironmentObject var model : LockScreenViewModel
    var body: some View {
        VStack{
            
            if let compressedImage = model.compressedImage{
                
                GeometryReader{proxy in
                    
                    let size = proxy.size
                    
                    Image(uiImage: compressedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width,height: size.height)
                        .scaleEffect(model.scale)
                        .overlay {
                            
                            TimeView()
                            
                            
                        }
                }
                
                
            }
            else{
                
                PhotosPicker(selection: $model.pickedItem,matching: .images,preferredItemEncoding: .automatic,photoLibrary: .shared()) {
                    
                    VStack(spacing:10){
                        
                        Image(systemName: "plus.viewfinder")
                            .font(.largeTitle)
                        
                        Text("Add Images")
                    }
                    .foregroundColor(.primary)
                    
                    
                }
                
                
            }
        }
        .overlay(alignment: .topLeading) {
            
            Button("Cancel"){
                
                withAnimation {
                    
                    model.compressedImage = nil
                }
                model.scale = 0
                
            }
            .font(.caption)
            .foregroundColor(.pink)
            .padding(.vertical,10)
            .padding(.horizontal)
            .background{
                
                
                Capsule()
                    .fill(.ultraThickMaterial)
                
            }
            .padding(.leading,5)
            .padding(.top,50)
            .opacity(model.compressedImage == nil ? 0 : 1)
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TimeView : View{
    
    var body: some View{
        
        HStack(spacing:0){
            
            
            Text(Date.now.convertToString(.hour))
                .font(.system(size: 100))
                .bold()
            
            
            VStack{
                
                Circle()
                    .fill(.white)
                    .frame(width: 15,height: 15)
                
                Circle()
                    .fill(.white)
                    .frame(width: 15,height: 15)
            }
            
            Text(Date.now.convertToString(.minute))
                .font(.system(size: 100))
                .bold()
            
            VStack{
                
                Circle()
                    .fill(.white)
                    .frame(width: 15,height: 15)
                
                Circle()
                    .fill(.white)
                    .frame(width: 15,height: 15)
            }
            
            Text(Date.now.convertToString(.seconds))
                .font(.system(size: 100))
                .bold()
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .foregroundColor(.white)
        .padding(.top,100)
    }
}
enum DateFromat : String{
    
    case hour = "hh"
    case minute = "mm"
    case seconds = "ss"
}

extension Date{
    
    func convertToString(_ fromat : DateFromat) -> String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = fromat.rawValue
        
        
        return formatter.string(from: self)
    }
    
}
