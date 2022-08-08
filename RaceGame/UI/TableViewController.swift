
import Foundation
import UIKit
import RealmSwift

class TableViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var scores: Results<Score>?
    var observer: Any?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cornerRadius = 15
        tableView.backgroundColor = .black
        let nib = UINib(nibName: "RecordTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RecordTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let localRealm = try! Realm()
        let objects = localRealm.objects(Score.self)
        observer = objects.observe { changes in
            switch changes {
            case .initial:
                self.reloadData()
            case .update:
                self.reloadData()
            default:
                break
            }
            
        }
       
    }
   
    func reloadData() {
        let localRealm = try! Realm()
        let objects = localRealm.objects(Score.self)

        self.scores = objects
        tableView.reloadData()
    }
    
   
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}


extension TableViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as!
        RecordTableViewCell
        if let scores = scores {
            cell.configure(with: scores[indexPath.row])
        }
        
        

        return cell
        
    }
}
