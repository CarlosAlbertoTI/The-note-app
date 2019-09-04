//
//  ChangeViewController.swift
//  teste2
//
//  Created by Carlos on 04/09/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation
import UIKit

protocol SendDelegate {
      func senderNote(note: Nota)
}


class ChangeViewController:UIViewController{
    
    var delegate: SendDelegate?

    @IBOutlet weak var textNote: UITextField!
    @IBOutlet weak var TextTitle: UITextField!
    
    @IBOutlet weak var getDate: UIDatePicker!
    
    
    @IBAction func sendChanges(_ sender: UIButton) {
        let newNote: Nota = Nota(title:TextTitle.text! , note: textNote.text!, data: getDate.date)
        if (newNote.title == "" || newNote.note == ""){
            let alert = UIAlertController(title: "Erro", message: "Voce tentou salvar uma nota vazia", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil ))
            present(alert,animated: true)
        }else{
            delegate?.senderNote(note: newNote)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.button.layer.cornerRadius = 4
    }
}



