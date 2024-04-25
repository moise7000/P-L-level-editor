import SwiftUI

struct ArrowView: View {
    let a: CGFloat = 1.0
    let b: CGFloat = 70.0
    let c: CGFloat = 2.0
    let d: CGFloat = 10.0
    
    @State private var rotation: Double = 0
    
    var body: some View {
        
        VStack{
            ForEach(0..<2){_ in
                GeometryReader { geometry in
                    let center = geometry.frame(in: .local).center
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.pink.opacity(0.2))
                            .frame(width: 100, height: 100)
                            .border(Color.blue, width: 2)
                        
                        makeAllPassTroughNorth(center: center, a: a, b: b, c: c, d: d)
                            .fill(Color.pink)
                        
                        makeAllPassTroughSouth(center: center, a: a, b: b, c: c, d: d)
                            .fill(Color.pink)
                        
                        makeAllPassTroughEast(center: center, a: a, b: b, c: c, d: d)
                            .fill(Color.pink)
                        
                        makeAllPassTroughWest(center: center, a: a, b: b, c: c, d: d)
                            .fill(Color.pink)
                        
                        
                    }
                    .rotationEffect(.degrees(rotation))
                }
                
                
            }
            
            Button {
                withAnimation {
                    self.rotation += 180
                }
            } label: {
                Text("Press-me")
                    .padding()
            }
            .keyboardShortcut("r", modifiers: .command)
            
        
        }
        .padding()
        
        
        
    }
}

func makeAllPassTroughNorth(center: CGPoint, a:CGFloat, b:CGFloat, c:CGFloat, d:CGFloat) -> Path {
    //MARK: North
   return Path { path in
        path.move(to: center)
        path.addLine(to: CGPoint(x: center.x - a, y: center.y))
        path.addLine(to: CGPoint(x: center.x - a, y: center.y - b))
        path.addLine(to: CGPoint(x: center.x - a - c, y: center.y - b))
        path.addLine(to: CGPoint(x: center.x, y: center.y - b - d))
        path.addLine(to: CGPoint(x: center.x + a + c, y: center.y - b))
        path.addLine(to: CGPoint(x: center.x + a, y: center.y - b))
        path.addLine(to: CGPoint(x: center.x + a, y: center.y))
        path.addLine(to: CGPoint(x: center.x, y: center.y))
        path.closeSubpath()
    }
}

func makeAllPassTroughSouth(center: CGPoint, a:CGFloat, b:CGFloat, c:CGFloat, d:CGFloat) -> Path {
    return Path { path in
        
        path.move(to: center)
        path.addLine(to: CGPoint(x: center.x - a, y: center.y))
        path.addLine(to: CGPoint(x: center.x - a, y: center.y + b))
        path.addLine(to: CGPoint(x: center.x - a - c, y: center.y + b))
        path.addLine(to: CGPoint(x: center.x, y: center.y + b + d))
        path.addLine(to: CGPoint(x: center.x + a + c, y: center.y + b))
        path.addLine(to: CGPoint(x: center.x + a, y: center.y + b))
        path.addLine(to: CGPoint(x: center.x + a, y: center.y))
        path.addLine(to: CGPoint(x: center.x, y: center.y))
        
    }
}



func makeAllPassTroughEast(center: CGPoint, a:CGFloat, b:CGFloat, c:CGFloat, d:CGFloat) -> Path {
  //MARK: East
   return Path { path in
        path.move(to: center)
        path.addLine(to: CGPoint(x: center.x, y: center.y - a))
        path.addLine(to: CGPoint(x: center.x + b, y: center.y - a))
        path.addLine(to: CGPoint(x: center.x + b, y: center.y - a - c))
        path.addLine(to: CGPoint(x: center.x + b + d, y: center.y))
        path.addLine(to: CGPoint(x: center.x + b, y: center.y + a + c))
        path.addLine(to: CGPoint(x: center.x + b, y: center.y + a))
        path.addLine(to: CGPoint(x: center.x, y: center.y + a))
        path.addLine(to: CGPoint(x: center.x, y: center.y))
        
        path.closeSubpath()
    }
}


func makeAllPassTroughWest(center: CGPoint, a:CGFloat, b:CGFloat, c:CGFloat, d:CGFloat) -> Path{
    //MARK: West
   return Path { path in
        path.move(to: center)
        path.addLine(to: CGPoint(x: center.x, y: center.y - a))
        path.addLine(to: CGPoint(x: center.x - b, y: center.y - a))
        path.addLine(to: CGPoint(x: center.x - b, y: center.y - a - c))
        path.addLine(to: CGPoint(x: center.x - b - d, y: center.y))
        path.addLine(to: CGPoint(x: center.x - b, y: center.y + a + c))
        path.addLine(to: CGPoint(x: center.x - b, y: center.y + a))
        path.addLine(to: CGPoint(x: center.x, y: center.y + a))
        path.addLine(to: CGPoint(x: center.x, y: center.y))
        path.closeSubpath()
    }
}







extension CGRect {
    var center: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
}



