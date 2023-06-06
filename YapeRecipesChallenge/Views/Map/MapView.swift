//
//  MapView.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 03/06/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var viewModel = MapLocationsViewModel()
    let recipe: Recipe
    
    var body: some View {
        ZStack {
            Map(
                coordinateRegion: $viewModel.coordinateRegion,
                annotationItems: [viewModel.cityCoordinate].compactMap { $0 }) { location in
                    MapMarker(coordinate: location)
                }
                .edgesIgnoringSafeArea([
                    .bottom,
                    .leading,
                    .trailing])
                .background(LinearGradient(
                    gradient:
                        Gradient(
                            colors: [
                                Color(hex: "#5f92cb"),
                                Color(hex: "#030f13")]),
                    startPoint: .top,
                    endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
                .modifier(NavigationBarModifier(
                    color: Color(hex: "#3C3190"), opacity: 0.4))
                .onAppear {
                    setMarker()
                }
            VStack {
                Spacer()
                MapRecipeCardView(recipe: recipe)
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: 200)
            }
        }
    }

    private func setMarker() {
        do {
            try viewModel
                .searchForCity(city: recipe.origin.city)
                .sink { completion in
                    print("completed")
                } receiveValue: { coordinate in
                    if let coordinate = coordinate {
                        viewModel.cityCoordinate = coordinate
                        viewModel.coordinateRegion = MKCoordinateRegion(
                            center: coordinate,
                            span: MKCoordinateSpan(
                                latitudeDelta: 3,
                                longitudeDelta: 3))
                    }
                }
                .store(in: &viewModel.subscriptions)
        } catch {
            print("error \(error)")
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(recipe: Recipe.stubbedRecipes[0])
    }
}
