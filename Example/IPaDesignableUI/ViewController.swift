//
//  ViewController.swift
//  IPaDesignableUI
//
//  Created by ipapamagic@gmail.com on 04/27/2019.
//  Copyright (c) 2019 ipapamagic@gmail.com. All rights reserved.
//

import UIKit
import IPaDesignableUI
import IPaImageTool
class ViewController: UIViewController {
    @IBOutlet weak var imageView: IPaImageURLView!
    
    @IBOutlet weak var imageRightBtn: IPaImageRightStyleButton!
    @IBOutlet weak var button: IPaImageURLButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView.imageURLString = "https://www.penghu-nsa.gov.tw/FileDownload/Album/Big/20161012162551758864338.jpg"
        button.imageURLString =  "https://www.penghu-nsa.gov.tw/FileDownload/Album/Big/20161012162551758864338.jpg"
        let image = UIImage.createImage(CGSize(width: 44, height: 44), operation: {
            context in
            context.setFillColor(UIColor.red.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 44, height: 44))
            
        })
        imageRightBtn.setImage(image, for: .normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

