//
//  NextViewController.swift
//  Swift5MapAndProtocol1
//
//  Created by 松島優希 on 2020/08/15.
//  Copyright © 2020 松島優希. All rights reserved.
//

import UIKit

protocol searchLocationDelegate {
    func searchLocation(idoValue:String,keidoValue:String)
}

class NextViewController: UIViewController {
    
    @IBOutlet weak var idoTextField: UITextField!
    @IBOutlet weak var keidoTextField: UITextField!
    
    var delegate:searchLocationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func okAction(_ sender: Any) {
        
        //入力された値を取得する。
        let idoValue = idoTextField.text!
        let keidoValue = keidoTextField.text!
        
        //両方のTextFieldが空でなければ戻る。
        
        if idoTextField.text != nil && keidoTextField.text != nil{
            
            //デリゲートメソッドの引数に入れる。
            delegate?.searchLocation(idoValue: idoValue, keidoValue: keidoValue)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    

   
}
