//
//  ViewController.swift
//  IPaDesignableUI
//
//  Created by ipapamagic@gmail.com on 04/27/2019.
//  Copyright (c) 2019 ipapamagic@gmail.com. All rights reserved.
//

import UIKit
import IPaDesignableUI
class ViewController: UIViewController {
    @IBOutlet weak var imageView: IPaImageURLView!
    
    @IBOutlet weak var button: IPaImageURLButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView.imageURL = "https://www.penghu-nsa.gov.tw/FileDownload/Album/Big/20161012162551758864338.jpg"
        button.imageURL =  "https://www.penghu-nsa.gov.tw/FileDownload/Album/Big/20161012162551758864338.jpg"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

