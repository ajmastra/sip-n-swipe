//
//  CardView.swift
//  sip-n-swipe
//
//  Created by AJ Mastrangelo on 4/29/25.
//

import SwiftUI

struct CardView: View {
    
    
    let cocktail: Cocktail
    var onSwipeLeft: () -> Void
    var onSwipeRight: () -> Void
    @State private var xOffset: CGFloat = 0
    @State private var degrees: Double = 0
    @State private var isExpanded: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                AsyncImage(url: URL(string: cocktail.imageURL)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .scaledToFill()
                
                SwipeActionIndicatorView(xOffset: $xOffset)
            }
            
            CocktailInfoView(cocktail: cocktail, isExpanded: $isExpanded)
                
        }
        .frame(width: SizeConstants.cardWidth, height: SizeConstants.cardHeight)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .offset(x: xOffset)
        .rotationEffect(.degrees(degrees))
        .animation(.snappy, value: xOffset)
        .gesture(
            DragGesture()
                .onChanged(onDragChanged)
                .onEnded(onDragEnded)
        )
    }
}

// functions for swiping cards off of the screen
private extension CardView {
    
    func returnToCenter() {
        xOffset = 0
        degrees = 0
    }
    
    func swipeRight() {
        xOffset = 500
        degrees = 12
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            onSwipeRight()
        }
        
    }
    
    func swipeLeft() {
        xOffset = -500
        degrees = -12
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            onSwipeLeft()
        }
        
    }
}



// function for bringing the card back to center when the user stops dragging
private extension CardView {
    func onDragChanged(_ value: _ChangedGesture<DragGesture>.Value) {
        xOffset = value.translation.width
        degrees = Double(value.translation.width / 25)
    }
    func onDragEnded(_ value: _ChangedGesture<DragGesture>.Value){
        let width = value.translation.width
        
        
        if abs(width) <= abs(SizeConstants.screenCutoff) {
            returnToCenter()
            return
        }
        
        if width >= SizeConstants.screenCutoff {
            swipeRight()
        }
        else {
            swipeLeft()
        }
    }
}


#Preview {
    CardView(
        cocktail: .mock,
        onSwipeLeft: {
        },
        onSwipeRight: {
        })
}

