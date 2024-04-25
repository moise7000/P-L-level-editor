import SwiftUI
import SwiftData

struct AssetsCollectionView: View {
    @Environment(\.modelContext) private var modelContext
    @Query() private var assets: [AssetsDataModel]
    
    @State private var selectedTypeForDetailView: AssetsType = AssetsType.STRUCTURE
    
    var body: some View {
        
        NavigationSplitView {
            List(AssetsType.allCases, id: \.self, selection: $selectedTypeForDetailView) { type in
                Text("\(type)")
            }
        } detail: {
            AssetsCollectionTypedView(type: selectedTypeForDetailView)
                .padding()
        }

        
        
        
        
        

       
        
    }
}


