//
//  ContentView.swift
//  Project3
//
//  Created by Batchu Lakshmi Alekhya on 11/07/24.
//

import SwiftUI

struct ContentView: View {
    let circleCount = 12
    let radius: CGFloat = 70
    @State var currentCount = 0
    @State var shapeSelected: ShapeSelected = .circle
    
    var body: some View {
        VStack(spacing: radius) {
            Text(shapeSelected.name)
                .padding(.bottom, 40)
                .font(.title)
                .bold()
            ZStack {
                // Iterate through the current count to create shapes based on the selected shape type
                ForEach(0..<currentCount, id: \.self) { index in
                    // Switch statement to determine which shape to draw based on the selected shape
                    switch shapeSelected {
                    case .square:
                        Rectangle() // Create a square
                            .stroke(.green, lineWidth: 6) // Outline the square with a green stroke
                            .position(position(for: index)) // Position the square using the custom position function
                            .transition(.scale) // Apply a scale transition for animations
                            .frame(width: radius, height: radius) // Set the frame size for the square
                    case .rectangle:
                        Rectangle() // Create a rectangle
                            .stroke(.orange, lineWidth: 6) // Outline the rectangle with an orange stroke
                            .position(position(for: index)) // Position the rectangle using the custom position function
                            .transition(.scale) // Apply a scale transition for animations
                            .frame(width: radius, height: radius / 2) // Set the frame size for the rectangle
                    case .circle:
                        Circle() // Create a circle
                            .stroke(.blue, lineWidth: 6) // Outline the circle with a blue stroke
                            .position(position(for: index)) // Position the circle using the custom position function
                            .transition(.scale) // Apply a scale transition for animations
                    case .triangle:
                        Triangle() // Create a triangle
                            .stroke(.red, lineWidth: 6) // Outline the triangle with a red stroke
                            .position(position(for: index)) // Position the triangle using the custom position function
                            .transition(.scale) // Apply a scale transition for animations
                            .frame(width: radius, height: radius) // Set the frame size for the triangle
                    case .ellipse:
                        Ellipse() // Create an ellipse
                            .stroke(.pink, lineWidth: 6) // Outline the ellipse with a pink stroke
                            .position(position(for: index)) // Position the ellipse using the custom position function
                            .transition(.scale) // Apply a scale transition for animations
                            .frame(width: radius, height: radius / 2) // Set the frame size for the ellipse
                    case .pentagon:
                        Pentagon() // Create a pentagon
                            .stroke(.purple, lineWidth: 6) // Outline the pentagon with a purple stroke
                            .position(position(for: index)) // Position the pentagon using the custom position function
                            .transition(.scale) // Apply a scale transition for animations
                    }
                }
            }
            .frame(width: 2 * radius, height: 2 * radius) // Set the size of the ZStack to fit all shapes and maintain arrangement to have pattern
            .onAppear {
                addCirclesWithAnimation()
            }
            HStack(spacing: 20) {
                Circle()
                    .fill(.blue)
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        currentCount = 0
                        shapeSelected = .circle
                        addCirclesWithAnimation()
                    }
                Rectangle()
                    .fill(.green)
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        currentCount = 0
                        shapeSelected = .square
                        addCirclesWithAnimation()
                    }
                Triangle()
                    .fill(.red)
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        currentCount = 0
                        shapeSelected = .triangle
                        addCirclesWithAnimation()
                    }
                Rectangle()
                    .fill(.orange)
                    .frame(width: 60, height: 30)
                    .onTapGesture {
                        currentCount = 0
                        shapeSelected = .rectangle
                        addCirclesWithAnimation()
                    }
                Ellipse()
                    .fill(.pink)
                    .frame(width: 60, height: 30)
                    .onTapGesture {
                        currentCount = 0
                        shapeSelected = .ellipse
                        addCirclesWithAnimation()
                    }
                Pentagon()
                    .fill(.purple)
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        currentCount = 0
                        shapeSelected = .pentagon
                        addCirclesWithAnimation()
                    }
            }
            .padding(.top, 40)
            .padding(.bottom, 40)
        }
    }
    
    private func position(for index: Int) -> CGPoint {
        let angle = (Double(index) / Double(circleCount)) * 2 * .pi
        var xAxis: CGFloat = 0
        var yAxis: CGFloat = 0
        switch shapeSelected {
        case .square:
            xAxis = radius * cos(angle) + (radius/2)
            yAxis = radius * sin(angle) + (radius/2)
        case .rectangle:
            xAxis = radius * cos(angle) + (radius/2)
            yAxis = radius * sin(angle) + (radius/2)
        case .circle, .pentagon:
            xAxis = radius * cos(angle) + radius
            yAxis = radius * sin(angle) + radius
        case .triangle:
            xAxis = radius * cos(angle) + (radius/2)
            yAxis = radius * sin(angle) + (radius/2)
        case .ellipse:
            xAxis = radius * cos(angle) + (radius/2)
            yAxis = radius * sin(angle) + (radius/2)
        }
        return CGPoint(x: xAxis, y: yAxis)
    }
    
    func addCirclesWithAnimation() {
        // Create a timer that fires every 0.3 seconds
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            // Wrap the code in withAnimation to ensure changes are animated
            withAnimation {
                // Check if the current number of circles is less than the total desired count
                if currentCount < circleCount {
                    // Increment the current count, adding a new circle
                    currentCount += 1
                } else {
                    // If the desired count is reached, invalidate (stop) the timer
                    timer.invalidate()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

enum ShapeSelected {
    case square
    case rectangle
    case circle
    case triangle
    case ellipse
    case pentagon
    
    var name: String {
        switch self {
        case .square:
            return "SQUARE"
        case .rectangle:
            return "RECTANGLE"
        case .circle:
            return "CIRCLE"
        case .triangle:
            return "TRIANGLE"
        case .ellipse:
            return "ELLIPSE"
        case .pentagon:
            return "PENTAGON"
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            // Start at the top middle of the rectangle
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            
            // Draw a line to the bottom right corner of the rectangle
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            
            // Draw a line to the bottom left corner of the rectangle
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
            // Draw a line back to the top middle of the rectangle to close the triangle
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Pentagon: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            // Start at the top middle of the rectangle
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            
            // Draw a line to the middle of the right side of the rectangle
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            
            // Draw a line to a point slightly to the left of the bottom right corner of the rectangle
            path.addLine(to: CGPoint(x: rect.maxX - 7.5, y: rect.maxY))
            
            // Draw a line to a point slightly to the right of the bottom left corner of the rectangle
            path.addLine(to: CGPoint(x: rect.minX + 7.5, y: rect.maxY))
            
            // Draw a line to the middle of the left side of the rectangle
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            
            // Close the path by drawing a line back to the starting point at the top middle of the rectangle
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}
