//
//  ContentView.swift
//  CS50 Final Project
//
//  Created by Alfredo Ormeno Zuniga on 2/26/23.
//

import SwiftUI


let rows = [["C", "%", "÷","DEL"],
            ["7","8", "9", "×"],
            ["4","5","6", "-"],
            ["1", "2", "3", "+"],
            [".", "0", "\u{00B1}", "="]]

let primaryColor = Color.init(red: 25/255, green: 42/255, blue: 86/255, opacity: 1.0)
// rgba(25, 42, 86,1.0)

struct ContentView: View {
    
    @State var screenText = "0"
    @State var number1 = ""
    @State var number2 = ""
    @State var symbol = ""
    
    var body: some View {
        // Will allow us to setupt realtive sizes
        GeometryReader{ geometry in
            // This Vstack holds all elements of the calculator
            VStack(spacing: 0.0){
                // Vstack for screen
                VStack{
                    Text(screenText)
                        .foregroundColor(.white)
                        .font(.system(size:78, weight: .light))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                .padding([.bottom, .trailing])
                .ignoresSafeArea()
                .frame(width: geometry.size.width * 1, height: geometry.size.height * 0.33, alignment: .bottomTrailing)
                .background(primaryColor)
                
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
                                        
                                        getOperator(key: column)
                                        
                                        calculate(key: column)
                                        
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
            return primaryColor
        }
        return Color.black
    }
    
    // This function checks if a button is an operator
    func checkIfOperator(str:String) -> Bool {
        
        if str == "÷" || str == "×" || str == "-" || str == "+" || str == "=" || str == "DEL" || str == "%" || str == "C" || str == "\u{00B1}"{
            return true
        }
        
        return false
    }
    
    // Check if key is an arithmic operator
    func checkIfArithmicOperator(str:String) -> Bool {
        
        if str == "÷" || str == "×" || str == "-" || str == "+"{
            return true
        }
        
        return false
    }
    
    // This function clears the calculator
    func clearValue(){
        screenText = "0"
        number1 = ""
        number2 = ""
        symbol = ""
    }
    
    // This function will delete the last character on the screen
    func deleteChar(){
        if screenText.count > 1 {
            screenText = String(screenText.dropLast())
            if symbol == "" {
                number1 = screenText
            }
            else{
                number2 = screenText
            }
        }
        else if screenText.count == 1{
            screenText = "0"
            
            if symbol == "" {
                number1 = screenText
            }
            else{
                number2 = screenText
            }
        }
        
      
    }
    
    // This function updates the calcualtor screen
    func displayValue(key:String){
        print("function display value")
        //This statement ensures only numbers are dispalyed on the screen
        if checkIfOperator(str: key) || key == "." || key == "\u{00B1}"{
            return
        }
        
        // Screen will only hold a maximum of 11 characters
        if (screenText.count >= 11 && symbol == "") || (symbol != "" && number2.count >= 11) {
            return
        }
        
        if screenText == "0" || (screenText == number1 && symbol != ""){
            screenText = key
        }
        else{
            screenText += key
        }
        
        if symbol == "" {
            number1 = screenText
        }
        else{
            number2 = screenText
        }
        print("Number 1: \(number1)")
        print("Number 2: \(number2)")
        
        
    }
    
    // This function deterines if adding a decimal is valid
    func addDecimal(key:String){
        if (screenText == "0" && key == "."){
            screenText += key
            
            if symbol == "" {
                number1 = screenText
            }
            else{
                number2 = screenText
            }
        }
        
        else if symbol != "" && number2 == "" && key == "."{
            screenText = "0."
            
            if symbol == "" {
                number1 = screenText
            }
            else{
                number2 = screenText
            }
            
        }
        else if !screenText.contains(".") && key == "."{
            screenText += key
            
            if symbol == "" {
                number1 = screenText
            }
            else{
                number2 = screenText
            }
        }
        
    }
    
    
    // This function will only update the operator value "symbol" if the second value has not been stored yet
    func getOperator(key:String){
        if checkIfArithmicOperator(str: key) && number2 == ""{
            symbol = key
            print(symbol)
        }
    }
    
    // Evaluate expression
    func calculate(key:String){
        let floatValue1 = (number1 as NSString).doubleValue
        let floatValue2 = (number2 as NSString).doubleValue
        var result: Double = 0
        
        // TEE HEE, this is my first easter egg!
        if ( key == "="  && number2 == ""){
            if (screenText == "8008132" || screenText == "800813"){
                screenText = "BOOBIES"
                return;
            }
            // Allows user to hit minus, then input value and evaluate to get a negative.
            else{
                result = floatValue1 * 2;
                
                formatResult(value: result, key: key)
            }
        }
        
        else if ( key == "=" || (checkIfArithmicOperator(str: key) && number2 != "")){
            
            if (number2 == "0" && symbol == "÷"){
                screenText = "LMFAO";
                return;
            }
            
            switch symbol{
            case "÷": result = floatValue1 / floatValue2
            case "+": result = floatValue1 + floatValue2
            case "×": result = floatValue1 * floatValue2
            case "-": result = floatValue1 - floatValue2
            default: return
            }
            
            formatResult(value: result, key: key)
        }
    }
    
    func formatResult(value:Double, key:String){
        var result = ""
        
        // Display result to user
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 5
        
        result = formatter.string(from: value as NSNumber)!
        
        if result.count <= 11{
            // Update display to show final formated result
            screenText = result
            // Store result as value 1 and revert value 2 to undefined. Calculator is ready to calculate another expression
            number1 = result
            number2 = ""
        }
        else{
            // If final result is greater than 11 character return error message
            screenText = "Error"
        }
        
        // If user clicked on second opertor symbol, update the symbol value after evaluating previous expresion
        if checkIfArithmicOperator(str: key){
            symbol = key
            print(key)
        }
        else{
            symbol = ""
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
