# EmpowermentLabs-iOS-Technical-test

Recipe application challenge.

# Execution Guide
git clone git@github.com:jorgelm95/EmpowermentLabs-iOS-Technical-test.git
cd EmpowermentLabs-iOS-Technical-test
open workspace: EmpowermentsLabsChallenge.xcworkspace
Environment stack
iOS SDK 14
Swift 5.0
Xcode 14.2

I dont use external libraries for it i config the podfile. 

# Architecture
Used architecture was a mix between MVVM + Clean Architecure concepts. I have create 3 layers UI layer, domain layer and data layer.

# UILayer

In the UIlayer I used de MVVM patther with SuiftUI for the flow data and create the views.

# Domain Layer
in the Domain Layer I have the all bussines logic, here we can find the usecase, and the repository protocols and domain models.

# Data Layer
in the Data layer we can find the all related to networking, repositories implementation and API models

I made the desición used combine for make the calls to API async with that  I do not have a dependency on a third party library to make API calls.

# Architecture Diagram:
<img width="566" alt="image" src="https://user-images.githubusercontent.com/11614252/213077264-1f1c37ef-de0b-4d91-8fb9-1a98cc8d35d9.png">


# Design Patterns, OOP Concepts & Good Programming Practices
UseCases.
Repository.
Low copling.
SOLID Principles.
Inversion of control.
Inheritance.
Views by code.
Generics.


# Features. 

- Search recipes
- Recipe List
- Recipe Detail

Unitary Test:
Unitary test has being developed unider Test Stunt / Test Double methodology wich allow to run all test in a local environment. This methodology is based on five entities:

Stub -> Used.


# things I would have liked to improve in the test, 

- Use a handleError for the whole app to remove that responsibility from the ViewModels.
- Use localized strings for the texts in the. UI 
- Use a better way to do dependency injection for each feature.

# Problems in developing the test.

I have been learning swuift UI and I wanted to do the test in this technology for the views, I had problems to render the data in the list of recipes and it took me some time to organize it, I had the problem of not being able to inject the viewmodel to the views by means of constructor and in the end I had to attach it to its concrete implementation, I know it is bad practice but I could not make the views take the viewmodel with the protocol, I had a type error, and with the implementation of the observable object, I think this can be improved with generics and thus make that each view needs a viewmodel of a base type or generic.

I focused on unit testing and I could not do the implementation to save the favorite recipes.

