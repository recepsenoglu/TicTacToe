//
//  ViewController.swift
//  TicTacToe
//
//  Created by Recep Oğuzhan Şenoğlu on 31.08.2023.
//

import UIKit

class ViewController: UIViewController {
    enum Mark: String {
        case X = "X"
        case O = "O"
    }
    
    @IBOutlet weak var lblTurn: UILabel!
    
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    
    var board: [UIButton] = []

    var turn: Mark = Mark.X
    var crosses: Int = 0
    var noughts: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createBoard()
    }
    
    func createBoard() {
        board.append(contentsOf: [btn0, btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8])
    }
    
    func isBoardFull()->Bool {
        for btn in board {
            if btn.attributedTitle(for: .normal)?.string == nil {
                return false
            }
        }
        return true
    }
    
    func checkForVictory(checkFor mark: Mark)-> Bool {
        /// Horizontal victory
        if hasThisMark(btn0, mark) && hasThisMark(btn1, mark) && hasThisMark(btn2, mark) {
            return true
        }
        if hasThisMark(btn3, mark) && hasThisMark(btn4, mark) && hasThisMark(btn5, mark) {
            return true
        }
        if hasThisMark(btn6, mark) && hasThisMark(btn7, mark) && hasThisMark(btn8, mark) {
            return true
        }
        
        /// Vertical Victory
        if hasThisMark(btn0, mark) && hasThisMark(btn3, mark) && hasThisMark(btn6, mark) {
            return true
        }
        if hasThisMark(btn1, mark) && hasThisMark(btn4, mark) && hasThisMark(btn7, mark) {
            return true
        }
        if hasThisMark(btn2, mark) && hasThisMark(btn5, mark) && hasThisMark(btn8, mark) {
            return true
        }
        
        /// Diagonal victory
        if hasThisMark(btn0, mark) && hasThisMark(btn4, mark) && hasThisMark(btn8, mark) {
            return true
        }
        if hasThisMark(btn2, mark) && hasThisMark(btn4, mark) && hasThisMark(btn6, mark) {
            return true
        }
        
        /// Otherwise
        return false
    }
    
    func hasThisMark(_ button: UIButton, _ mark: Mark)->Bool {
        return button.attributedTitle(for: .normal)?.string == mark.rawValue
    }
    
    func play(_ sender: UIButton) {
        sender.setAttributedTitle(NSAttributedString(string: turn.rawValue, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 60, weight: .heavy), NSAttributedString.Key.foregroundColor: UIColor.black]), for: .normal)

        sender.isEnabled = false

        changeTurn()
    }
    
    func changeTurn() {
        turn = turn == Mark.X ? Mark.O : Mark.X
        lblTurn.text = turn.rawValue
    }
    
    func resetBoard() {
        for btn in self.board {
            btn.isEnabled = true
            btn.setAttributedTitle(NSAttributedString(string: ""), for: .normal)
            btn.setNeedsLayout()
            btn.layoutIfNeeded()
            btn.setNeedsDisplay()
            btn.setAttributedTitle(nil, for: .normal)
        }
    }

    func resultAlert(_ title: String) {
        let alertController = UIAlertController(title: title, message: "Crosses: \(crosses)\nNoughts: \(noughts)", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Reset", style: .default, handler: {(_) in
            self.resetBoard()
        }))
        
        present(alertController, animated: true)
    }
    
    @IBAction func btnCell_TUI(_ sender: UIButton) {
        guard sender.attributedTitle(for: .normal) == nil else {return}
        
        play(sender)
        
        if checkForVictory(checkFor: Mark.X) {
            crosses += 1
            resultAlert("Crosses Won!")
        }
        else if checkForVictory(checkFor: Mark.O) {
            noughts += 1
            resultAlert("Noughts Won!")
        }
        else if isBoardFull() {
            resultAlert("It's a draw!")
        }
    }
}
