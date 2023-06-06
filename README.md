# YapeRecipesChallenge

An app that shows recipes from all around the world and see where the recipe is orginary from in a Map. The app uses a mockable website endpoint to get the data from.

# App Requirements

- XCode
- iOS Simulator

# Setup

- Clone the repository`git clone https://github.com/FdoIv7/YapeRecipesChallenge.git` in Terminal
- `cd` into directory in Terminal
- Open `YapeRecipesChallenge.xcodeproj`
- Choose a simulator and run the app

# Dependencies

There are no third party libraries or dependecies being used for this project
URL for recipes: http://demo4677561.mockable.io/recipes_world

# Architecture 

This project was built using Modern iOS Development. Using libraries like:

- SwiftUI
- Combine
- Async/Await
- MapKit
- CoreLocation

The project was built using MVVM Architecture, SOLID Principles and clean architecture. MVVM was chosen for the way it decouples all different layers of the app, leaving the whole business logic to the viewModels, successfuly separating UI, Data and ViewModels. SwiftUI plays really nicely with MVVM, that's another reason why the MVVM Architecture Pattern was chosen, since a couple of years back, this has been the way Apple is pushing developers to build iOS Apps. The app also uses a bit of reactive programming with Combine framework and all concurrency work is achieved using Async/Await.

We use a Protocol Oriented Approach with a heavy focus on Services, the main reason for this being to make ViewModels and Services a lot more testable, we can easily mock Protocol objects. Unit Testing are implemented for both Services and ViewModels, just to show the flexibility for this approach.
