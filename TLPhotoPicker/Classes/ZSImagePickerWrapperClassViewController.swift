//
//  ZSImagePickerWrapperClassViewController.swift
//  Streams
//
//  Created by Rizwan Ahmed A on 18/12/17.
//  Copyright © 2017 ZOHOCORP. All rights reserved.
//

import UIKit
import Photos

@objc protocol ZSImagePickerWrapperClassDelegate {
    
    func picked(images:[PHAsset]?)
    
}

extension ZSImagePickerWrapperClassDelegate{
    public func picked(images:[PHAsset]?){}
    public func imagesSelected(count :Int64){}
    
}

@objc class ZSImagePickerWrapperClassViewController: NSObject {
    
    var selectedAssets = [TLPHAsset]()
    
    
    @objc public var  imageViewController : ZSCustomPhotoPickerViewController?
    
    @objc weak var imagePickerDelegate: ZSImagePickerWrapperClassDelegate?

    override init() {
        super.init()
        createImagePickerView()
    }
    
    //MARK : Local methdos
    
    func createImagePickerView(){
        imageViewController = ZSCustomPhotoPickerViewController()
        imageViewController!.delegate = self

        var configure = TLPhotosPickerConfigure()
        configure.numberOfColumn = 4
        configure.maxSelectedAssets = 7
        
//        if #available(iOS 10.2, *) {
//            configure.cameraCellNibSet = (nibName: "CustomCameraCell", bundle: Bundle.main)
//        }
        imageViewController!.configure = configure

        imageViewController!.selectedAssets = self.selectedAssets
        
    }
    
    //MARK : Instance Methods
    
    //Diss miss without Navigation controller.
    
    @objc public func imagePickingDone(){
        imageViewController!.dismissWithoutNavigationController()
    }
    
    // Use this method to remove the photos programmatically. Example - When swiping the selected images, you can call this image to deselect the images from the collection view of TLPhotosPickerViewController.
    
    @objc public func removeImageFor(key : String){
        imageViewController?.removeImage(ForKey: key)
    }
    
    deinit {
        print("deinit success")
    }

    
}

extension ZSImagePickerWrapperClassViewController : TLPhotosPickerViewControllerDelegate {
    
    
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        self.selectedAssets = withTLPHAssets
    }
    
    func dismissPhotoPicker(withPHAssets: [PHAsset]) {
        
        self.imagePickerDelegate?.picked(images: withPHAssets)
        
    }
    // This method is called when the cancel button is tapped in image picker.
    func photoPickerDidCancel() {
        
    }
    
    func dismissComplete() {
        
    }
    
    //This method is called when the number of images selected exceed the maximum image selection limit.
    
    func didExceedMaximumNumberOfSelection(picker: TLPhotosPickerViewController) {
        
    }
 
    

}

