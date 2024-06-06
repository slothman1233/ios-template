//
//  ViewType.swift
//  Mall
//
//  Created by cjjc on 2022/7/15.
//

import Foundation


/// Describes view component in a VIPER architecture.
protocol VCProtocol {
    associatedtype P: PresenterProtocol
    /// A presenter
    var present: P { get }
}


protocol ViewProtocol {
    associatedtype P: PresenterViewProtocol
    /// A presenter
    var present: P { get }
}


protocol SkeletonTableViewDataSource: UITableViewDataSource {
    func numSections(in collectionSkeletonView: UITableView) -> Int // Default: 1
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? // Default: nil
    func collectionSkeletonView(_ skeletonView: UITableView, prepareCellForSkeleton cell: UITableViewCell, at indexPath: IndexPath)
}


extension SkeletonTableViewDataSource {
    func numSections(in collectionSkeletonView: UITableView) -> Int {1}// Default: 1
    func collectionSkeletonView(_ skeletonView: UITableView, prepareCellForSkeleton cell: UITableViewCell, at indexPath: IndexPath){}
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {0}
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {"cell"}
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell?{nil}
}
