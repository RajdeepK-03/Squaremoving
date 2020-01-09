//
//  ViewController.swift
//  Squaremoving
//
//  Created by MacStudent on 2020-01-08.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Square: UIView!
    
    
    var timer:Timer?
        var Top = false
        var Bottom = true
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        override func viewDidLoad() {
            super.viewDidLoad()
            startTimer()
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            self.view.addGestureRecognizer(tap)
        }
        
        @objc func btnUp() {
            var xPosition = Square.frame.origin.x
            var yPosition = Square.frame.origin.y
            
            if Bottom {
                yPosition += 20
            } else if Top {
                yPosition -= 20
            }
            
            if yPosition > screenHeight {
                xPosition = generateRandomXCordinate()
                yPosition = screenHeight - 70
                Top = true
                Bottom = false
            } else if yPosition < 0 {
                xPosition = generateRandomXCordinate()
                yPosition +=  70
                Top = false
                Bottom = true
            }

            let width = Square.frame.size.width
            let height = Square.frame.size.height

            UIView.animate(withDuration: 1.0, animations: {
                self.Square.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
            })
        }
        
        func generateRandomXCordinate() -> CGFloat{
            let randomInt = Int.random(in: 1..<Int(screenWidth - 30))
            return CGFloat(randomInt)
        }
        func startTimer() {
            timer = Timer.scheduledTimer(timeInterval: 0.3,
            target: self,
            selector: #selector(btnUp),
            userInfo: nil,
            repeats: true)
        }
        func stopTimer() {
            if timer != nil {
                timer?.invalidate()
                timer = nil
            }
        }
        @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
            if timer != nil {
                stopTimer()
            } else {
                startTimer()
            }
        }


    }


