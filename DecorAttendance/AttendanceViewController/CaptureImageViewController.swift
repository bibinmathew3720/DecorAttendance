//
//  CaptureImageViewController.swift
//  DecorAttendance
//
//  Created by Sreejith n  krishna on 28/12/18.
//  Copyright © 2018 Sreeith n  krishna. All rights reserved.
//

import UIKit
import AVFoundation

@available(iOS 10.0, *)
protocol CaptureImageViewControllerDelegate {
    func capturedImage(image:UIImage,imageData:Data)
}
class CaptureImageViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var rotateButton: UIButton!
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var capturedImage: UIImage!
    var imageDataRep: Data!
    var selSiteModel:ObeidiModelSites?
    var attendanceResponse:ObeidiModelFetchAttendance?
    var attendanceType:AttendanceType?
    var penaltyValue:CGFloat?
    var missedSafetyEquipments = [SafetyEquipment]()
    var selLocation:Location?
    
    var delegate:CaptureImageViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
    }
    
    func initialisation(){
        self.title = Constant.PageNames.Attendance
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureCamera()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
    
    func getFrontCamera() -> AVCaptureDevice?{
        let videoDevices = AVCaptureDevice.devices(for: AVMediaType.video)
        //let videoDevices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo)
        for device in videoDevices{
            if device.position == AVCaptureDevice.Position.front {
                return device
            }
        }
        return nil
    }
    
    func getBackCamera() -> AVCaptureDevice?{
        if let video = AVCaptureDevice.default(for: AVMediaType.video){
            return video
        }
        return nil
    }
    
    func configureCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
            else {
                print("Unable to access back camera!")
                return
        }
        
       var currentCaptureDevice: AVCaptureDevice?
        currentCaptureDevice = (self.rotateButton.isSelected ? getFrontCamera() : getBackCamera())
        if let captureDevice = currentCaptureDevice{
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                stillImageOutput = AVCapturePhotoOutput()
                
                if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                    captureSession.addInput(input)
                    captureSession.addOutput(stillImageOutput)
                    setupLivePreview()
                }
                
            }
            catch let error  {
                print("Error Unable to initialize back camera:  \(error.localizedDescription)")
            }
        }
    }
    
    func setupLivePreview() {
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        previewView.layer.addSublayer(videoPreviewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.previewView.bounds
            }
        }
    }
    
    @IBAction func rotateButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        configureCamera()
    }
    
    @IBAction func bttnActnCapture(_ sender: Any) {
        #if targetEnvironment(simulator)
        // your simulator code
        self.performSegue(withIdentifier: "toPhotoCheckSceneSegue:Capture", sender: Any.self)
        #else
        // your real device code
        if #available(iOS 11.0, *) {
            let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
            stillImageOutput.capturePhoto(with: settings, delegate: self)
        } else {
            // Fallback on earlier versions
            
            let settings = AVCapturePhotoSettings()
            let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
            let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                                 kCVPixelBufferWidthKey as String: 160,
                                 kCVPixelBufferHeightKey as String: 160]
            settings.previewPhotoFormat = previewFormat
            
            //let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecJPEG])
            stillImageOutput.capturePhoto(with: settings, delegate: self)
        }
        #endif
    }
    
    @available(iOS 11.0, *)
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        let image = UIImage(data: imageData)
        if let _image = image{
            self.moveToCapturedImagePage(image: _image, imageData: imageData)
        }
    }
    
     //Delegate for ios 10
    func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?){
        if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            let image = UIImage(data: dataImage)
            if let _image = image{
                self.moveToCapturedImagePage(image: _image, imageData: dataImage)
            }
        }
    }
    
    func moveToCapturedImagePage(image:UIImage,imageData:Data){
        capturedImage = image
        self.imageDataRep  = imageData
        if self.attendanceType == AttendanceType.SickLeave{
            if let _delegate = self.delegate{
                _delegate.capturedImage(image: capturedImage, imageData: imageData)
            }
            self.navigationController?.popViewController(animated: true)
        }
        else{
            self.performSegue(withIdentifier: "toPhotoCheckSceneSegue:Capture", sender: Any.self)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toPhotoCheckSceneSegue:Capture" {
            let VC = segue.destination as! PhotoCheckViewController
            VC.selSiteModel = self.selSiteModel
            VC.attendanceResponse = self.attendanceResponse
            VC.attendanceType = self.attendanceType
            VC.penaltyValue = self.penaltyValue
            VC.capturedImageRef = capturedImage
            VC.imageData = self.imageDataRep
            VC.selLocation = self.selLocation
            VC.missedSafetyEquipments = self.missedSafetyEquipments
        }
    }
}
