//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Junior on 9/21/18.
//  Copyright © 2018 Carlos Roman. All rights reserved.
//

import UIKit
import AlamofireImage
import PKHUD

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    //var movies: [[String: Any]] = []
    var movies: [Movie] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        fetchMovies()
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl)
    {
        HUD.flash(.progress, delay: 1.0)
        fetchMovies()
    }
    
    func fetchMovies()
    {
        /*let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) {(data, response, error) in
            //This will run when the network request returns
            if let error = error
            {
                print(error.localizedDescription)
            }
            else if let data = data
            {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                self.movies = []
                for dictionary in movieDictionaries
                {
                    let movie = Movie(dictionary: dictionary)
                    self.movies.append(movie)
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                }
            }
        }
        task.resume()*/
        MovieApiManager().popularMovies
        //MovieApiManager().nowPlayingMovies
            { (movies: [Movie]?, error: Error?) in
                if let movies = movies
                {
                    self.movies = movies
                    self.tableView.reloadData()
                }
            }
        self.refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    /*func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        
        let movie = movies[indexPath.row]
        let title = movies[indexPath.row].title
        let overview = movies[indexPath.row].overview
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        //let posterPathString = movie["poster_path"] as! String
        //let baseURLString = "https://image.tmdb.org/t/p/original"
        //let posterURL = URL(string: baseURLString + posterPathString)!
        cell.posterImageView.af_setImage(withURL: movies[indexPath.row].posterURL!)
        return cell
    }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.movie = movies[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell)
        {
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}
