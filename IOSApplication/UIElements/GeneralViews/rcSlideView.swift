//
//  rcSlideView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/28/24.
//

import SwiftUI

protocol SlideViewItemProtocol: View {
    var id: UUID { get }
}

struct rcSlideViewItem<Subview : View> : SlideViewItemProtocol {
    var id = UUID()
    @ViewBuilder let content : Subview
    
    var body : some View {
        content
    }
}

extension View where Self: SlideViewItemProtocol {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

///Displays a sliding deck from the list of views passed into the the views parameter
struct rcSlideView: View {
    let views: [any SlideViewItemProtocol]
    
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            
            //Display the current page
            TabView(selection: $currentPage) {
                
                //Actual data of views that are submitted to the tab view
                ForEach(views.indices, id: \.self) { index in
                    views[index].eraseToAnyView()
                        .tag(index).padding()
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut(duration: 0.88), value: currentPage)
            
            HStack {
                
                //Back button
                Button(action: {
                    withAnimation {
                        currentPage = max(currentPage - 1, 0)
                    }
                }) {
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                //Dots
                HStack(spacing: 10) {
                    ForEach(views.indices, id: \.self) { index in
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(index == currentPage ? .textPrimary : .grey)
                            .onTapGesture {
                                withAnimation {
                                    currentPage = index
                                }
                            }
                    }
                }
                
                Spacer()
                
                //Next Button
                Button(action: {
                    withAnimation {
                        currentPage = min(currentPage + 1, views.count - 1)
                    }
                }) {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}
