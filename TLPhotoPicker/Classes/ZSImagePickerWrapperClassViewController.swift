//
//  ZSImagePickerWrapperClassViewController.swift
//  Streams
//
//  Created by Rizwan Ahmed A on 18/12/17.
//  Copyright © 2017 ZOHOCORP. All rights reserved.
//

import UIKit
import Photos

enum AuthenticationPopUpType {
    case CAMERA
    case ALBUM
    case LIMIT_EXCEEDED
}

@objc protocol ZSImagePickerWrapperClassDelegate {
    
    func picked(images:[PHAsset]?)
    func getSelectedImagesCount(count :Int64)
    
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
//        imageViewController!.dismissWithoutNavigationController()
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
    func handleNoCameraPermissions(picker: TLPhotosPickerViewController) {
        
    }
    
    
    
    
    
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        self.selectedAssets = withTLPHAssets
    }
    func dismissPhotoPicker(withPHAssets: [PHAsset]) {
        
        self.imagePickerDelegate?.picked(images: withPHAssets)
        
    }
    func photoPickerDidCancel() {
        
    }
    func dismissComplete() {
        
        
    }
    
    // This
    func didExceedMaximumNumberOfSelection(picker: TLPhotosPickerViewController) {
        selectionLimitExceeded()
    }
    func didStartSelectingImage(WithCount: Int64) {
        self.imagePickerDelegate?.getSelectedImagesCount(count: WithCount)
    }
    
    func selectionLimitExceeded(){
        createAuthorizationAlertView(withTitle: NSLocalizedString("zstreams.photolibrary.selectionlimitexceededtitle", comment: "Permission denied title."), andMessage: NSLocalizedString("zstreams.photolibrary.selectionlimitexceededmessage", comment: "Permission denied title."), andType: AuthenticationPopUpType.LIMIT_EXCEEDED)
    }
    
    func cameraAuthorizationNotPermitted() {
        createAuthorizationAlertView(withTitle: NSLocalizedString("zstreams.photolibrary.camerapermissiondeniedtitle", comment: "Permission denied title."), andMessage: NSLocalizedString("zstreams.photolibrary.camerapermissiondeniedmessage", comment: "Permission denied message."), andType: AuthenticationPopUpType.CAMERA)
    }
    
    func albumauthorizationNotPermitted() {
        createAuthorizationAlertView(withTitle: NSLocalizedString("zstreams.photolibrary.albumpermissiondeniedtitle", comment: "Permission denied title."), andMessage: NSLocalizedString("zstreams.photolibrary.albumpermissiondeniedmessage", comment: "Permission denied message."),andType: AuthenticationPopUpType.ALBUM)
    }
    
    func createAuthorizationAlertView(withTitle title:String, andMessage message: String, andType type:AuthenticationPopUpType){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("zstreams.common.ok", comment: "Okay action string"), style: .default) { action in
            
            if type == AuthenticationPopUpType.ALBUM{
                DispatchQueue.main.async {
                    self.imageViewController?.dismiss(animated: true, completion: nil)
                }
            }
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.imageViewController?.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    
}

