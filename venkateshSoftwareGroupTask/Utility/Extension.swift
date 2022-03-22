//
//  Extension.swift
//  venkateshSoftwareGroupTask
//
//  Created by venkatesh prasad on 21/03/22.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlert(titlestr:String,messagestr: String){
        let alert = UIAlertController(title: titlestr, message: messagestr, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    func getDate(datestring:String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.date(from: datestring)!
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "HH:mm"
        return  dateFormatter1.string(from: date)
    }
    func getDayOfWeek(datestring:String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: datestring)!
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "EEEE"
        return  dateFormatter1.string(from: date).capitalized
    }
}

