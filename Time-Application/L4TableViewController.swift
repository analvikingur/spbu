//
//  L4TableViewController.swift
//  Time-Application
//
//  Created by Даниил on 18.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import UIKit

final class L4TableViewController: UITableViewController {
    
    var jsonURI: String!
    let representation = URepresentation()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        let target = UService.getData(path: jsonURI, onLevel: .l4)
        representation.loadData(with: target) { [weak self] result in
            self?.reloadData(dependingOn:result)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return representation.data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "l4Cell", for: indexPath) as! SimpleTableViewCell
        cell.setBackgroundColor()
        
        let dataElement = representation.data[indexPath.row] as! UDataElement
        
        cell.title.text = dataElement.title
        cell.title.textColor = UColor.greyContentColor

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return mainRowHeight
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! L5TableViewController
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let dataElement = representation.data[indexPath.row] as! UDataElement
        
        destination.jsonURI = dataElement.jsonURI!
    }
}
