//
//  ColoViewController.swift
//  teste2
//
//  Created by Carlos on 02/09/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit
struct Nota {
    var title:String
    var note:String
    var data:Date
}

protocol NoteDelegate{
    func changeNote(note:Nota)
}


class ColoViewController: UIViewController {
    
    var delegate : NoteDelegate?
    
    @IBOutlet weak var dateInfo: UIDatePicker!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var noteText: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var note: DateFormat?
    
    @IBAction func sendInfoToTableView(_ sender: UIButton) {
        let newNote: Nota = Nota(title:titleText.text! , note: noteText.text!, data: dateInfo.date)
        if (newNote.title == "" || newNote.note == ""){
            let alert = UIAlertController(title: "Erro", message: "Voce tentou salvar uma nota vazia", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil ))
            present(alert,animated: true)
        }else{
            delegate?.changeNote(note: newNote)
            self.navigationController?.popViewController(animated: true)
        }
     
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let safeNote = self.note {
            senderCell(DateFormat: safeNote)
        }
        self.saveButton.layer.cornerRadius = 4
    }
}

extension ColoViewController: cellSend{
    func senderCell(DateFormat: DateFormat) {
        self.note = DateFormat
        
        titleText.text = DateFormat.title
        noteText.text = DateFormat.note
        dateInfo.date = DateFormat.day
    }
}

