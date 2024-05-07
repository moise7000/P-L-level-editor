
import SwiftUI

struct PickerTestView: View {
    @State private var selectedNumber = 0

    var body: some View {
        VStack {
            Text("Nombre sélectionné : \(selectedNumber)")
                .font(.title)
            Picker("Sélectionnez un nombre", selection: $selectedNumber) {
                            ForEach(1..<100) {
                                Text("\($0)")
                            }
                        }
                        .labelsHidden()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
