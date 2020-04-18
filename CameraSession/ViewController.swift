//
//  ViewController.swift
//  CameraSession
//
//  Created by Neftali Samarey on 4/18/20.
//  Copyright © 2020 Neftali Samarey. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // Main session for handling all sessions: video, sound, photo
    /*
     
     All capture sessions need at least one capture input, and capture output.
     Capture inputs (AVCaptureInput subclasses) are media sources --recording devices
     like the camera (front-back) and microphone built into an iOS device.
     
     Capture outputs (AVCaptureOutput subclasses) use data provided by capture inputs
     to produce media, like image and video files.
    
     (Step 1)
     To use a camera for video input (to capture photos or movies), select an appropiate
     AVCaptureDevice, create a corresponding AVCaptureDeviceInput, and add it to the session.
     
     (Step 2)
     - Adding outputs:
     
     We are now adding outputs to the type of media we are trying to capture from camera (video, photos).
     For example, to capute photos, add an AVCapturePhotoOutput to the session (captureSession instance)
     
     ** A session can have multiple inputs and outputs
     - To record both video and audio in a movie, add inputs for both camera and microphone devices.
     - To capture both photos and movies from the same camera, add both AVCapturePhotoOutput and AVCaptureMovieFileOutput to your session.
     
     
     (Step 3) Preview the camera/video before capturing.
     To let the user see what the camera is seeing, use the AVCaptureVideoPreviewLayer by connecting this to the caputre session. (captureSession)
     
     
     Class : PreviewViewLayer.swift
     
     
     */
    
    
    var captureSession = AVCaptureSession()             // Session we will be working with
    var previewLayer = AVCaptureVideoPreviewLayer()     // Preview layer showing what we see
    var previewView = PreviewViewLayer()                          // Adding above instance to this view

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initiateCaptureSession()
        
        
    }
    
    // MARK: - Capture Session
    func initiateCaptureSession() {
        // Begin the session
        captureSession.beginConfiguration()
        
        // Setup the devide
        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .unspecified)
        
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!),
        captureSession.canAddInput(videoDeviceInput) else {
            return
        }
        // Adding the devide to the session (Step 1)
        captureSession.addInput(videoDeviceInput)
        
        
        //(Step 2) Setting up the output type of media we are planning to capute. (photo in our case)
        let photoOutput = AVCapturePhotoOutput()
        guard captureSession.canAddOutput(photoOutput) else { return }
        captureSession.sessionPreset = .photo
        captureSession.addOutput(photoOutput)
        captureSession.commitConfiguration()
        
        // Setup the view for preview
        setupViewWithPreviewOverride()
        
        // and finally, begin to capture the feed
        captureSession.startRunning()
        
    }
    
    func setupViewWithPreviewOverride() {
        
        previewView = PreviewViewLayer(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.addSubview(previewView)
        
        // Then, to use the preview layer with a capture session, set the layer’s session property:
        previewView.videoPreviewLayer.session = self.captureSession
       
    }


}

