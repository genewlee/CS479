//
//  SettingsViewController.swift
//  Bounce
//
//  Created by Gene Lee on 4/13/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var isPaused: Bool! // bool passed in from sender from segue to check is game is playing

    @IBOutlet weak var soundEffectsSwitch: UISwitch!
    @IBOutlet weak var backgroundMusicSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if (UserDefaults.standard.object(forKey: "soundEffects") != nil) {
            if UserDefaults.standard.bool(forKey: "soundEffects") {
                soundEffectsSwitch.setOn(true, animated: true)
            } else {
                soundEffectsSwitch.setOn(false, animated: true)
            }
        } // don't need to set initial because it's done in GameScene
        
        if (UserDefaults.standard.object(forKey: "backgroundMusic") != nil) {
            if UserDefaults.standard.bool(forKey: "backgroundMusic") {
                backgroundMusicSwitch.setOn(true, animated: true)
            } else {
                backgroundMusicSwitch.setOn(false, animated: true)
            }
        } // don't need to set initial because it's done in GameScene
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func soundEffectsSwitchTapped(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey:"soundEffects")
    }
    
    @IBAction func backgroundMusicSwitchTapped(_ sender: UISwitch) {
        let backgroundMusicOn = sender.isOn
        UserDefaults.standard.set(backgroundMusicOn, forKey:"backgroundMusic")
        if backgroundMusicOn && !isPaused { // only play and pause when game is not paused
            self.audioPlayer.play()
        } else {
            self.audioPlayer.pause()
        }
    }
    
    // go back to previous (scene) view
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
