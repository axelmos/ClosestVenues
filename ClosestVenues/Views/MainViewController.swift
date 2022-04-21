//
//  MainViewController.swift
//  ClosestVenues
//
//  Created by Amosiejko on 18/04/2022.
//

import UIKit

class MainViewController: UIViewController {

    private lazy var listViewController: ListViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var listVC = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        addAsChildVC(listVC)
        return listVC
    }()
    
    private lazy var aboutViewController: AboutViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var aboutVC = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        addAsChildVC(aboutVC)
        return aboutVC
    }()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        updateView()
    }

    private func addAsChildVC(_ viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    private func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "List", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "About", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(segmentedControlDidChange(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
    }
    
    @objc private func segmentedControlDidChange(_ sender: UISegmentedControl) {
        updateView()
    }
    
    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            aboutViewController.removeFromParent()
            addAsChildVC(listViewController)
        } else {
            listViewController.removeFromParent()
            addAsChildVC(aboutViewController)
        }
    }
}

