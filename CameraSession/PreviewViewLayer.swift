//
//  PreviewViewLayer.swift
//  CameraSession
//
//  Created by Neftali Samarey on 4/18/20.
//  Copyright © 2020 Neftali Samarey. All rights reserved.
//

import UIKit
import AVFoundation

class PreviewViewLayer: UIView {
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    /// Convenience wrapper to get layer as its statically known type.
   var videoPreviewLayer: AVCaptureVideoPreviewLayer {
       return layer as! AVCaptureVideoPreviewLayer
   }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
