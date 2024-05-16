import Foundation
import SwiftUI









struct GraphTestView2: View {
    
    
    
    @State var nodes: [DraggableNode]
    @State var edges: [String: [String]]
    
    @State private var zoom: CGFloat = 1.0

    var body: some View {
        
        
        
        NavigationStack{
            ZStack {
                ForEach(nodes.indices) { i in
                    DraggableNodeView(node: $nodes[i])
                }
                ForEach(Array(edges.keys), id: \.self) { key in
                    ForEach(edges[key] ?? [], id: \.self) { edge in
                        Path { path in
                            path.move(to: nodes.first(where: {$0.label == key})?.position ?? CGPoint.zero)
                            path.addLine(to: nodes.first(where: {$0.label == edge})?.position ?? CGPoint.zero)
                        }
                        .stroke(Color.green, lineWidth: 2)
                    }
                }
            }
            .onAppear{
                LevelsGraphFileMonitorSingleton.shared.DEBUG()
            }
            .navigationTitle("Levels Architecture")
            .scaleEffect(zoom)
            .toolbar{
                ToolbarItem{
                    Button{
                        LevelsGraphFileMonitorSingleton.shared.refresh()
                        nodes = LevelsGraphFileMonitorSingleton.shared.getNodes()
                        edges = LevelsGraphFileMonitorSingleton.shared.getEdges()
                    } label: {
                        Image(systemName: "gobackward")
                    }
                }
                
                ToolbarItem {
                    Button{
                        zoom -= 0.1
                    } label: {
                        Image(systemName: "minus")
                    }
                }
                
                ToolbarItem {
                    Button{
                        zoom += 0.1
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
            }

        }
        
        
        
    }
        
}

struct DraggableNodeView2: View {
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




