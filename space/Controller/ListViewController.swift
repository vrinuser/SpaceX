//
//  ViewController.swift
//  space
//
//  Created by Nick on 18/10/18.
//  Copyright © 2018 Krishna. All rights reserved.
//

import UIKit
import  Alamofire

class ListViewController: UIViewController {
    
    //MARK:- variable & IBOutlet
    @IBOutlet weak var tblSpaceList: UITableView!
    var arrSpace = NSMutableArray()
    var temp = NSMutableArray()
    var arrTemp = NSArray()
    var seletedName = NSMutableString()
    
    
    //MARK:- Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        tblSpaceList.isHidden = true
       spaceApiCall()
    }
    
    //MARK:- SpaceApiCall
    func spaceApiCall(){
        
          let loader = SwiftActivityLoader.startActivityLoader(onView: self.view)
        
        Alamofire.request("https://api.spacexdata.com/v3/capsules").responseJSON { (response:DataResponse!) in
            
            switch(response.result) {
                
            case .success(_):
                
                if response.result.value != nil{
                    print(response.result.value as Any )
                    print("response.result.value:- \(String(describing: response.result.value))")
                    SwiftActivityLoader.stopActivityLoader(loaderView: loader)
                    self.temp  = ((response.result.value as? NSArray)?.mutableCopy() as? NSMutableArray)!
                    self.arrSpace = NSMutableArray()
                    for i in 0 ..< self.temp.count {
                        
                        if let strLaunch = (self.temp[i] as? NSDictionary)?.value(forKey:"original_launch") as? String{
                            let strYear = self.yearconvertDateFormater(strLaunch)
                            print(strYear)
                            let year = (Int)(strYear)
                            if  year! >= 2014{
                                self.arrSpace.add(self.temp[i])
                            }
                            
                        } else {
                            
                        }
                   
                    }
                    
                    print(self.arrSpace)

                    if self.arrSpace.count > 0 {
                        self.tblSpaceList.isHidden = false
                        self.tblSpaceList.delegate = self
                        self.tblSpaceList.dataSource = self
                        self.tblSpaceList.reloadData()
                    } else  {
                        self.tblSpaceList.isHidden = true
                    }
                    
                }
                break
                
            case .failure(_):
                
                print("response.result.error:- \(String(describing: response.result.error))")
                
                break
            }
        }
    
    }
    //MARK:- SetNavigation
    func setupNavigationBar (){
        UIApplication.shared.statusBarStyle = .lightContent
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 52.0/255.0, green: 44.0/255.0, blue: 81.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white , NSAttributedStringKey.font: UIFont.systemFont(ofSize: 22)]
        self.navigationItem.title = "List"
       
        self.navigationController?.navigationBar.barStyle = UIBarStyle(rawValue: 1)!
        self.navigationController?.navigationBar.tintColor = UIColor.init(red: 0/255, green: 231/255, blue: 173/255, alpha: 1)
        tblSpaceList.register(UINib(nibName: "SpaceTableViewCell", bundle: nil), forCellReuseIdentifier: "SpaceTableViewCell")
    }

}
//MARK:- UITableViewDelegate & UITableViewDataSource
extension ListViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSpace.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblSpaceList.dequeueReusableCell(withIdentifier: "SpaceTableViewCell", for: indexPath) as! SpaceTableViewCell
        cell.selectionStyle = .none
        if ((arrSpace[indexPath.row] as? NSDictionary)?.value(forKey:"original_launch") as? String) != nil{
            let str = convertDateFormater(((arrSpace[indexPath.row] as? NSDictionary)?.value(forKey:"original_launch") as? String)!)
            print(str)
            cell.lblDate.attributedText =
                self.setAttributedStringWithBLueColor(str: String(format: "Original date of launch %@%@"," :- ", str))
        } else  {
            cell.lblDate.attributedText =
                self.setAttributedStringWithBLueColor(str: String(format: "Original date of launch %@%@"," :- ", ""))
        }
        if let strDetail = (arrSpace[indexPath.row] as? NSDictionary)?.value(forKey:"details") as? String{
            
            cell.lblDetail.attributedText =  self.setAttributedStringWithBLueColor(str: String(format: "Details %@%@"," :- ",strDetail ))
        } else  {
              cell.lblDetail.text = ""
        }
        
       
        if let strStatus = (arrSpace[indexPath.row] as? NSDictionary)?.value(forKey:"status") as? String{
         
              
                cell.lblStatus.attributedText = self.setAttributedStringWithBLueColor(str: String(format: "Status %@%@"," :- ", strStatus))
            

        } else  {
           cell.lblStatus.attributedText = self.setAttributedStringWithBLueColor(str: String(format: "Status %@%@"," :- ", ""))
        }
        
        if (((arrSpace[indexPath.row] as? NSDictionary)?.value(forKey: "missions") as? NSArray)?.count)! > 0 {
            
            arrTemp = NSArray()
            arrTemp = (((arrSpace[indexPath.row] as? NSDictionary)?.value(forKey: "missions") as? NSArray))!
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
            
            
            cell.lblName.attributedText =  self.setAttributedStringWithBLueColor(str: String(format: "Missions %@%@"," :- ",seletedName))
            
        } else {
              cell.lblName.attributedText =  self.setAttributedStringWithBLueColor(str: String(format: "Missions %@%@"," :- ",""))
        }
      
        if let strLanding = (arrSpace[indexPath.row] as? NSDictionary)?.value(forKey:"landings") as? NSNumber{
            
            cell.lblLanding.attributedText =   self.setAttributedStringWithBLueColor(str: String(format: "Number of landings %@%@"," :- ",strLanding ))
        } else  {
            cell.lblLanding.attributedText =   self.setAttributedStringWithBLueColor(str: String(format: "Number of landings %@%@"," :- ","" ))
        }
        
        
       
        if let strType = (arrSpace[indexPath.row] as? NSDictionary)?.value(forKey:"type") as? String {
            cell.lblType.attributedText = self.setAttributedStringWithBLueColor(str: String(format: "Type %@%@"," :- ",strType ))
         
        } else {
            cell.lblType.attributedText = self.setAttributedStringWithBLueColor(str: String(format: "Type %@%@"," :- ","" ))
        }
        
       
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailVC") as? DetailVC
        detailVC?.dictData = (arrSpace[indexPath.row] as? NSDictionary)!
        self.navigationController?.pushViewController(detailVC!, animated: true)
    }

    //MARK:- Date Convert Method
    func convertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date!)
        
    }
    //MARK:- Date Convert year Method
    func yearconvertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy"
        return  dateFormatter.string(from: date!)
        
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

