//
//  GameOverViewController.swift
//  MovieQuiz
//
//  Created by William Tomaz on 16/06/20.
//  Copyright © 2020 William Tomaz. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var lbScore: UILabel!
    
    var quizManager = QuizManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbScore.text = String(quizManager.score)
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
