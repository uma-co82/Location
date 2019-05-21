//
//  ViewController.swift
//  location_app
//
//  Created by 磯崎裕太 on 2019/05/22.
//  Copyright © 2019 HoleFillingCo.,Ltd. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // Create LocationManager
    var locationManager = CLLocationManager()

    @IBOutlet weak var idoLabel: UILabel!
    @IBOutlet weak var keidoLabel: UILabel!
    @IBOutlet weak var hyoukouLabel: UILabel!
    @IBOutlet weak var henkakuLabel: UILabel!
    @IBOutlet weak var houiLabel: UILabel!
    
    @IBOutlet weak var jihokuSeg: UISegmentedControl!
    @IBOutlet weak var compass: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ラベル初期化
        disabledLocationLabel()
        // 位置情報の利用許可
        locationManager.requestWhenInUseAuthorization()
        // delegateになる
        locationManager.delegate = self
        // ろケーション機能の設定
        setupLocationService()
        // コンパス機能
        startHeadingService()
        
    }

    func setupLocationService() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.distanceFilter = 1
    }
    
    func disabledLocationLabel() {
        idoLabel.adjustsFontSizeToFitWidth = true
        keidoLabel.adjustsFontSizeToFitWidth = true
        hyoukouLabel.adjustsFontSizeToFitWidth = true
        let msg = "位置情報の利用が許可されていない"
        idoLabel.text = msg
        keidoLabel.text = msg
        hyoukouLabel.text = msg
    }
    
    func startHeadingService() {
        jihokuSeg.selectedSegmentIndex = 0
        locationManager.headingOrientation = .portrait
        locationManager.headingFilter = 1
        locationManager.startUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.stopUpdatingLocation()
            disabledLocationLabel()
        default:
            locationManager.stopUpdatingLocation()
            disabledLocationLabel()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationData = locations.last
        
        if var ido = locationData?.coordinate.latitude {
            ido = round(ido*1000000)/1000000
            idoLabel.text = String(ido)
        }
        
        if var keido = locationData?.coordinate.longitude {
            keido = round(keido*1000000)/1000000
            keidoLabel.text = String(keido)
        }
        
        if var hyoukou = locationData?.altitude {
            hyoukou = round(hyoukou*100)/100
            hyoukouLabel.text = String(hyoukou) + " m"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let makita = newHeading.trueHeading
        let jihoku = newHeading.magneticHeading
        
        var henkaku = jihoku - makita
        if henkaku<0 {
            henkaku = henkaku + 360
        }
        henkaku = round(henkaku*100)/100
        henkakuLabel.text = String(henkaku)
        
        var kitamuki:CLLocationDirection!
        if jihokuSeg.selectedSegmentIndex == 0 {
            kitamuki = jihoku
        } else {
            kitamuki = makita
        }
        
        compass.transform = CGAffineTransform(rotationAngle: CGFloat(-kitamuki * Double.pi/180))
        let houikakudo = round(kitamuki*100)/100
        houiLabel.text = String(houikakudo)
    }

}

