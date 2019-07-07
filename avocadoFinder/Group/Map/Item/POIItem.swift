//
//  POIItem.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/27/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import CoreLocation
import GoogleMaps

class POIItem: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
    var shopId: String!
    var iconView: UIImageView!
    
    init(position: CLLocationCoordinate2D, shopId: String, iconView: UIImageView!) {
        self.position = position
        self.shopId = shopId
        self.iconView = iconView
    }
}

//MARK: -
//MARK: - Clustering

class ClusterRender: GMUDefaultClusterRenderer {
    
    override func shouldRender(as cluster: GMUCluster, atZoom zoom: Float) -> Bool {
        return cluster.count > 1
    }
    
}

class IconGenerator: GMUDefaultClusterIconGenerator {
    override func icon(forSize size: UInt) -> UIImage {
        return UIImage(named: "shopPin")!
    }
}


