//
//  ContentView.swift
//  IOS Map
//
//  Created by english on 2025-02-12.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject private var locationManager = LocationManager()
    
    // Camera
    @State private var camera: MapCameraPosition = .automatic
    @State private var zoomLevel: Double = 2000
    
    let collegeLaSalle = CLLocationCoordinate2D(latitude: 45.491421, longitude: -73.581238)
    var body: some View {
        ZStack{
            Map(position: $camera){
                Marker("College LaSalle", coordinate: collegeLaSalle)
                
                // check uer pos
                if let userLocation = locationManager.userLocation {
                    Marker("You", coordinate: userLocation)
                }
            }.mapStyle(.standard)
//                .mapStyle(.imagery)
            
            // button for user location
            
            VStack {
                HStack{
                    Spacer()
                    VStack(spacing: 10){
                        Button {
                            print("User Location")
                            goToUserLocation() // not gonna work
                        } label: {
                            Image(systemName: "location.fill")
                                .font(.system(size: 30))
                                .foregroundStyle(.black)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                        }.shadow(radius: 4)
                    }.padding()
                }
                Spacer()
            }
            
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    VStack(spacing: 10) {
                        Button {
                            zoomIn()
                        } label: {
                            Image(systemName: "plus.magnifyingglass")
                                .font(.system(size: 30))
                                .foregroundStyle(.black)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                        }.shadow(radius: 4)
                        
                        Button {
                            zoomOut()
                        } label: {
                            Image(systemName: "minus.magnifyingglass")
                                .font(.system(size: 30))
                                .foregroundStyle(.black)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                        }.shadow(radius: 4)
                    }.padding()
                }
            }
        }
    }
    
    //Zoom in
    private func zoomIn() {
        withAnimation{
            zoomLevel *= 0.8
            camera = .camera(MapCamera(centerCoordinate: locationManager.userLocation ?? collegeLaSalle, distance: zoomLevel))
        }
    }
    
    //Zoom out
    private func zoomOut() {
        withAnimation{
            zoomLevel *= 1.2
            camera = .camera(MapCamera(centerCoordinate: locationManager.userLocation ?? collegeLaSalle, distance: zoomLevel))
        }
    }
    
    //user location
    private func goToUserLocation() {
        if let userLocation = locationManager.userLocation {
            withAnimation {
                camera = .camera(MapCamera(centerCoordinate: userLocation, distance: zoomLevel))
            }
        }
    }
}

#Preview {
    ContentView()
}
