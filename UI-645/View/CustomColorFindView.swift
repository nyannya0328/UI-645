//
//  CustomColorFindView.swift
//  UI-645
//
//  Created by nyannyan0328 on 2022/08/16.
//

import SwiftUI

struct CustomColorFindView<Content : View>: UIViewRepresentable {
    @EnvironmentObject var model : LockScreenViewModel
    var content : Content
    var onLoad : (UIView) -> ()
    
    init(@ViewBuilder content : @escaping()-> Content,onLoad : @escaping(UIView) -> ()) {
        
        self.content = content()
        self.onLoad = onLoad
    }
    
    func makeUIView(context: Context) -> UIView {
        
        
        let size = UIApplication.shared.screenSize()
        
        let host = UIHostingController(rootView: content.frame(width: size.width,height: size.height)
        
           // .environmentObject(model)
        )
        
        host.view.frame = CGRect(origin: .zero, size: size)
        
        
        return host.view
            
        
        
        
        
       
        
        
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            
            onLoad(uiView)
            
        }
    }
}

