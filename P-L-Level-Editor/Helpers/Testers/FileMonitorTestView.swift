import SwiftUI

struct FileMonitorTestView: View {
    @ObservedObject var fileMonitor = FileMonitor()

    var body: some View {
        VStack {
            List(fileMonitor.files, id: \.self) { file in
                Text(file)
            }
            Button("Choose Folder") {
                let openPanel = NSOpenPanel()
                openPanel.canChooseFiles = false
                openPanel.canChooseDirectories = true
                openPanel.allowsMultipleSelection = false
                openPanel.begin { (result) in
                    if result == .OK {
                        fileMonitor.url = openPanel.url
                    }
                }
            }
        }
    }
}
