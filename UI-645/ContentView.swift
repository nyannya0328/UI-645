//
//  ContentView.swift
//  UI-645
//
//  Created by nyannyan0328 on 2022/08/16.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model : LockScreenViewModel = .init()
    var body: some View {
      Home()
        .gesture(
        
            MagnificationGesture(minimumScaleDelta: 0.01)
                .onChanged({ value in
                    
                    model.scale = value + model.lastScale
                })
                .onEnded({ _ in
                    
                    if model.scale < 1  {
                        
                        withAnimation(.easeOut(duration: 0.15)){
                            model.scale = 1
                            
                        }
                        
                    }
                    
                    model.lastScale = model.scale - 1
                    
                })
            
           
        )
      
        .ignoresSafeArea()
             .environmentObject(model)
          

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
