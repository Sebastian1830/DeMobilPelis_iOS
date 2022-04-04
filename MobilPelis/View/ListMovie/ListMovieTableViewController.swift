//
//  ListMovieTableViewController.swift
//  MobilPelis
//
//  Created by Sebastian Soto Varas on 3/04/22.
//

import UIKit
import SVProgressHUD

class ListMovieTableViewController: UITableViewController {
    
    private let cellId = "MovieTableViewCell"
    private let detailId = "DetailMovieViewController"
    private var listMovieVM: ListMovieViewModel?
    private var page = 1
    private var dataSourceMovies = [MovieModel]()
    private var totalPage = 1
    private var currentPage = 1
    
    @IBOutlet var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        setupUI()
        getMovies(page: 1, refresh: false)
    }
    
    @objc
    private func refreshData() {
        self.dataSourceMovies.removeAll()
        getMovies(page: 1, refresh: true)
    }

    
    private func getMovies(page: Int, refresh: Bool = false) {
        if refresh { refreshControl?.beginRefreshing() } else { SVProgressHUD.show() }
        listMovieVM = ListMovieViewModel(page: page)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            if refresh { self.refreshControl?.endRefreshing() } else { SVProgressHUD.dismiss() }
            guard let response = self.listMovieVM?.getPosts() else { return }
            if self.totalPage == 1 { self.totalPage = response.total_pages }
            if self.currentPage == 1 { self.currentPage = response.page }
            self.dataSourceMovies.append(contentsOf: response.results)
            if !response.results.isEmpty { self.movieTableView.reloadData() }
        }
    }
    
    private func setupUI() {
        movieTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSourceMovies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        if let cell = cell as? MovieTableViewCell {
            if !dataSourceMovies.isEmpty { cell.setupCellWith(movie: dataSourceMovies[indexPath.row]) }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if currentPage < totalPage && indexPath.row == dataSourceMovies.count - 1 {
            currentPage += 1
            getMovies(page: currentPage, refresh: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detail = storyboard?.instantiateViewController(withIdentifier: detailId) as? DetailMovieViewController {
            detail.movie = dataSourceMovies[indexPath.row]
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
