//
//  BTextField.swift
//  SDLApp
//
//  Created by essadmin on 4/28/16.
//  Copyright © 2016 Baibhav. All rights reserved.
//

import UIKit
import Foundation


class BTextField: UITextField {
    
    var elements:NSArray?
    var currentElement:AnyObject?
    var pickerView = UIPickerView()
    var doneToolbar:UIToolbar?
    
    //If textFld is in Storyboard
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5
        layer.borderColor = UIColor.redColor().CGColor
        layer.borderWidth = 1.0
        pickerView.delegate = self
        pickerView.dataSource = self
        self.inputView = pickerView
        self.inputAccessoryView = setUpToolbar()
        print("Instantiated")
    }
    //if through program
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setUpToolbar()->UIToolbar{
        
       let toolBar = UIToolbar(frame: CGRectMake(0,0,deviceWidth(),44))
       
       let flexibleWidth:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        
       let doneItem:UIBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "pickerDoneAction:")
        
        toolBar.items = [flexibleWidth,doneItem]
        
       return toolBar
        
        
    }
    //MARK: Utils
    func deviceWidth()->CGFloat{
        if let app = UIApplication.sharedApplication().delegate as? AppDelegate, let window = app.window{
            return CGRectGetWidth(window.bounds)
        }
        return 0;
    }
    
    //MARK: Private Methods
    func pickerDoneAction(barButton:UIBarButtonItem){
        self.text = currentElement as? String
        self.resignFirstResponder()
    }
    
    
}

extension BTextField:UIPickerViewDataSource{
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return (elements?.count)!
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return elements![row] as? String
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        currentElement = elements![row] as? String
        self.text = currentElement as? String
    }
}

extension BTextField:UIPickerViewDelegate{
    
}