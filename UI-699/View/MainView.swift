//
//  MainView.swift
//  UI-699
//
//  Created by nyannyan0328 on 2022/10/15.
//

import SwiftUI

struct MainView: View {
    @State var currentTab : Tab = .home
    @Namespace var animation
    @State var showTabBar : Bool = false
    var body: some View {
        ZStack(alignment: .bottom) {
            
            TabView(selection: $currentTab) {
                
                
                Home()
                    .setBackGround(color: Color("BG"))
                    .tag(Tab.home)
                
                Text("B")
                    .setBackGround(color: Color("BG"))
                    .tag(Tab.scan)
                
                Text("A")
                    .setBackGround(color: Color("BG"))
                    .tag(Tab.folder)
                
                Text("A")
                    .setBackGround(color: Color("BG"))
                    .tag(Tab.cart)
                
                
            }
            
            TabBar()
                .offset(y:showTabBar ? 0 : 130)
                .animation(.interactiveSpring(response: 0.5,dampingFraction: 0.8,blendDuration: 0.7), value: showTabBar)
                
            
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("SHOWTABBAR"))) { _ in
            
            showTabBar = true
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("HIDETABBAR"))) { _ in
            
            showTabBar = false
        }
    }
    @ViewBuilder
    func TabBar ()->some View{
        
        
        HStack(spacing:0){
            
            ForEach(Tab.allCases ,id:\.self){tab in
                
                Image(tab.rawValue)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25,height: 25)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .foregroundColor(currentTab == tab ? .white : .gray.opacity(0.3))
                    .offset(y:currentTab == tab ? -25 : 0)
                    .background{
                     
                        if currentTab == tab{
                            
                            Circle()
                                .fill(.black)
                                .scaleEffect(2.5)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                                .offset(y:currentTab == tab ? -25 : 0)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        
                        currentTab = tab
                    }
                    .padding(15)
            }
        }
        .animation(.interactiveSpring(response: 0.5,dampingFraction: 0.8,blendDuration: 0.7), value: currentTab)
        .background{
         
            CustomCorner(corner: [.topRight,.topLeft], radi: 20)
                .fill(Color("Tab"))
                .ignoresSafeArea()
        }
       
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View{
    
    func showTabBar(){
        NotificationCenter.default.post(name: NSNotification.Name("SHOWTABBAR"), object: nil)
        
    }
    
    func hideTabBar(){
        
        NotificationCenter.default.post(name: NSNotification.Name("HIDETABBAR"), object: nil)
        
        
    }
    
    @ViewBuilder
    func setBackGround(color : Color)->some View{
        
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background{
             
                color.ignoresSafeArea()
            }
    }
}
