//
//  ScannerORCodeViewController.swift
//  Mamchur
//
//  Created by Коля Мамчур on 24.03.2021.
//

import UIKit
import AVFoundation
import CoreImage
import Photos

class ScannerORCodeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var viewForFrameCamera: UIView!
    @IBOutlet weak var helperViewForMyCodeTab: UIView!
    @IBOutlet weak var viewForScan: UIView!
    
    //MARK: Private Properties
    private var photoManager = PhotoManager(albumName: "Mamchur")
    private var deviceCamera = DeviceCamera.withCamera
    
    //MARK: Properties
    var video = AVCaptureVideoPreviewLayer()
    let session = AVCaptureSession()
    let image = UIImage(named: "QR Code")
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        setupCamera()
//        startRunning()
        helperViewForMyCodeTab.isHidden = true
        
    }
    
    // MARK: - Actions
    func setupCamera() {
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            guard let captureDevice = captureDevice else {
                let alertController = UIAlertController(title: "Device no camera", message: "Functionality of the program will not work", preferredStyle: .alert)
                let actionOk = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(actionOk)
                self.present(alertController, animated: true)
                deviceCamera = DeviceCamera.withoutCamera
                return
            }
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        } catch{
            fatalError(error.localizedDescription)
        }
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate( self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = viewForFrameCamera.layer.bounds
    }
    
    // MARK: - Camera
    func startRunning () {
        viewForFrameCamera.layer.addSublayer(video)
        session.startRunning()
    }
    func stopRunning() {
        session.stopRunning()
    }
    
    // MARK: - IBActions
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            helperViewForMyCodeTab.isHidden = true
            viewForScan.isHidden = false
  
            switch deviceCamera {
            case .withCamera:
                setupCamera()
                startRunning()
            case .withoutCamera:
                return
            }
            
        case 1:
            helperViewForMyCodeTab.isHidden = false
            viewForScan.isHidden = true
            switch deviceCamera {
            case .withCamera:
                stopRunning()
            case .withoutCamera:
                return
            }
            
        default:
            print("Somethink wrong")
        }
        
    }
    
    @IBAction func pressedShareMyCode(_ sender: Any) {
        
        let activityViewController = UIActivityViewController(activityItems: [image as Any], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [ .postToFacebook, .postToFlickr, .postToTwitter ]
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func pressedSaveToGalary(_ sender: Any) {
        
        guard let image = UIImage(named: "QR Code") else { return }
        
        let alertController = UIAlertController(title: "Save QR Code", message: "Where do you want to save QR Code", preferredStyle: .alert)
        let alertControllerSaved = UIAlertController(title: "Saved", message: "QR Code was saved in you galary", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertControllerSaved.addAction(actionOk)
        
        let actionSaveToGalary = UIAlertAction(title: "Save to galary", style: .default) { (action) in
            
            UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
            
            self.present(alertControllerSaved, animated: true)
        }
        
        let actionSaveToAlbum = UIAlertAction(title: "Save to album Mamchur", style: .default) { [weak self] (action) in
            guard self != nil else { return }
          
            self?.photoManager.save(image) { (success, error) in
                if success {
                    let message = "QR Code has been saved to your galary with album name: Mamchur!"
                    let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
                    alert.addAction(actionOk)
                    let duration: Double = 0.5
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                        self!.present(alert, animated: true)
                    }

                } else if error != nil {
                    print("handle error since couldn't save Photo")
                }
            }
            
        }
        
        alertController.addAction(actionSaveToGalary)
        alertController.addAction(actionSaveToAlbum)
        present(alertController, animated: true)
    }
    
}

extension ScannerORCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard metadataObjects.count > 0 else { return }
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            if object.type == AVMetadataObject.ObjectType.qr {
                let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Перейти", style: .default, handler: { (action) in
                    guard let url = URL(string: object.stringValue!) else { return }
                    
                    UIApplication.shared.open(url)
                    
                    
                }))
                alert.addAction(UIAlertAction(title: "Копировать в буфер", style: .default, handler: { (action) in
                    // Скопировать ссылку в буфер обмена
                    UIPasteboard.general.string = object.stringValue
                }))
                present(alert, animated: true, completion: nil)
                
            }
        }
    }
}

