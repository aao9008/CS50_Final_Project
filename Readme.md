# CS50 Final Project: iOS/iPad OS Calculator App
#### Video Demo: https://youtu.be/si5lKF2r2Nw
#### Description:

Currently there is no native calculator app on the iPad and the options available on the app store require a purchase or contain ads. This project was created to provide a a simple but effective calculator for iPhones but more importantly also for the iPad. 

This project was created using the Swift programing language for the logic and SwiftUI for the user interface. The calculator provides basic arithmetic operators (subtraction, addition, multiplication, and division). The calculator also provides the ability to add decimals, convert numbers to percents, delete a number, and invert the sign of a number. Furthermore, the standard memory clear and "=" function are available as well. 

#### Calculator Behavior: 

It's important to note how the calculator process calculation. The calculator takes two numbers and performs a calculation according to the operator chosen by the user. If the user enters their first number and immediately tap the "=" button, the value on the screen will be doubled. The calculator will display "Error" if the number of characters exceeds 11/12 characters. 

The calculator will always only store at most two numbers at any given time. If the user enters a number then hits an operator key, enters another number and once again hits another operator key and not the "=" key, the calculator will evaluate the first expression and us this result as the first number to the second expression. 
    
    Example:
    
        This example represent a user enter 2 + 2 then hitting multiplication button instead of the equals button. 
        
        2 + 2 * // This will output 4 on the screen, calculator is now waiting for second number to evaluate second expression
        
        An input  of 2 + 2 * 5 would result in 20.
            
        2 + 2 = 4 -> 4 * 5 = 20
            
Lastly, it's important to note that the "+/-" button will only invert the sign of a number if the value on the screen is not zero or the calculator is not waiting for the input of the second number. Once the user enters a number and taps an operator button, the "+/-" button will remain inactive until user enters new value on the screen. 

#### Closing Statment:

I hope you find this calculator useful and THIS WAS CS50!
        
            
