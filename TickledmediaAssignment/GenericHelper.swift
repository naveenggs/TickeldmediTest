//
//  GenericHelper.swift
//  TickledmediaAssignment
//
//  Created by Naveen Gundu on 29/02/20.
//  Copyright © 2020 NG. All rights reserved.
//

import UIKit
import CoreGraphics
import Foundation
import Kingfisher


//func debugPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
//    #if DEBUG
//    Swift.debugPrint(items[0], separator:separator, terminator: terminator)
//    #endif
//}
//
//func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
//    #if DEBUG
//    Swift.print(items[0], separator:separator, terminator: terminator)
//    #endif
//}

class GenericHelper {
    
    func applyLayerShadowBlack(_ object : UIView)
    {
        object.layer.masksToBounds = false;
        object.layer.shadowColor = UIColor.lightGray.cgColor
        object.layer.shadowOffset = CGSize.init(width: 0.0, height: 2.0)
        object.layer.shadowOpacity = 0.8
        object.layer.shadowRadius = 2.0
    }
    
    func applyLayerShadowLightBlack(_ object : UIView)
    {
        object.layer.masksToBounds = false;
        object.layer.shadowColor = UIColor.lightGray.cgColor
        object.layer.shadowOffset = CGSize.init(width: 0.0, height: 1.0)
        object.layer.shadowOpacity = 0.8
        object.layer.shadowRadius = 1.0
    }
    
    func applyLayerShadow(_ object : UIView)
    {
        object.layer.masksToBounds = false;
        object.layer.shadowColor = UIColor.blue.cgColor
        object.layer.shadowOffset = CGSize.init(width: 0, height: 2)
        object.layer.shadowRadius = 0.5
        object.layer.shadowOpacity = 0.4
    }
    
    func GETSecondsToHoursMinutesSeconds (_ seconds:Int) -> String {
        
        var finalV = String()
        
        let (h, m, s) = self.secondsToHoursMinutesSeconds(seconds: seconds)
        
        let final = "\(h):\(m):\(s)"
        
        if h != 0{
            
            finalV = "\(h):\(m):\(s)"
            
        }else if m != 0{
            
            finalV = "\(m):\(s)"
            
        }else{
            
            finalV = "00:\(s)"
        }
        
        return finalV
        
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    
    
    func removeAnimationfromTableview(_ tableView:UITableView) {
        
        let loc = tableView.contentOffset
        UIView.performWithoutAnimation {
            
            tableView.reloadData()
            tableView.layoutIfNeeded()
            tableView.beginUpdates()
            tableView.endUpdates()
            tableView.layer.removeAllAnimations()
        }
        tableView.setContentOffset(loc, animated: true)
        
    }
    
    func removeAnimationfromCollectionview(_ collectionview:UICollectionView) {
        
        let loc = collectionview.contentOffset
        UIView.performWithoutAnimation {
            
            collectionview.reloadData()
            collectionview.layoutIfNeeded()
            collectionview.layer.removeAllAnimations()
        }
        collectionview.setContentOffset(loc, animated: true)
        
    }
    
    func getDatefromTimeStamp(_ timeStamp:Int) -> Date {
        
        //let timeStamp = 1513330403393
        let unixTimeStamp: Double = Double(timeStamp) / 1000.0
        let exactDate = NSDate.init(timeIntervalSince1970: unixTimeStamp)
        let dateFormatt = DateFormatter();
        dateFormatt.dateFormat = "dd-MM-yyy"
        let final = dateFormatt.string(from: exactDate as Date)
        let NdateFormatter = DateFormatter()
        NdateFormatter.dateFormat = "dd-MM-yyy"
        //dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let Ndate = NdateFormatter.date(from:final)!
        return Ndate
    }
    
    func ConvertMillisecondsIntoDate(_ value:Int) -> Date {
        
        let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(value))
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy HH:mm:ss"
        let nDate = dateFormatter.string(from: dateVar)
        print("Ndate...",nDate)
        
        //        print(dateFormatter.string(from: dateVar))
        //let Ndate = dateFormatter.date(from: dateString as String)

        return dateVar
    }
    
