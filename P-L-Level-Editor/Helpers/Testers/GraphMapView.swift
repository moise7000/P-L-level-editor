//import SwiftUI
//import MapKit
//
//struct GraphMapView: View {
//    @State private var centerCoordinate = CLLocationCoordinate2D()
//    @State private var locations = MKPointAnnotation
//
//    var body: some View {
//        ZStack {
//            MapView(centerCoordinate: $centerCoordinate, annotations: locations)
//                .edgesIgnoringSafeArea(.all)
//            
//            Circle()
//                .fill(Color.blue)
//                .opacity(0.3)
//                .frame(width: 32, height: 32)
//            
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        let newLocation = MKPointAnnotation()
//                        newLocation.coordinate = self.centerCoordinate
//                        self.locations.append(newLocation)
//                    }) {
//                        Image(systemName: "plus")
//                    }
//                    .padding()
//                    .background(Color.black.opacity(0.75))
//                    .foregroundColor(.white)
//                    .font(.title)
//                    .clipShape(Circle())
//                    .padding(.trailing)
//                }
//            }
//        }
//    }
//}
//
//struct MapView: UIViewRepresentable {
//    @Binding var centerCoordinate: CLLocationCoordinate2D
//    var annotations: [MKPointAnnotation]
//
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//        return mapView
//    }
//
//    func updateUIView(_ view: MKMapView, context: Context) {
//        if annotations.count != view.annotations.count {
//            view.removeAnnotations(view.annotations)
//            view.addAnnotations(annotations)
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: MapView
//
//        init(_ parent: MapView) {
//            self.parent = parent
//        }
//
//        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
//            parent.centerCoordinate = mapView.centerCoordinate
//        }
//    }
//}
