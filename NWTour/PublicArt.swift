//
//  PublicArt.swift
//  NWTour
//
//  Created by Hyojin Yi on 2017-02-26.
//  Copyright © 2017 Hyojin Yi. All rights reserved.
//

import Foundation
import MapKit
import Contacts
// import SwiftyJSON

class Artwork: NSObject, MKAnnotation {
    
    /// Title for annotation view.
    let name: String?
    
    /// Location name for subtitle.
    let address: String
    
    /// Discipline of the artwork.
    let descriptn: String
    
    /// Coordinate data of the artwork location.
    let coordinate: CLLocationCoordinate2D
    
    /// Subtitle for annotation view.
    var subtitle: String? {
        return address
    }
    
    /// Initializer.
    ///
    /// - Parameters:
    ///   - Name: Name of the artwork.
    ///   - Address: Location of the artwork.
    ///   - Descriptn: Category of the artwork.
    ///   - coordinate
    init(name: String, address: String, descriptn: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.address = address
        self.descriptn = descriptn
        self.coordinate = coordinate
        
        super.init()
    }
    
    /// Convert the artwork to a map item as an annotation on map.
    ///
    /// - Returns: Map Item with coordinate.
    func mapItem() -> MKMapItem {
        if let subtitle = subtitle {
            let addressDict = [CNPostalAddressStreetKey: subtitle]
            let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
            
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = name
            
            return mapItem
        } else {
            fatalError("Subtitle is nil")
        }
    }
    
    /// Set up annotation color based on discipline.
    ///
    /// - Returns: THe color for a specific discipline.
    func pinColor() -> UIColor {
        return MKPinAnnotationView.redPinColor()
        
    }
    
    /// Parse JSON data to Artwork model.
    ///
    /// - Parameter json: JSON data to be parsed.
    /// - Returns: Artwork model.
    static func fromJSON(json: [JSONValue]) -> Artwork? {
        let aname     = json[9].string
        let address   = json[4].string
        let descriptn = json[10].string
        
        let latitude  = (json[19].string! as NSString).doubleValue
        let longitude = (json[20].string! as NSString).doubleValue
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        return Artwork(name: aname ?? "", address: address!, descriptn: descriptn!, coordinate: coordinate)
    }
}
