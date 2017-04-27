//
//  ViewController.swift
//  VideoDemo
//
//  Created by Gene Lee on 4/20/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit
import MobileCoreServices // to get kUTTypeMovie
import AVKit // for AVPlayerViewController
import AVFoundation // for AVPlayer

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var videoURL: URL!
    
    @IBAction func selectVideoTapped(_ sender: UIButton) {
        self.selectVideo()
    }
    
    @IBAction func playVideoTapped(_ sender: UIButton) {
        self.playVideo()
    }
    
    @IBAction func recordVideoTapped(_ sender: UIButton) {
        self.recordVideo()
    }
    
    @IBAction func saveVideoTapped(_ sender: UIButton) {
        self.saveVideo()
    }
    
    func selectVideo () {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = [kUTTypeMovie as String]
            self.present(picker, animated: true, completion: nil)
        } else {
            print("video library not available")
        }
    }
    
    // UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.videoURL = info[UIImagePickerControllerMediaURL] as! URL
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func playVideo () {
        if let url = self.videoURL {
            let playerView = AVPlayerViewController()
            playerView.player = AVPlayer(url: url)
            present(playerView, animated: true, completion: nil)
        }
    }
    
    func recordVideo () { // same as selectVideo, except use sourceType .camera
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.mediaTypes = [kUTTypeMovie as String]
            self.present(picker, animated: true, completion: nil)
        } else {
            print("camera not available")
        }
    }
    
    func saveVideo () {
        if let videoPath = self.videoURL?.path {
            UISaveVideoAtPathToSavedPhotosAlbum(videoPath, self, #selector(videoWriteHandler), nil)
        }
    }
    
    func videoWriteHandler(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer?) {
        if let err = error {
            print("error saving video: \(err.localizedDescription)")
        } else {
            print("video saved to library")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

