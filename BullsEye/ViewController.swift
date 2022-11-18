//
//  ViewController.swift
//  BullsEye
//
//  Created by rkwright on 11/16/22.
//

import UIKit

class ViewController: UIViewController {

    var currentValue = 50
    var targetValue = 0
    var score = 0
    var rounds = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundsLabel: UILabel!
    @IBOutlet weak var restartLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        startNewRound()
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
      //print("The value of the slider is now: \(slider.value)")
        
        currentValue = lroundf(slder.value)
    }

    @IBAction func restartTapped( _ button: UIButton ) {
        print("Restarting")
        restartGame()
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


