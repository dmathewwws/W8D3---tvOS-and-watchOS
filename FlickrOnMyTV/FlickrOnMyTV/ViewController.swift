//
//  ViewController.swift
//  FlickrOnMyTV
//
//  Created by Daniel Mathews on 2015-12-08.
//  Copyright © 2015 Daniel Mathews. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate, UISearchResultsUpdating, UICollectionViewDelegate {

    var posts = [FlickrImage]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var filterString = "cat"
        
    func getFlickData(searchTerm:String){
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&format=json&safe_search=3&nojsoncallback=1&api_key=e33dc5502147cf3fd3515aa44224783f&tags=\(searchTerm)")!) { (data, response, error) -> Void in
            
            if let jsonUnformatted = try? NSJSONSerialization.JSONObjectWithData(data!, options: []),
                let json = jsonUnformatted as? [String : AnyObject],
                let photosDictionary = json["photos"] as? [String : AnyObject],
                let photosArray = photosDictionary["photo"] as? [[String : AnyObject]]
            {
                
                for photo in photosArray {
                    
                    if let farmID = photo["farm"] as? Int,
                        let serverID = photo["server"] as? String,
                        let photoID = photo["id"] as? String,
                        let secret = photo["secret"] as? String {
                            
                            let photoURLString = "https://farm\(farmID).staticflickr.com/\(serverID)/\(photoID)_\(secret).jpg"
                            if let photoURL = NSURL(string: photoURLString){
                                let post = FlickrImage(imageURL:photoURL)
                                self.posts.append(post)
                            }
                    }
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.collectionView.reloadData()
                })
                
            }else{
                print("error with response data")
            }
            
        }
        
        task.resume()

        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterString = searchController.searchBar.text ?? ""
        getFlickData(filterString)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("flickrCell", forIndexPath: indexPath) as! FlickrCollectionViewCell
        let post = posts[indexPath.item]

        cell.imageView.image = nil
        
        if (cell.downloadTask != nil) {
            cell.downloadTask.suspend()
            cell.downloadTask.cancel()
        }
        
        cell.downloadTask = NSURLSession.sharedSession().downloadTaskWithURL(post.imageURL) { (url, response, error) -> Void in
                
                if let imageURL = url,
                    let imageData = NSData(contentsOfURL: imageURL){
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            cell.imageView.adjustsImageWhenAncestorFocused = true
                            cell.imageView.image = UIImage(data: imageData)
                            
                        })
                }
            }
        
        cell.downloadTask.resume()

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, canFocusItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

