//
//  CustomCrouselView.swift
//  UI-699
//
//  Created by nyannyan0328 on 2022/10/15.
//

import SwiftUI

struct CustomCrouselView<Content : View,Item,ID>: View where Item : RandomAccessCollection,ID:Hashable,Item.Element : Equatable{
    
    var content : (Item.Element,CGSize) -> Content
    var id : KeyPath<Item.Element,ID>
    
    var cardPadding : CGFloat
    var spacing : CGFloat
    var items : Item
    
    @Binding var index : Int
    
 
    init(index : Binding<Int>,items : Item,spacing : CGFloat = 30,cardPadding : CGFloat = 80,id:KeyPath<Item.Element,ID>,@ViewBuilder content : @escaping(Item.Element,CGSize) -> Content) {
        
        self.content = content
        self.id = id
        self.cardPadding = cardPadding
        self.spacing = spacing
        self.items = items
        self._index = index
        
    }
    
    @GestureState var translation : CGFloat = 0
    @State var offset : CGFloat = 0
    @State var lastStoredOffset : CGFloat = 0
    @State var currentIndex : Int = 0
    var body: some View {
        GeometryReader{
            
            let size = $0.size
            
        let cardWidth = size.width - (cardPadding - spacing)
            
            HStack(spacing: spacing) {
                ForEach(items ,id:id){item in
                    
                    content(item, CGSize(width: size.width - cardPadding, height: size.height))
                        .contentShape(Rectangle())
                        .frame(width: size.width - cardPadding,height: size.height)
                }
                
            }
            .offset(x:offset)
            .contentShape(Rectangle())
            .gesture(
            
                DragGesture(minimumDistance: 5)
                    .updating($translation, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onChanged{onChanged(value: $0, cardWidth: cardWidth)}
                    .onEnded{onEnded(value: $0, cardWidth: cardWidth)}
                   
            
            )
            
        }
    }
    func onChanged(value : DragGesture.Value,cardWidth:CGFloat){
        var translationX = value.translation.width
        
        offset = translationX + lastStoredOffset
        
        translationX = (index == 0 && translationX > 0 ? (translationX / 4) : translationX)
        translationX = (index == items.count - 1 && translationX < 0 ? (translationX / 4) : translationX)
        
        offset = translationX + lastStoredOffset
        
        
    }
    
    func onEnded(value : DragGesture.Value,cardWidth:CGFloat){
        
        var _index = (offset / cardWidth).rounded()
        _index = max(-CGFloat(items.count - 1), _index)
        _index = min(_index, 0)
        
        currentIndex = Int(_index)
        
        index = -currentIndex
        
        withAnimation(.interactiveSpring(response: 0.5,dampingFraction: 0.8,blendDuration: 0.7)){
         
            let extraSpace = index == 0 ? 0 : (cardPadding / 2)
            offset = (cardWidth * _index) + extraSpace
        }
        lastStoredOffset = offset
        
    }
    
    func indexOF(item : Item.Element) -> Int{
        let array = Array(items)
        
        if let index = array.firstIndex(of: item){
            return index
            
        }
        return 0
        
    }
}

struct CustomCrouselView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
