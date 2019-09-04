//
//  ViewController.swift
//  teste2
//
//  Created by aluno on 28/08/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

struct DateFormat {
    let day: Date
    let note: String
    let title:String
}

protocol cellSend{
    func senderCell(DateFormat:DateFormat)
}


class ViewController: UIViewController, UITextFieldDelegate {
    
    var indexPathLast:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showText.text = "My tasks!"
        self.listOfNotes.dataSource = self
        self.listOfNotes.delegate = self
        self.listOfNotes.layer.cornerRadius = 20
        filterNotes = notes
        
        
    }
    
    var selectedNote: DateFormat?
    var notes =  [DateFormat]()
    var filterNotes = [DateFormat]()
    @IBOutlet weak var textInput: UITextField!
    
    
    @IBAction func UIButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "SaveNote", sender: self)
    }
    
    @IBOutlet weak var showText: UILabel!
    
    @IBOutlet weak var listOfNotes: UITableView!
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveNote" {
            if let controller = segue.destination as? ChangeViewController {
               return controller.delegate = self
            }
        }
        
        if segue.identifier == "EditNote" {
            if let controller = segue.destination as? ColoViewController {
                print("segue")
                
                if let selectedNote = self.selectedNote {
                    controller.note = selectedNote
                    
                }
                controller.delegate = self
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }else if editingStyle == .insert{
            print(notes[indexPath.row])
            print("testando")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for:indexPath)
        let titile = notes[indexPath.row].title
        cell.textLabel?.text = titile
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexPathLast = indexPath.row
        let note = notes[indexPath.row]
        self.selectedNote = note
        
        performSegue(withIdentifier: "EditNote", sender: self)
    }
 
}

extension ViewController: NoteDelegate{
    func changeNote(note: Nota) {
        let date = DateFormat(day: note.data, note: note.note, title: note.title)
        
        notes[indexPathLast] = date
        listOfNotes.reloadData()
    }
}


extension ViewController: SendDelegate{
    func senderNote(note: Nota) {
        let note = DateFormat(day: note.data, note: note.note, title: note.title)
        print(note)
        notes.append(note)
        listOfNotes.reloadData()
    }
}


extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterNotes = notes.filter{
            $0.title.prefix(searchText.count) == searchText
        }
        listOfNotes.reloadData()
    }
}
