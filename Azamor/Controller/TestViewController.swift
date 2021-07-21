//
//  TestViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/03.
//

import UIKit
import RealmSwift

class TestViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        
        var tabs: Results<StoryTab>?
        
        tabs = realm.objects(StoryTab.self)
        
        print(tabs?.first?.StoryTabBackID)
        // Do any additional setup after loading the view.
    }
    

    
    
    
    
    

}
