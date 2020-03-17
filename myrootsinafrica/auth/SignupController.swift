//
//  SignupController.swift
//  myrootsinafrica
//
//  Created by Darot on 15/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
class CellClass:UITableViewCell{
    
}

class SignupController: UIViewController {
    
    @IBOutlet weak var haveaccounttext: UILabel!
    
    let transparentView = UIView()
    let tableView = UITableView()
    let scrollView = DScrollView()
    var selectedButton = UIButton()
    var dataSource = [String]()
    
    let scrollViewContainer = DScrollViewContainer(axis: .vertical, spacing: 10)
    let scrollViewElement = DScrollViewElement(height: 0, backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))
 
    
    @IBOutlet weak var countryOptionSelector: UIButton!
    override func viewDidLoad() {
        print("Yaay signup")
        tableView.delegate = self as? UITableViewDelegate
        tableView.dataSource = self as? UITableViewDataSource
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
    
    
        
        let languageList = Locale.isoLanguageCodes.compactMap { Locale.current.localizedString(forLanguageCode: $0) }
        let countryList = Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }
        
        print(languageList, countryList)
    }
    
    func addTransparentView(frames:CGRect){
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        
      
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        
        
        
        tableView.frame = viewFrameSize(frames: frames, height:0)
        
        
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
//        scrollView.frame = viewFrameSize(frames: frames, height:0)
//        self.view.addSubview(scrollView)
            
        
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        
        transparentView.addGestureRecognizer(tapGesture)
        
        
        transparentView.alpha = 0
        
        uiViewAnimateAction(using: 0.5, frames:frames, height: Float(dataSource.count * 50))
        
        
        
    }
    
    func uiViewAnimateAction(using alpha:Float, frames:CGRect, height:Float){
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = CGFloat(alpha)
            self.tableView.frame = self.viewFrameSize(frames: frames, height:height)
        }, completion: nil)
    }
    
    func viewFrameSize(frames:CGRect, height:Float)-> CGRect{
        return CGRect(x: frames.origin.x+20, y: frames.origin.y + frames.height + 160, width: frames.width, height: CGFloat(height))
    }
    
    
    @objc func removeTransparentView(){
        let frames = selectedButton.frame
        uiViewAnimateAction(using: 0, frames: frames, height: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        haveaccounttext.underlineText()
        countryAndCodes()
        
    }
    
    @IBAction func selectCountry(_ sender: Any) {
        dataSource = countryAndCodes()
        selectedButton = countryOptionSelector


        addTransparentView(frames: countryOptionSelector.frame)
//        view.sendSubviewToBack(transparentView)
        setUpScrollView()
        tableView.addSubview(scrollViewElement)
        
        

    }
    
    
    
    func countryAndCodes() -> [String]{
        guard let cacListData = CountryAndCode.countryAndCodeString().data(using: .utf8) else { return ["error"] }
        struct countryData:Codable{
            let name:String
            let dialCode:String
            let code:String
            
            private enum CodingKeys:String, CodingKey{
                case name
                case dialCode = "dial_code"
                case code
            }
        }
        
        let countryAndCodeDecoder = JSONDecoder()
        var returnList = [String]()
        do{
            let countries = try countryAndCodeDecoder.decode([countryData].self, from: cacListData)
            for country in countries {
                print(country.name)
                returnList.append(country.name)
                print(country.dialCode)
            }
        }catch{
            "Failed to decode country and code \(error.localizedDescription)"
        }
        return returnList
    }
    
    func setUpScrollView(){
        tableView.addScrollView(scrollView, container: scrollViewContainer, elements: [scrollViewElement])
        
        
        
//                view.addScrollView(scrollView,
//                                        withSafeArea: .top,
//                                   hasStatusBarCover: false,
//                                   statusBarBackgroundColor: .green,
//                                   container: scrollViewContainer,
//                                   elements: [scrollViewElement])
//        scrollViewElement.addSubview(tableView)
        
//                view.sendSubviewToBack(scrollView)
    }
    
 
    
}

extension SignupController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
    }
    
}
