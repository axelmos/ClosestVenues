//
//  ListViewController.swift
//  ClosestVenues
//
//  Created by Amosiejko on 19/04/2022.
//

import UIKit
import CoreLocation

class ListViewController: UITableViewController {
    
    lazy var viewModel:VenueProtocol = {
         return VenueViewModel()
    }()
    private var storedVenues: [Venue] = [Venue]()
    private var isPersistedData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(locationUpdated), name: NSNotification.Name(rawValue: "LOCATION_UPDATED"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if NetworkHelper.isConnectedToNetwork() {
            isPersistedData = false
            LocationHelper.shared.getCurrentLocationOnce()
        } else {
            isPersistedData = true
            storedVenues = CoreDataManager.shared.getLastVenues()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func locationUpdated(notification: Notification) {
        guard let location = notification.object as? CLLocation else {
            return
        }
        viewModel.getClosestVenues(limit: 6, lat: String(location.coordinate.latitude), long: String(location.coordinate.longitude)) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            DispatchQueue.main.async {
                if CoreDataManager.shared.deleteAllVenues() {
                    CoreDataManager.shared.saveLastVenues(venues: self.viewModel.venues)
                }
            }
        } failure: { error in
            print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isPersistedData ? storedVenues.count : viewModel.venues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueCell", for: indexPath) as! VenueCell
        cell.titleLabel.text = isPersistedData ? storedVenues[indexPath.row].name : viewModel.venues[indexPath.row].name
        
        return cell
    }
}

class VenueCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}
