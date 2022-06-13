//
//  UIView.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 12/06/2022.
//

import Foundation
import UIKit
import KRProgressHUD

extension UIView {
    func showLoading(){
        KRProgressHUD.show()
    }
    
    func hideLoading(){
        KRProgressHUD.dismiss()
    }
}
