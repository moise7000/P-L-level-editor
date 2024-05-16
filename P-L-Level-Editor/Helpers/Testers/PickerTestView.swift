import SwiftUI

struct GraphTestView: View {
    @State var nodes: [DraggableNode]
    let edges: [Edge]
    
    @State private var zoom: CGFloat = 3.0

    var body: some View {
        
            VStack{
                
                
                ZStack {
                    ForEach(nodes.indices) { i in
                        DraggableNodeView(node: $nodes[i])
                    }
                    ForEach(edges) { edge in
                        Path { path in
                            path.move(to: nodes[edge.start].position)
                            path.addLine(to: nodes[edge.end].position)
                        }
                        .stroke(Color.green, lineWidth: 2)
                    }
                }
                .scaleEffect(zoom)
            }
            
            
        
        
        
        
        
    }
}



struct DraggableNodeView: View {
    @Binding var node: DraggableNode

    var body: some View {
        Text(node.label)
            .font(.title)
            .foregroundStyle(.pink)
            .position(node.position)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        node.position = value.location
                    }
            )
        
        
    }
}