    func timeAgoSinceDate(_ DateValue:Date) -> String {
        
        // From Time
        let fromDate = DateValue
        
        //let toDate = DateValue
        // To Time
         let toDate = Date()
        
        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "year ago" : "\(interval)" + " " + "years ago"
        }
        
        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
        }
        
        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "day ago" : "\(interval)" + " " + "days ago"
        }
        
        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "hour ago" : "\(interval)" + " " + "hours ago"
        }
        
        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "minute ago" : "\(interval)" + " " + "minutes ago"
        }
        
        return "a moment ago"
    }
    
    func stringToNDate(_ dateStr:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss" // Your date format
        let serverDate: Date = dateFormatter.date(from: dateStr)! // according to date format your date string
        return serverDate
    }
    
    func daysBetweenDatesN(_ startDate: Date, _ endDate: Date) -> Int {
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)
        
        return components.day!
    }
    
    func collectionViewScrolltoBottom(_ collVW:UICollectionView) {
        
        let lastSection = collVW.numberOfSections - 1
        
        let lastRow = collVW.numberOfItems(inSection: lastSection)
        
        let indexPath = IndexPath(row: lastRow - 1, section: lastSection)
        
        collVW.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }

    
    func resizeImage(image: UIImage) -> UIImage {
        
        var actualHeight: Float = Float(image.size.height)
        var actualWidth: Float = Float(image.size.width)
        let maxHeight: Float = 1200.0
        let maxWidth: Float = 756.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.1
        //70 percent compression
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img?.jpegData(compressionQuality: CGFloat(compressionQuality))
        //img!.UIImageJPEGRepresentation(compressionQuality: CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!)!
    }
    
    func downloadandNsetIamge(_ urlStr:String, _ img:UIImageView){

         let url = URL(string:urlStr)
        img.kf.setImage(with: url)

    }
    
    func isValidName(_ string:String) -> Bool {
        
        let emailRegEx = "[A-Za-z]{4,42}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: string)
    }
    
    func openCordinatesonGoogleMaps(_ lattitude:Double, _ longitude:Double) {
       
        if (UIApplication.shared.canOpenURL(NSURL(string:"https://maps.google.com")! as URL))
        {
            UIApplication.shared.openURL(URL(string:
                "https://maps.google.com/?q=@\(lattitude),\(longitude)")! as URL)
        }
        
    }
    
    func getLocationURL(_ LatValue:Double, _ LongValue:Double) -> String {
        
        return "https://maps.google.com/?q=@\(LatValue),\(LongValue)"
    }
    
    func showVCAlert(_ title:String, _ message:String, _ VC:UIViewController) {
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            
        })
        alertView.addAction(action)
        
        DispatchQueue.main.async {
            
            VC.present(alertView, animated: true, completion: nil)
        }
    }
    
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func convertToArray(text: String) -> [Any]? {
        
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func call(_ phoneNumber: String) {
        
        let cleanNumber = phoneNumber.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
        guard let number = URL(string: "telprompt://" + cleanNumber) else { return }
        
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, imageView:UIImageView) {
        print("Download Started")
        let actityVity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        actityVity.center = imageView.center
        actityVity.hidesWhenStopped = false
        actityVity.startAnimating()
        imageView.addSubview(actityVity)
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                imageView.image = UIImage(data: data)
                actityVity.stopAnimating()
                actityVity.removeFromSuperview()
            }
        }
    }
    
    func animateTextField(textField: UITextField, up: Bool, mvieW:UIView)
    {
        let movementDistance:CGFloat = -60
        let movementDuration: Double = 0.3
        
        var movement:CGFloat = 0
        if up
        {
            movement = movementDistance
        }
        else
        {
            movement = -movementDistance
        }
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        mvieW.frame = mvieW.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func applyTFEffect(_ tf:UITextField) {
        
        tf.borderStyle = .none
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1.0
        tf.layer.cornerRadius = 10.0
        tf.layer.masksToBounds = true
        tf.clipsToBounds = true
        
    }
    
    //Present
    func customPush(_ dynamicVC : UIViewController, viewControler: UIViewController, animation : Bool){
        /*let transition = CATransition()
         transition.duration = 0.5
         transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
         transition.type = kCATransitionPush
         transition.subtype = kCATransitionFromTop
         dynamicVC.navigationController?.view.layer.add(transition, forKey: kCATransition)*/
        dynamicVC.navigationController?.pushViewController(viewControler, animated: animation)
    }
    
    //dismiss
    func customPop(_ dynamicVC : UIViewController, to viewController: AnyClass?, animation : Bool){
        
        if let vc = viewController{
            for viewController in (dynamicVC.navigationController?.viewControllers)!{
                if viewController.isKind(of: vc) {
                    let controller = viewController
                    dynamicVC.navigationController?.dismiss(animated: true, completion: nil)
                    dynamicVC.navigationController?.popToViewController(controller, animated: animation)
                }
            }
        }else{
            dynamicVC.navigationController?.dismiss(animated: true, completion: nil)
            dynamicVC.navigationController?.popViewController(animated: animation)
        }
    }
    
    func customPopToRootViewController(_ dynamicVC : UIViewController, animation : Bool){
        /* let transition = CATransition()
         transition.duration = 0.5
         transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
         transition.type = kCATransitionPush
         transition.subtype = kCATransitionFromBottom
         dynamicVC.navigationController?.view.layer.add(transition, forKey: kCATransition)*/
        dynamicVC.navigationController?.popToRootViewController(animated: animation)
    }
    
    func isNameValid(_ nameStr:String) -> Bool {
        
        let nameRegEx = "[A-Za-z]{3,62}"
        
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        
        return nameTest.evaluate(with: nameStr)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func nullToNil(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }
    
    func nullToNilWithTypeCheck<T>(value : AnyObject? , type: T.Type) -> AnyObject?{
        
        if value is NSNull {
            
            return nil
        } else {
            if value is T {
                if value is String{
                    if (value as! String) != ""{
                        return value
                    }else{
                        return nil
                    }
                }
                if value is [Any]{
                    if (value as! [Any]).count > 0{
                        return value
                    }else{
                        return nil
                    }
                }
                if value is Dictionary<String,Any>{
                    if (value as! Dictionary<String,Any>).count > 0{
                        return value
                    }else{
                        return nil
                    }
                }
                return value
            } else {
                return nil
            }
        }
    }
    
    func removeDuplicateObjectsfromArray(data:[Any]) -> [Any] {
        
        var final = [Any]()
        let set = NSSet(array: data)
        final = set.allObjects
        
        return final
    }
    
    func stringHavingSpecialCharacters(_ inputString:  String, _ type: String?, spaceCheck : Bool,allowSpecialChar  : String?) -> Bool{
        var isValid = true
        let trimmedString = inputString.trimmingCharacters(in: .whitespacesAndNewlines)
        if type != nil{
            if type == "number"{
                var characterset = CharacterSet(charactersIn: "0123456789")
                if !spaceCheck{
                    characterset.insert(charactersIn: " ")
                }
                if allowSpecialChar != nil{
                    characterset.insert(charactersIn: allowSpecialChar ?? "")
                }
                if trimmedString.rangeOfCharacter(from: characterset.inverted) != nil {
                    isValid = false
                }
            }else if type == "char"{
                var characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
                if !spaceCheck{
                    characterset.insert(charactersIn: " ")
                }
                if allowSpecialChar != nil{
                    characterset.insert(charactersIn: allowSpecialChar ?? "")
                }
                if trimmedString.rangeOfCharacter(from: characterset.inverted) != nil {
                    isValid = false
                }
            }
        }else{
            var characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
            if !spaceCheck{
                characterset.insert(charactersIn: " ")
            }
            if allowSpecialChar != nil{
                characterset.insert(charactersIn: allowSpecialChar ?? "")
            }
            if trimmedString.rangeOfCharacter(from: characterset.inverted) != nil {
                isValid = false
            }
        }
        return isValid
    }
    
    func getDatefromMilliseconds(_ timeValue:Int, _ format:String) -> String {
        
        let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(timeValue)/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: dateVar)
        
    }
    
    
    //Convert Date into MilliSeconds
//    func ConvertDateInMiliseconds(dateString:String, dateFormat:String) -> Double {
//        
//        let dateFormatter = DateFormatter()
//        
//        dateFormatter.dateFormat = dateFormat
//        
//        let Ndate = dateFormatter.date(from: dateString as String)
//        
//        //        let currentDate = Date()
//        let dateLocal = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Ndate!)?
//        
//        let since1970 = dateLocal.timeIntervalSince1970
//        
//        return Double(since1970 * 1000)
//    }
    
    func ConvertDateInMilisecondsIST(dateString:String, dateFormat:String) -> Int {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = dateFormat
        
        let Ndate = dateFormatter.date(from: dateString as String)
        
        let since1970 = Ndate?.timeIntervalSince1970

        return Int(since1970! * 1000)
    }
    
    func DoctorConvertDateInMiliseconds(dateString:String, dateFormat:String) -> Int {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = dateFormat
        
        let Ndate = dateFormatter.date(from: dateString as String)
        
        //        let currentDate = Date()
        let since1970 = Ndate?.timeIntervalSince1970
        
        return Int(since1970! * 1000)
        
    }
    //Remove Elements Tag Based
    func removeObj(tagg:Int, mview:UIView) {
        
        let subViews = mview.subviews
        
        for subview in subViews {
            
            if subview.tag == tagg{
                
                subview.removeFromSuperview()
            }
        }
    }
    //MARK: Get Age in Yeras, Months, Days...
    func getAge(startDate:String, endDate:String, dateFormat:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let dateStart = dateFormatter.date(from: startDate)
        let datesEnd = dateFormatter.date(from: endDate)
        
        var yearValue = Int()
        var monthValue = Int()
        var daysValue = Int()
        var finalAge = String()
        
        let getYears = Calendar.current.dateComponents([.year], from: dateStart!, to: datesEnd!).year
        yearValue = getYears!
        
        if yearValue != 0 {
            if yearValue < 2{
                finalAge = "\(yearValue) \("Year")"
            }else{ finalAge = "\(yearValue) \("Years")" }
        }else
        {
            let getMonths = Calendar.current.dateComponents([.month], from: dateStart!, to: datesEnd!).month
            monthValue = getMonths!
            if monthValue != 0{
                if monthValue < 2{
                    finalAge = "\(monthValue) \("Month")"
                }else{ finalAge = "\(monthValue) \("Months")" }
            }
            else
            {
                let getDayss = Calendar.current.dateComponents([.day], from: dateStart!, to: datesEnd!).day
                daysValue = getDayss!
                if daysValue < 2{
                    finalAge = "\(daysValue) \("Day")"
                }else
                {finalAge = "\(daysValue) \("Days")"}
            }
        }
        
        return finalAge
        
    }
    
    //MARK: Get Age in Yeras, Months, Days...
    func getAge(startDate:Date, endDate:Date) -> (String , String) {
        
        var yearValue = Int()
        var monthValue = Int()
        var daysValue = Int()
        var finalAge = ("" , "")
        var age = finalAge.0
        var description = finalAge.1
        let getYears = Calendar.current.dateComponents([.year], from: startDate, to: endDate).year
        yearValue = getYears!
        
        if yearValue != 0 {
            if yearValue < 2{
                age = "\(yearValue)"
                description =  "Year"
            }else{  age = "\(yearValue)"
                description =  "Years" }
        }else
        {
            let getMonths = Calendar.current.dateComponents([.month], from: startDate, to: endDate).month
            monthValue = getMonths!
            if monthValue != 0{
                if monthValue < 2{
                    age = "\(monthValue)"
                    description = "Month"
                }else{ age = "\(monthValue)"
                    description =  "Months" }
            }
            else
            {
                let getDayss = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day
                daysValue = getDayss!
                if daysValue < 2{
                    age = "\(daysValue)"
                    description =  "Day"
                }else
                {age = "\(daysValue)"
                    description =  "Days"}
            }
        }
        
        return finalAge
        
    }
    
    func getCurrentDate(_ dateFormat:String) -> String {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let result = formatter.string(from: date)
        
        return result
    }
    func noInternetPopUpView(internetview:UIView) {
        
    }
    
    
    
    func convertToCSV(arrayObject : [Any]) -> String? {
        var csvStr = ""
        for obj in arrayObject{
            if !(obj is [Any]) && !(obj is Dictionary<String,Any>){
                csvStr += "\(obj), "
            }
        }
        if csvStr != ""{
            csvStr.self.removeLast(2)
            return csvStr
        }else{
            return nil
        }
    }
    
    
    // MARK:- Draw_Dashed_Border
    // MARK:-
    //====================== *~* NEW-EHR-TAB *~* ======================//
    
    func drawDashedBorder(addView: UIView, frames: CGRect?,cornerRadius: CGFloat, borderWidth: CGFloat?, lineColor: UIColor?, fillColor: UIColor?, backgroundColor: UIColor?,lineDashPattern: [NSNumber]?) {
        
        if addView.layer.sublayers != nil
        {
            for layer in addView.layer.sublayers!
            {
                layer.removeFromSuperlayer()
            }
        }
        
        let shapeLayer = CAShapeLayer()
        let path = CGMutablePath()
        let frame:CGRect = (frames != nil) ? frames! : addView.bounds
        
        path.move(to: CGPoint(x: 0, y: frame.size.height - cornerRadius), transform: .identity)
        path.addLine(to: CGPoint(x: 0, y: cornerRadius), transform: .identity)
        path.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: CGFloat(Double.pi), endAngle: CGFloat((Double.pi/2) * 3), clockwise: false, transform: .identity)
        path.addLine(to: CGPoint(x: frame.size.width - cornerRadius, y: 0), transform: .identity)
        path.addArc(center: CGPoint(x: frame.size.width - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: CGFloat((Double.pi/2) * 3), endAngle: 0, clockwise: false, transform: .identity)
        path.addLine(to: CGPoint(x: frame.size.width, y: frame.size.height - cornerRadius), transform: .identity)
        path.addArc(center: CGPoint(x: frame.size.width - cornerRadius, y: frame.size.height - cornerRadius), radius: cornerRadius, startAngle: 0, endAngle: CGFloat(Double.pi/2), clockwise: false, transform: .identity)
        path.addLine(to: CGPoint(x: cornerRadius, y: frame.size.height), transform: .identity)
        path.addArc(center: CGPoint(x: cornerRadius, y: frame.size.height - cornerRadius), radius: cornerRadius, startAngle: CGFloat(Double.pi/2), endAngle: CGFloat(Double.pi), clockwise: false, transform: .identity)
        
        shapeLayer.path = path
        shapeLayer.frame = frame
        shapeLayer.masksToBounds = false
        shapeLayer.backgroundColor = (backgroundColor != nil) ? backgroundColor?.cgColor : UIColor.clear.cgColor
        shapeLayer.fillColor = (fillColor != nil) ? fillColor?.cgColor : UIColor.clear.cgColor
        shapeLayer.strokeColor = (lineColor != nil) ? lineColor?.cgColor : UIColor.lightGray.cgColor
        shapeLayer.lineWidth = (borderWidth != nil) ? borderWidth! : 1.0
        shapeLayer.lineDashPattern = (lineDashPattern != nil) ? lineDashPattern : [0]
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        addView.layer.addSublayer(shapeLayer)
        addView.layer.cornerRadius = cornerRadius
    }
//    func convertCSVToArray(str : String) -> [String]? {
//        var csvArray = [String]()
//
//        if str != ""{
//            csvArray = str.characters.split{$0 == ","}.map(String.init)
//            var i = 0
//            for var each in csvArray{
//                if each.characters.first == " "{
//                    csvArray.remove(at: each)
//                    each.removeFirst()
//                    csvArray.insert(each, at: i)
//                }
//                i = i + 1
//            }
//            return csvArray
//        }else{
//            return nil
//        }
//
//    }
    
    //MARK: Sort Array contains Dictionaries with key
    func sortArrayAscorDescUsingDictionary(_ key:String, _ arrayData:[[String:AnyObject]], _ asc:Bool) -> [[String:AnyObject]] {
        
        var sortedArray = [[String:AnyObject]]()
        
        var convertedArray = NSArray()
        
        convertedArray = arrayData as! NSArray
        
        sortedArray = (convertedArray as NSArray).sortedArray(using: [NSSortDescriptor(key: key, ascending: asc)]) as! [[String:AnyObject]]
        
        return sortedArray
    }
    
    //MARK: remove Dictionary from Array
    func removeDictfromArray(_ arrayData:[Any], _ key:String, _ yourdata:String) -> [Any] {
        
        var finalArray = [Any]()
        
        if arrayData.contains(where: {($0 as! [String:Any])[key] as! String == yourdata}) {
            
            finalArray = arrayData.filter { ($0 as! [String:Any])[key] as! String != yourdata}
        }else{
            finalArray = arrayData
        }
        
        return finalArray
    }
    
    
    func isValidPassword(_ strData:String) -> Bool {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,32}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        
        return passwordValidation.evaluate(with: strData)
    }

    func isRegexValid(testStr:String) -> Bool {
        let regEx = "/^\\d{1,3}\\/\\d{1,3}$/"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: testStr)
    }
    
    func valueCheck(_ d: String) -> Bool {
        var result = false
        do {
            let regex = try NSRegularExpression(pattern: "^\\d{1,3}\\/\\d{1,3}$", options: [])
            let results = regex.matches(in: String(d), options: [], range: NSMakeRange(0, String(d).self.count))
            if results.count > 0 {result = true}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
        }
        return result
    }
    
    func dowNLoadimagefromURL(urlStr:String, placeHolderIMG:String) -> UIImage {
        
        var finalIMG = UIImage()
        
        let finalURL = URL(string:urlStr)
        
        let imageData:Data = try! Data(contentsOf: finalURL!)
        
        if imageData != nil {
            
            let image = UIImage(data: imageData as Data)
            
            finalIMG = image!
            
        }else{
            
            finalIMG = UIImage(named:placeHolderIMG)!
        }
        
        return finalIMG
    }
    
    //MARK: Close PopUp
    func closePopup(_ vc : UIViewController){
        if let view = vc.view.viewWithTag(99){
            view.removeFromSuperview()
        }
    }
    
    //MARK:TimeSlot Logic
    
    func getTimeSlot(timeData:Int) -> String {
        
        var finalTime = String()
        
        if timeData < 24 {
            
            let acTime:Double = Double(timeData)
            
            let Bytwo:Double = acTime / 2
            
            let isInteger = Bytwo.truncatingRemainder(dividingBy: 1) == 0
            
            if isInteger{
                let finalValUe:Int = Int(Bytwo)
                finalTime = "\(finalValUe)\(":00 AM")"
                
            }else{
                
                let finalValUe:Int = Int(Bytwo)
                finalTime = "\(finalValUe)\(":30 AM")"
            }
            
        }else{
            
            let acTime:Double = Double(timeData)
            let Bytwo:Double = acTime / 2
            finalTime = getTimeSTR(timevalue: Bytwo)
        }
        
        return finalTime
    }
    
    
    func getTimeSTR(timevalue:Double) -> String {
        
        var finalllT = String()
        
        if timevalue == 12.0 {
            
            finalllT = "12:00 PM"
        }
        else if timevalue == 12.5 {
            
            finalllT = "12:30 PM"
        }
        else if timevalue == 13.0 {
            
            finalllT = "01:00 PM"
        }
        else if timevalue == 13.5 {
            
            finalllT = "01:30 PM"
        }
        else if timevalue == 14.0 {
            
            finalllT = "02:00 PM"
        }else if timevalue == 14.5 {
            
            finalllT = "02:30 PM"
        }else if timevalue == 15.0 {
            
            finalllT = "03:00 PM"
        }else if timevalue == 15.5 {
            
            finalllT = "03:30 PM"
        }else if timevalue == 16.0 {
            
            finalllT = "04:00 PM"
        }else if timevalue == 16.5 {
            
            finalllT = "04:30 PM"
        }
        else if timevalue == 17.0 {
            
            finalllT = "05:00 PM"
        }else if timevalue == 17.5 {
            
            finalllT = "05:30 PM"
        }else if timevalue == 18.0 {
            
            finalllT = "06:00 PM"
        }else if timevalue == 18.5 {
            
            finalllT = "06:30 PM"
        }else if timevalue == 19.0 {
            
            finalllT = "07:00 PM"
        }else if timevalue == 19.5 {
            
            finalllT = "07:30 PM"
        }
        else if timevalue == 20.0 {
            
            finalllT = "08:00 PM"
        }else if timevalue == 20.5 {
            
            finalllT = "08:30 PM"
        }
        else if timevalue == 21.0 {
            
            finalllT = "09:00 PM"
        }else if timevalue == 21.5 {
            
            finalllT = "09:30 PM"
        }
        else if timevalue == 22.0 {
            
            finalllT = "10:00 PM"
        }else if timevalue == 22.5 {
            
            finalllT = "10:30 PM"
        }else if timevalue == 23.0 {
            
            finalllT = "11:00 PM"
        }
        else if timevalue == 23.5 {
            
            finalllT = "11:30 PM"
        }
        else if timevalue == 24.0 {
            
            finalllT = "12:00 AM"
        }
        
        
        return finalllT
    }
    
    //MARK: Convert Dict to String --> START
    
    func dictIntoString(allData:[String:String]) -> String {
        
        var finalString = String()
        
        var DictAllparameters = [String: String]()
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: allData, options: .prettyPrinted)
            
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            if let dictFromJSON = decoded as? [String:String] {
                
                DictAllparameters = dictFromJSON
                
            }
        } catch {
            print(error.localizedDescription)
        }
        
        finalString = self.convertToJsonString(json: DictAllparameters)!
        
        return finalString
    }
    
    // MARK:- Dictionary to String
    // MARK:-
    
    func dictionaryToString(dict: [String:Any]) -> String
    {
        var encodedParameters = ""
        for (key, value) in dict
        {
            if !encodedParameters.isEmpty
            {
                encodedParameters += "&"
            }
            encodedParameters += key
            encodedParameters += "="
            encodedParameters += "\(value)"
        }
        print(encodedParameters)
        return encodedParameters
    }
    
    // MARK:- Milliseconds to Date
    // MARK:-
    func getDateFromMilliseconds(longValue: Double, format: String) -> String
    {
        let dateVar = Date.init(timeIntervalSince1970: (longValue / 1000.0))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  format
        return dateFormatter.string(from: dateVar)
    }
    func convertToJsonString(json: [String: Any]) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func uiActivityIndicatorShow(_ view : UIView){
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.tag = 654321
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = UIColor.darkGray
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        activityIndicator.startAnimating()
    }
    
    func uiActivityIndicatorHide(_ view : UIView){
        if let activityIndicator = view.viewWithTag(654321) as? UIActivityIndicatorView{
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        if(targetSize.width > 0 && targetSize.height > 0){
            let size = image.size
            
            let widthRatio  = targetSize.width  / size.width
            let heightRatio = targetSize.height / size.height
            
            // Figure out what our orientation is, and use that to form the rectangle
            var newSize: CGSize
            if(widthRatio > heightRatio) {
                newSize = CGSize.init(width: size.width * heightRatio, height: size.height * heightRatio)
            } else {
                newSize = CGSize.init(width: size.width * widthRatio, height: size.height * widthRatio)
            }
            
            // This is the rect that we've calculated out and this is what is actually used below
            let rect = CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height)
            
            // Actually do the resizing to the rect using the ImageContext stuff
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            image.draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext() ?? image
            UIGraphicsEndImageContext()
            
            return newImage
        }else{
            return image
        }
    }
    
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=()[],.:!_".self)
        return String(text.self.filter {okayChars.contains($0) })
    }
    
    func convertToTwoDigit(_ number : Int) -> String{
        if number < 10 {
            return "0\(number)"
        }else{
            return "\(number)"
        }
    }
    

}

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleToFill) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            
            DispatchQueue.main.async() {
                
                self.image = image
            }
        }
    .resume()
    }
    
//    func downloaded(from link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
//        // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
//        guard let url = URL(string: link) else { return }
//        downloaded(from: url, contentMode: mode)
//    }
}
