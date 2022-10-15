//
//  Home.swift
//  UI-699
//
//  Created by nyannyan0328 on 2022/10/15.
//

import SwiftUI

struct Home: View {
    @State var currenIndex : Int = 0
    @State var showDetailView : Bool = false
    @State var currentDetailPlant : Plant?
    @Namespace var animation
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            
            
            VStack(spacing: 15) {
                
                HeaderView()
                
                SearchView()
                
                PlantsView()
                
            }
            .padding(15)
        
            
        }
        .overlay {
            if let currentDetailPlant,showDetailView{
                
                DetailView(showDetail: $showDetailView, animation: animation, plant: currentDetailPlant)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(x:0.5)))
            }
        }
    
    }
    @ViewBuilder
    func PlantsView ()->some View{
        VStack(alignment:.leading,spacing: 10){
            
            HStack(spacing: 15) {
                
                Image("Grid")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 15,height: 15)
                
                Text("Most Popular")
                    .font(.title.weight(.semibold))
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                Button("Show All"){
                    
                    
                }
                .font(.callout)
                .foregroundColor(.gray)
                
            }
            .padding(.leading,5)
            
            
            CustomCrouselView(index: $currenIndex, items: plants,spacing: 20,cardPadding: 90 ,id: \.id) { plant, size in
                
            PlantsCardView(plant: plant, size: size)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        
                        hideTabBar()
                        withAnimation(.interactiveSpring(response: 0.5,dampingFraction: 0.8,blendDuration: 0.7)){
                         
                            showDetailView = true
                            currentDetailPlant = plant
                        }
                    }
                
                
            }
            .frame(height: 400)
            .padding(.top)
            .padding(.horizontal,10)
        }
        
        
    }
    @ViewBuilder
    func PlantsCardView (plant : Plant,size : CGSize)->some View{
     
        ZStack{
            
            LinearGradient(colors: [Color("Card Top"),Color("Card Bottom")], startPoint: .topLeading, endPoint: .topTrailing)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                
            
            VStack{
                
                Button {
                    
                } label: {
                
                    Image(systemName: "suit.heart.fill")
                        .font(.title3)
                        .foregroundColor(Color("Green"))
                         .frame(width: 50,height: 50)
                         .background{
                          
                             RoundedRectangle(cornerRadius: 10, style: .continuous)
                                 .fill(.white)
                         }
                    
                }
                .frame(maxWidth: .infinity,alignment: .topTrailing)
                .padding(15)
                
         
            
            VStack{
                
                if currentDetailPlant?.id == plant.id && showDetailView{
                    
                    Rectangle()
                        .fill(.clear)
                    
                }
                else{
                    
                    Image(plant.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: plant.id, in: animation)
                        .padding(.bottom,-35)
                        .padding(.top,-40)
                        
                    
                }
            }
            .zIndex(1)
            
            HStack{
                
                VStack(alignment:.leading,spacing: 10){
                    
                    Text(plant.plantName)
                        .font(.callout.weight(.semibold))
                    
                    Text(plant.price)
                        .font(.title.weight(.heavy))
                    
                    
                    
                    
                }
                  .frame(maxWidth: .infinity,alignment: .leading)
                
                
                
                Button {
                    
                } label: {
                 
                    Image("Cart")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fill)
                         .frame(width: 25,height: 25)
                         .foregroundColor(.white)
                         .frame(width: 55,height: 55)
                          .background{
                         
                              RoundedRectangle(cornerRadius: 20, style: .continuous)
                                  .fill(.black)
                                  
                         }
                         
                    
                }
                
            }
            .padding([.horizontal,.top],15)
              .frame(maxWidth: .infinity,alignment: .center)
               .frame(height: 100)
               .background{
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                       .fill(.white)
               }
               .padding()
               .zIndex(0)
                
                
            
            
            
        }
        }
      
        
    }
    @ViewBuilder
    func SearchView ()->some View{
        
        HStack{
            
            HStack{
                
                Image("Search")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25,height: 25)
                
                Divider()
                    .padding(.vertical,-5)
                
                TextField("SEARCH", text: .constant(""))
            }
            .padding(15)
            .background{
             
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.white)
            }
            
            Button {
                
            } label: {
                Image("Filter")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20,height: 20)
                    .foregroundColor(.white)
                    .padding(13)
                    .background{
                     
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.black)
                    }
                
                
            }
              
            
            
            
            
        }
        .padding(.top,15)
        
        
    }
    @ViewBuilder
    func HeaderView ()->some View{
     
        HStack{
           
            VStack(alignment:.leading,spacing: 15) {
                
                Text("Welocom ⛄️")
                    .font(.title.bold())
                
                Text("Snow Man")
                    .font(.title2.bold())
                    .foregroundColor(.white.opacity(0.8))
                    .shadow(color: .black.opacity(0.4), radius: 5,x:5,y:5)
                  
                
            }
              .frame(maxWidth: .infinity,alignment: .leading)
            
            Button {
                
            } label: {
             
                Image(systemName: "bell.fill")
                    .foregroundColor(.black)
                    .padding(13)
                    .background{
                     
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .fill(Color.white)
                            
                    }
                    .overlay(alignment: .topTrailing) {
                    
                        
                        Text("1")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(8)
                            .background{
                             
                                Circle()
                                    .fill(.green)
                            }
                             .offset(x:13,y:-13)
                        
                        
                    }
                  
            }
            
        }
       
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

