//
//  SafariViewController.swift
//  YiDa
//
//  Created by A1 on 2022/8/19.
//

import UIKit

class SafariViewController: SFSafariViewController, SFSafariViewControllerDelegate {

    var didFinish: VoidCallback?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        if let didFinish = didFinish {
            didFinish()
        }
    }

}
