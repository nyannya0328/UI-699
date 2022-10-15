//
//  CustomCorner.swift
//  UI-699
//
//  Created by nyannyan0328 on 2022/10/15.
//

import SwiftUI

struct CustomCorner: Shape {
  
    var corner : UIRectCorner
    var radi : CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radi, height: radi))
        
        return Path(path.cgPath)
    }
}

