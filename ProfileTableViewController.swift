//
//  MoviesViewController.swift
//  movie
//
//  Created by Apple on 16/05/2015.
//  Copyright (c) 2015 Apple. All rights reserved.
//

import UIKit

class ProfileTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    //override func viewDidAppear(animated: Bool) {
    //let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
    //if(!isUserLoggedIn)
    // {
    //   self.performSegueWithIdentifier("loginView", sender: self)
    //}
    // }
    
    
    
    var movies: [NSDictionary]! = [NSDictionary]()
    
    var descri = [String]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie"
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        var url = NSURL(string: "http://api.themoviedb.org/3/movie/now_playing?api_key=d283197981cff3c20d5138aa61ea5085")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            self.movies = json["results"] as! [NSDictionary]
            self.tableView.reloadData()
            
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("My Movie Cell", forIndexPath: indexPath) as! MovieCell
        
        var movie = movies[indexPath.row]
        //set the title
        var title=movie["title"] as? String
        cell.titleLabel.text = movie["title"] as? String
        
        var movieid=movie["id"] as! Int
        
        var stringmovieid="\(movieid)" as String
        
        //set the cell image
        let baseImageUrlString = "https://image.tmdb.org/t/p/original"
        var url1 = movie.valueForKeyPath("poster_path") as? String
        var url=baseImageUrlString+url1!+"?api_key=d283197981cff3c20d5138aa61ea5085"
        cell.posterImage.setImageWithURL(NSURL(string: url)!)
        
        //set the dscription
        var basicurl="http://api.themoviedb.org/3/movie/"
        var apikey="?api_key=d283197981cff3c20d5138aa61ea5085"
        var overview=basicurl+stringmovieid+apikey
        var urloverview = NSURL(string: overview)!
        var request = NSURLRequest(URL: urloverview)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            var moviesoverview = json["overview"] as! String
            self.descri.append(moviesoverview)
            cell.synopsisLabel.text = moviesoverview
        }
        

        
        return cell
        
    }
    
    
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
}
