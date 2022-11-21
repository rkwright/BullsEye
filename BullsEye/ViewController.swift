//
//  ViewController.swift
//  BullsEye
//
//  Created by rkwright on 11/16/22.
//

import UIKit

class ViewController: UIViewController {

    var currentValue = 50
    var targetValue  = 0
    var score        = 0
    var rounds       = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundsLabel: UILabel!
    @IBOutlet weak var restartLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        startNewRound()
        
        decorateSlider()
    }

    //
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference
        score += points

        // add these lines
        let title: String
        if difference == 0 {
          title = "Perfect!"
        } else if difference < 5 {
          title = "You almost had it!"
        } else if difference < 10 {
          title = "Pretty good!"
        } else {
          title = "Not even close..."
        }

        let message = "You scored \(points) points"

        let alert = UIAlertController(title: title,  message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default,
                                   handler: { _ in  self.startNewRound() })

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slder: UISlider) {
        currentValue = lroundf(slder.value)
    }

    @IBAction func restartTapped( _ button: UIButton ) {
        print("Restarting")
        restartGame()
    }

    func decorateSlider() {
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)

        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)

        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)

        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable =
                         trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)

        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable =
                         trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    func startNewRound() {
        rounds += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.setValue(Float(currentValue), animated: false)
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundsLabel.text = String(rounds)
    }
    
    func restartGame() {
        score = 0
        rounds = 0
        startNewRound()
    }
}


