//
//  ContentView.swift
//  CS50 Final Project
//
//  Created by Alfredo Ormeno Zuniga on 2/26/23.
//

import SwiftUI

let rows = [["C", "%", "÷","DEL"],
            ["7","8", "9", "\u{00D7}"],
            ["4","5","6", "\u{2212}"],
            ["1", "2", "3", "+"],
            [".", "0", "\u{00B1}", "="]]

struct ContentView: View {
    
    var body: some View {
        // Will allow us to setupt realtive sizes
        GeometryReader{ geometry in
            // This Vstack holds all elements of the calculator
            VStack(spacing: 0.0){
                // Vstack for screen
                VStack{
                    Text("0")
                        .foregroundColor(.white)
                        .font(.system(size:78))
                }
                .padding([.bottom, .trailing])
                .ignoresSafeArea()
                .frame(width: geometry.size.width * 1, height: geometry.size.height * 0.33, alignment: .bottomTrailing)
                .background(.black)
                
                VStack{
                    VStack(spacing: 0){
                        ForEach(rows, id: \.self) { row in
                            HStack(alignment: .top, spacing: 0) {
                                
                                ForEach(row, id: \.self) { column in
                                    Button(action: {
                                        //Action to be added later.
            
                                        
                                    }, label: {
                                        Text(column)
                                        .font(.system(size: 30))
                                        .frame(idealWidth: 100, maxWidth: .infinity, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                                        .background(getBackground(str: column))
                                        
                                    })
                                    .foregroundColor(Color.white)
                    
                                    
                                    
                                }
                            }
                        }
                    }
                    
                }
                .ignoresSafeArea()
                .frame(width: geometry.size.width * 1, height: geometry.size.height * 0.67)
            }
        }
    }
    
    // This function sets the background color for the operator buttons
    func getBackground(str:String) -> Color {
        
        if checkIfOperator(str: str) {
            return Color.red
        }
        return Color.black
    }
    
    // This function checks if a button is an operator 
    func checkIfOperator(str:String) -> Bool {
        
        if str == "÷" || str == "×" || str == "−" || str == "+" || str == "=" || str == "DEL" || str == "%" || str == "C" {
            return true
        }
        
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
