//
//  AppSetup.swift
//  spotter
//
//  Created by Mark Anthony Molina on 23/04/2020.
//  Copyright © 2020 dakke dak. All rights reserved.
//

import Foundation
import Firebase
import GoogleMaps

class AppSetup {
    
    init() {
        
        setupDependancies()
    }
    
    private func setupDependancies() {
        
        var dictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
           
            dictionary = NSDictionary(contentsOfFile: path)
            
            FirebaseApp.configure()
            
            if let apiKey = dictionary?["GOOGLE_MAPS_API_KEY"] as? String {
                GMSServices.provideAPIKey(apiKey)
            }
            
        }
    }
}
