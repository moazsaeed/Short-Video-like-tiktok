//
//  ViewController.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 09/05/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newsAPI = NewsAPI()
        let apiclient = APIClient()
        apiclient.fetch(of: News.self, api: newsAPI) { result in
            switch result {
            case .success(let news):
                print("news loaded \(news.totalResults)")
                
            case .failure(let error):
                print("failed to load = \(error)")
            }
        }
    }


}

