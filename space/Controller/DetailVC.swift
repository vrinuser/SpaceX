//
//  DetailVC.swift
//  space
//
//  Created by Nick on 18/10/18.
//  Copyright © 2018 Krishna. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    
    //MARK:- variable & IBOutlet
    @IBOutlet var lblFlight: UILabel!
      @IBOutlet var lblmasslb: UILabel!
      @IBOutlet var lblname: UILabel!
      @IBOutlet var lblfuels: UILabel!
      @IBOutlet var lblcapacity: UILabel!
    var dictData = NSDictionary()
    var arrTemp = NSArray()
     var arrTemp1 = NSArray()
    var seletedName = NSMutableString()
    var selectedFlight = NSMutableString()
    
    
    //MARK:- Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigationBar()
       self.setUIData()
    
    }
    
    //MARK:- SetUIData Method
    func setUIData(){
  
        if ((dictData.value(forKey: "missions") as? NSArray)?.count)! > 0 {
            
            arrTemp = NSArray()
            arrTemp = ((dictData.value(forKey: "missions") as? NSArray))!
            self.seletedName = NSMutableString()
            for i in stride(from: 0, to: self.arrTemp.count, by: 1){
                let strName =  ((arrTemp.object(at: i) as? NSDictionary)?.value(forKey: "name") as? String)
                self.seletedName.append(strName!)
                self.seletedName.append(",")
            }
            
            if self.seletedName.length > 0 {
                
                let range = NSRange(location: self.seletedName.length - 1, length: 1)
                self.seletedName.replaceCharacters(in: range, with: "")
            }
            print("\(self.seletedName)")
            
            
        lblname.attributedText =  self.setAttributedStringWithBLueColor(str: String(format: "Missions %@%@"," :- ",seletedName ))
            
        } else {
            lblname.attributedText =  self.setAttributedStringWithBLueColor(str: String(format: "Missions %@%@"," :- ","" ))
        }
        
        if ((dictData.value(forKey: "missions") as? NSArray)?.count)! > 0 {
            
            arrTemp1 = NSArray()
            arrTemp1 = ((dictData.value(forKey: "missions") as? NSArray))!
            self.selectedFlight = NSMutableString()
            for i in stride(from: 0, to: self.arrTemp1.count, by: 1){
                let strName1 =  ((arrTemp1.object(at: i) as? NSDictionary)?.value(forKey: "flight") as? NSNumber)
                let str = String(format: "%@", strName1!)
                self.selectedFlight.append(str)
                self.selectedFlight.append(",")
            }
            
            if self.selectedFlight.length > 0 {

                let range = NSRange(location: self.selectedFlight.length - 1, length: 1)
                self.selectedFlight.replaceCharacters(in: range, with: "")
            }
            print("\(self.selectedFlight)")
            
            
           lblFlight.attributedText =  self.setAttributedStringWithBLueColor(str: String(format: "First flight %@%@"," :- ",selectedFlight ))
            
        } else {
           lblFlight.attributedText =  self.setAttributedStringWithBLueColor(str: String(format: "First flight %@%@"," :- ", "" ))
        }
        
      
        lblmasslb.attributedText =  self.setAttributedStringWithBLueColor(str: String(format: "Mass in lb %@%@"," :- ","" ))
        lblfuels.attributedText = self.setAttributedStringWithBLueColor(str: String(format: "Fuels usedt %@%@"," :- ","" ))
        lblcapacity.attributedText = self.setAttributedStringWithBLueColor(str: String(format: "Crew capacity %@%@"," :- ","" ))
        
    }
    //MARK:- SetNavigation
    func setupNavigationBar (){
        UIApplication.shared.statusBarStyle = .lightContent
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 52.0/255.0, green: 44.0/255.0, blue: 81.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.barStyle = UIBarStyle(rawValue: 1)!
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white , NSAttributedStringKey.font: UIFont.systemFont(ofSize: 22)]
        self.navigationItem.title = "Detail"
        self.navigationController?.navigationBar.tintColor = UIColor.init(red: 0/255, green: 231/255, blue: 173/255, alpha: 1)
        
    let btnleft = UIBarButtonItem.init(image: #imageLiteral(resourceName: "back-arrow.png"), style: .plain, target: self, action: #selector(actionBack))
    self.navigationItem.leftBarButtonItem = btnleft
        
    }
    //MARK:- Button Action
    @objc func actionBack()  {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- Attribute String Method
    func setAttributedStringWithBLueColor(str:String) -> NSAttributedString {
        var strCheck = str
        
        var arr = str.components(separatedBy: " : ")
        
        if arr.count != 2 {
            strCheck = str.replacingOccurrences(of: ": ", with: ":")
            strCheck = str.replacingOccurrences(of: " :", with: ":")
            arr = strCheck.components(separatedBy: ":")
            
        }
        let attString = NSMutableAttributedString.init(string: String.init(format: "%@", arr[0]))
        attString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black , range: NSMakeRange(0, attString.length))
        
        let attString1 = NSMutableAttributedString.init(string: String.init(format: "%@", arr[1]))
        
        attString1.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red: 52.0/255.0, green: 44.0/255.0, blue: 81.0/255.0, alpha: 1.0), range: NSMakeRange(0, attString1.length))
        
        attString.append(attString1)
        
        return attString
        
        
    }
   
}
