//
//  ViewController.swift
//  amiiboTableView
//
//  Created by Administrador on 04/12/2023.
//

import UIKit

class AmiiboListVC: UIViewController {
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var amiiboList = [AmiiboForView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AmiiboCell.self, forCellReuseIdentifier: "cellid")
        setupView()
        let anonymousFunction = {(fetchedAmiiboList: [Amiibo]) in
            DispatchQueue.main.async {
                let amiiboForListView = fetchedAmiiboList.map{amiibo in
                    return AmiiboForView(name: amiibo.name, gameSeries: amiibo.gameSeries, imageUrl: amiibo.image, count: 0)
                }
                self.amiiboList = amiiboForListView
                self.tableView.reloadData()
            }
        }
        AmiiboAPI.shared.fetchAmiiboList(onCompletition: anonymousFunction)
    }

    func setupView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension AmiiboListVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amiiboList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        let amiibo = amiiboList[indexPath.row]
        guard let amiiboCell = cell as? AmiiboCell else{
            return cell
        }
        amiiboCell.nameLabel.text = amiibo.name
        amiiboCell.gameSeriesLabel.text = amiibo.gameSeries
        amiiboCell.owningCountLabel.text = String(amiibo.count)
        if let url = URL(string: amiibo.imageUrl) {
            amiiboCell.imageIV.loadImage(from: url)
        }
        return cell
    }
}

//MARK: - UITableViewDelegate

extension AmiiboListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "DELETE"){(action, view, completionHandler) in
            self.amiiboList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let countAction = UIContextualAction(style: .normal, title: "COUNT"){(action, view, completionHandler) in
            let currentCount = self.amiiboList[indexPath.row].count
            self.amiiboList[indexPath.row].count = currentCount + 1
            
            if let cell = self.tableView.cellForRow(at: indexPath) as? AmiiboCell {
                cell.owningCountLabel.text = String(self.amiiboList[indexPath.row].count)
            }
            
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [countAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let amiibo = self.amiiboList[indexPath.row]
        let amiiboDetailVC = AmiiboDetailVC()
        amiiboDetailVC.amiibo = amiibo
        
        self.present(amiiboDetailVC, animated: true)
    }
}
