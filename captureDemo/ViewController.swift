//
//  ViewController.swift
//  captureDemo
//
//  Created by 区块国际－yin on 2017/3/21.
//  Copyright © 2017年 blog.aiyinyu.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


    @IBAction func touchHandler(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "fileOutputVC") as! fileOutputViewController
        present(vc, animated: true, completion: nil)
    }
}

