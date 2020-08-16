//
//  ViewController.swift
//  Swift5MapAndProtocol1
//
//  Created by 松島優希 on 2020/08/15.
//  Copyright © 2020 松島優希. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate,UIGestureRecognizerDelegate,searchLocationDelegate{
    
    
    
    var addressString = ""
    @IBOutlet var longPress: UILongPressGestureRecognizer!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var locManager:CLLocationManager!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingButton.backgroundColor = .white
        settingButton.layer.cornerRadius = 20.0
        
        
    }

    @IBAction func longPressTap(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began{
            //タップを開始した
        }else if sender.state == .ended{
            //タップを終了
            
            //タップした位置を指定して、MKMapView上の緯度、経度を取得する。
            
            //緯度、経度から住所に変換する
            
            let tapPoint = sender.location(in: view)
            //タップした位置(CGPoint)を指定してMKMapView上の緯度経度を取得する。
            let center = mapView.convert(tapPoint, toCoordinateFrom: mapView)
            let lat = center.latitude
            let log = center.longitude
            
            convert(lat: lat, log: log)
            
        }
        
        
    }
    
    func convert(lat:CLLocationDegrees,log:CLLocationDegrees){
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: log)
        
        //クロージャー
        geocoder.reverseGeocodeLocation(location) { (placeMark,error) in
            //placeMark or errorが入って来たら実行
            
            if let placeMark = placeMark {//placeMarkが空か否か
                
                if let pm = placeMark.first{
                    
                    if pm.administrativeArea != nil || pm.locality != nil{
                        
                        self.addressString = pm.name! + pm.administrativeArea! + pm.locality!
                        
                    }else{
                        self.addressString = pm.name!//県名や市の名前がない場合(南極や北極)
                    }
                    
                    self.addressLabel.text = self.addressString
                }
            }
        }
    }//convert
    
    
    @IBAction func goToSearchVC(_ sender: Any) {
        //画面遷移
        performSegue(withIdentifier: "next", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "next"{
            
            let nextVC = segue.destination as! NextViewController
            nextVC.delegate = self
        }
    }
    
    //まかされたデリゲートメソッド
    func searchLocation(idoValue: String, keidoValue: String) {
        if idoValue.isEmpty != true && keidoValue.isEmpty != true{
            
            let idoString = idoValue
            let keidoString = keidoValue
            
            //緯度経度をもとにコーディネート
            let coordinate  = CLLocationCoordinate2DMake(Double(idoString)!, Double(keidoString)!)
            
            //表示する範囲を指定
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            
            //領域を指定
            let region = MKCoordinateRegion(center: coordinate, span: span)
            //(ピンの生成)
            //領域をMapViewに設定する。
            mapView.setRegion(region, animated: true)
            
            //緯度経度から住所へ変換する。
            convert(lat: Double(idoString)!, log: Double(keidoString)!)
            
            //ラベルに表示
            addressLabel.text = addressString
        }else{
            
            addressLabel.text = "表示できません"
            
        }
        
    }
    
    
}

