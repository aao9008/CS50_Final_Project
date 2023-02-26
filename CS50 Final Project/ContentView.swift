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
    
    @State var value = "0"
    @State var value2 = ""
    @State var symbol = ""
    
    var body: some View {
        // Will allow us to setupt realtive sizes
        GeometryReader{ geometry in
            // This Vstack holds all elements of the calculator
            VStack(spacing: 0.0){
                // Vstack for screen
                VStack{
                    Text(value)
                        .foregroundColor(.white)
                        .font(.system(size:78, weight: .light))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                .padding([.bottom, .trailing])
                .ignoresSafeArea()
                .frame(width: geometry.size.width * 1, height: geometry.size.height * 0.33, alignment: .bottomTrailing)
                .background(.red)
                
                Spacer(minLength: 24)
                
                VStack{
                    VStack(spacing: 0){
                        ForEach(rows, id: \.self) { row in
                            
                            HStack(alignment: .top, spacing: 0) {
                                
                                Spacer(minLength: 13)
                                
                                ForEach(row, id: \.self) { column in
                                    Button(action: {
                                        //Action to be added later.
                                        displayValue(key: column)
                                        
                                        addDecimal(key: column)
                                        
                                        if column == "C"{
                                            clearValue()
                                        }
                                        
                                        if column == "DEL"{
                                            deleteChar()
                                        }
                                    
            
                                        
                                    }, label: {
                                        Text(column)
                                        .font(.system(size: 30))
                                        .frame(idealWidth: 100, maxWidth: .infinity, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                                        
                                        
                                        
                                        
                                    })
                                    .foregroundColor(Color.white)
                                    .background(getBackground(str: column))
                                    .mask(CustomShape(radius: 40, value: column))
                                    
                                    
                    
                                    
                                    
                                }
                            }
                        }
                    }
                    
                }
                .ignoresSafeArea()
                .frame(width: geometry.size.width * 1, height: geometry.size.height * 0.67)
            }
            .background(.black)
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
        
        if str == "÷" || str == "×" || str == "−" || str == "+" || str == "=" || str == "DEL" || str == "%" || str == "C" || str == "\u{00B1}"{
            return true
        }
        
        return false
    }
    
    // This function clears the calculator
    func clearValue(){
        value = "0"
    }
    
    // This function will delete the last character on the screen
    func deleteChar(){
        if value.count != 1 {
            value = String(value.dropLast())
        }
    }
    
    // This function updates the calcualtor screen
    func displayValue(key:String){
        //This statement ensures only numbers are dispalyed on the screen
        if checkIfOperator(str: key) || key == "." || key == "\u{00B1}"{
            return
        }
        
        // Screen will only hold a maximum of 11 characters
        if value.count < 11 {
            // If screen is in intial state, clear default value
            if value == "0"{
                value = key
            }
            // Append character if screen is not on default value
            else{
                value += key
            }
            
        }
        
    }
    
    // This function deterines if adding a decimal is valid
    func addDecimal(key:String){
        if value == "0" && key == "."{
            value += key
        }
        else if !value.contains(".") && key == "."{
            value += key
        }
    }
    
    
    // The CustomShape function was retrieved from https://medium.com/digital-curry/how-i-created-a-beautiful-calculator-in-less-than-200-loc-with-swiftui-f1640504a50d
    
    struct CustomShape: Shape {
        let radius: CGFloat
        let value: String
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            let tl = CGPoint(x: rect.minX, y: rect.minY)
            let tr = CGPoint(x: rect.maxX, y: rect.minY)
            let br = CGPoint(x: rect.maxX, y: rect.maxY)
            let bl = CGPoint(x: rect.minX, y: rect.maxY)
            
            let tls = CGPoint(x: rect.minX, y: rect.minY+radius)
            let tlc = CGPoint(x: rect.minX + radius, y: rect.minY+radius)
            
            path.move(to: tr)
            path.addLine(to: br)
            path.addLine(to: bl)
            if value == "C" || value == "\u{00B1}" {
                path.addLine(to: tls)
                path.addRelativeArc(center: tlc, radius: radius, startAngle: Angle.degrees(90), delta: Angle.degrees(180))
            }
            else {
                path.addLine(to: tl)
            }
            
            return path
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
