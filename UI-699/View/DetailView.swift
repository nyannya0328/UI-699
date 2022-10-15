//
//  DetailView.swift
//  UI-699
//
//  Created by nyannyan0328 on 2022/10/15.
//

import SwiftUI

struct DetailView: View {
    @Binding var showDetail : Bool
    var animation : Namespace.ID
    var plant : Plant
    @State var showContent : Bool = false
    var body: some View {
        GeometryReader{
            
            let size = $0.size
            
            VStack(alignment:.leading,spacing: 10){
                
             
                Image(plant.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: plant.id, in: animation)
                    .frame(width: size.width,height: size.height / 1.6,alignment: .bottom)
                    .zIndex(1)
                
                VStack(spacing: 20) {
                    
                    HStack{
                        
                        Text(plant.plantName)
                            .font(.title.bold())
                            .lineLimit(1)
                          .frame(maxWidth: .infinity,alignment: .leading)
                        
                        
                        Text(plant.price)
                            .font(.title3.bold())
                            .padding(.vertical,14)
                            .padding(.horizontal,15)
                            .background{
                             
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.green.opacity(0.3))
                            }
                    }
                    
                    Text("SAMPLESAMPLESAMPLESAMPLESAMPLESAMPLESAMPLESAMPLESAMPLESAMPLESAMPLE")
                        .multilineTextAlignment(.leading)
                    
                    Button {
                        
                    } label: {
                     
                        Text("By now")
                            .font(.callout.bold())
                            .foregroundColor(.white)
                          .frame(maxWidth: .infinity,alignment: .center)
                            .overlay(alignment: .leading) {
                                
                            
                                Image("Cart")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fill)
                                    .foregroundColor(.white)
                                 .frame(width: 25,height: 25)
                            }
                        
                    }
                    .padding()
                    .background{
                     RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.black)
                    }
                    .padding(.top,25)
                    
                    
                }
                .padding(15)
                .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
                .background{
                    CustomCorner(corner: [.topLeft,.topRight], radi: 20)
                        .fill(.white)
                        .ignoresSafeArea()
                }
                .offset(y:showContent ? 0 : (size.height / 1.5))
                .zIndex(0)
                
            
                
            }
            
        }
      
        .overlay(alignment: .top) {
            
            HeaderView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
         
            Rectangle()
                .fill(Color("Green")).ignoresSafeArea()
        }
        .onAppear{
            
            withAnimation(.easeIn(duration: 0.35).delay(0.05)){
                
                showContent = true
            }
        }
    }
    @ViewBuilder
    func HeaderView()->some View{
        
        Button {
            
            withAnimation(.easeIn(duration: 0.3)){
                
                showContent = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                
                showDetail = false
                
            }
            
            
        } label: {
         
            Image(systemName: "chevron.left")
                .font(.title)
                .foregroundColor(.white)
            
        }
          .frame(maxWidth: .infinity,alignment: .leading)
          .padding(13)
        
        
    }
}

