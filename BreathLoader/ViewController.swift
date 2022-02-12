//
//  ViewController.swift
//  BreathLoader
//
//  Created by PIYUSH  GHOGHARI on 05/12/21.
//

import UIKit

let kAppDelegate = UIApplication.shared.delegate as? AppDelegate

class ViewController: UIViewController {
    
    @IBOutlet weak var animationsButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var loaderView: UIView!
    
    var breatheView: BreatheView!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startBreathLoader()
    }
    
    private func startBreathLoader() {
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.masksToBounds = true
        
        breatheView = BreatheView(frame: loaderView.frame)
        
        loaderView.addSubview(breatheView)
        breatheView.translatesAutoresizingMaskIntoConstraints = true
        breatheView.center = CGPoint(x: loaderView.bounds.midX, y: loaderView.bounds.midY)
        breatheView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        setStateActive(!breatheView.isAnimating)
        
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(changeTheme), userInfo: nil, repeats: false)
    }
    
    @objc func changeTheme () {
        if #available(iOS 13.0, *) {
            let kScreenDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate
            kScreenDelegate?.changeAppTheme(themeType: 1)
        } else {
            kAppDelegate?.changeAppTheme(themeType: 1)
        }
    }
    
    @IBAction func animationsButtonDidTouchUpInside(_ sender: UIButton) {
        self.view.endEditing(true)
        setStateActive(!breatheView.isAnimating)
    }
    
    private func setStateActive(_ isActive: Bool) {
        if isActive {
            breatheView.startAnimations()
            animationsButton.setTitle("TAP TO COMPLETE", for: .normal)
        } else {
            breatheView.stopAnimations()
            animationsButton.setTitle("GET STARTED", for: .normal)
        }
    }
}

