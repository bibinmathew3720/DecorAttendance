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
class CaptureImageViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak var previewView: UIView!
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var capturedImage: UIImage!
   
    var attendanceTypeRef: String!
    
    var penaltyRef: String!
    var imageDataRep: Data!
    
    var selSiteModel:ObeidiModelSites?
    var attendanceResponse:ObeidiModelFetchAttendance?
    var attendanceType:AttendanceType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureCamera()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
    
    func configureCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
            else {
                print("Unable to access back camera!")
                return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
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
        }
        #endif
        
        
        
        
        
    }
    @available(iOS 11.0, *)
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        let image = UIImage(data: imageData)
        capturedImage = image
        self.imageDataRep  = imageData
        //captureImageView.image = image
        self.performSegue(withIdentifier: "toPhotoCheckSceneSegue:Capture", sender: Any.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toPhotoCheckSceneSegue:Capture" {
            
            let VC = segue.destination as! PhotoCheckViewController
            if let attResponse = self.attendanceResponse{
                VC.nameRef = attResponse.name
                VC.dataBaseImageRef = attResponse.profileBaseUrl + attResponse.profileImageUrl
                VC.employeeIdRef = "\(attResponse.empId)"
            }
            if let siteModel = self.selSiteModel{
                VC.siteIdRef = "\(siteModel.locIdNew)"
            }
            VC.capturedImageRef = capturedImage
            
            
            VC.attendanceTypeRef = self.attendanceTypeRef
            VC.penaltyRef = self.penaltyRef
            VC.imageData = self.imageDataRep
            
        }
        
        
        
    }
}
