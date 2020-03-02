//
//  AppDelegate.swift
//  TickledmediaAssignment
//
//  Created by Naveen Gundu on 29/02/20.
//  Copyright © 2020 NG. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }
    
    func createSearch(storyboard: UIStoryboard?) -> UIViewController {
        guard let movieListController = storyboard?.instantiateViewController(withIdentifier: "MoviesListViewController") as? MoviesListViewController else {
            fatalError("Unable to instantiate a NewsController")
        }
        
        let searchController = UISearchController(searchResultsController: movieListController)
        searchController.searchResultsUpdater = movieListController
        
        let searchContainer = UISearchContainerViewController(searchController: searchController)
        searchContainer.title = "Search"
        return searchContainer
    }
    

}

