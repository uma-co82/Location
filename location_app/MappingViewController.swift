//
//  MappingViewController.swift
//  location_app
//
//  Created by 磯崎裕太 on 2019/05/22.
//  Copyright © 2019 HoleFillingCo.,Ltd. All rights reserved.
//

import UIKit
import MapKit

class MappingViewController: UIViewController {

    var latitude:String = ""
    var longitude:String = ""
    
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var toolBar: UIToolbar!
    
    var defaultColor:UIColor!
    
    @IBAction func gotoSpot(_ sender: Any) {
        if let ido = Double(latitude), let keido = Double(longitude){
            // 中央に表示する座標
            let center = CLLocationCoordinate2D(latitude: ido, longitude: keido)
            // スパン(2.22kmx2.22km)
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            // 表示領域
            let theRegion = MKCoordinateRegion(center: center, span: span)
            // 領域の地図表示
            myMap.setRegion(theRegion, animated: true)
        } else {
            return
        }
    }
    
    @IBAction func changedMapType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            myMap.mapType = .standard
            
            myMap.camera.pitch = 0.0
            
            toolBar.tintColor = defaultColor
            toolBar.alpha = 1.0
        case 1:
            myMap.mapType = .satellite
            
            toolBar.tintColor = UIColor.black
            toolBar.alpha = 0.8
        case 2:
            myMap.mapType = .hybrid
            
            toolBar.tintColor = UIColor.black
            toolBar.alpha = 0.8
        case 3:
            myMap.mapType = .standard
            
            toolBar.tintColor = defaultColor
            toolBar.alpha = 1.0
            myMap.camera.pitch = 70
            myMap.camera.altitude = 700
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        defaultColor = toolBar.tintColor
        // Do any additional setup after loading the view.
        
        myMap.showsScale = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
