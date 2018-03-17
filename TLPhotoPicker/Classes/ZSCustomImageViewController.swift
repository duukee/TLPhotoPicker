//
//  ZSCustomImageViewController.swift
//  Streams
//
//  Created by Rizwan Ahmed A on 18/12/17.
//  Copyright © 2017 ZOHOCORP. All rights reserved.
//

import UIKit
import Photos

class ZSCustomPhotoPickerViewController: TLPhotosPickerViewController {
    override func makeUI() {
        super.makeUI()
        self.customNavItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .stop, target: nil, action: #selector(customDismissAction))
        
        
    }
    @objc func customDismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func doneButtonTap() {
        super.doneButtonTap()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    
}




