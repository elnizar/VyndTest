//
//  ViewController.swift
//  BestMovie
//
//  Created by Khemissi Houssem Eddin on 06/01/2019.
//  Copyright © 2019 Nizar Elhraiech. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class ViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate{
    @IBOutlet weak var viewNotFound: UIView!
    @IBOutlet weak var searchMovies: SpecificButton!
    @IBOutlet weak var serchSeries: SpecificButton!
    var movieOrSeries : String!
    var movieArray = [AnyObject]()
    var idMovie = ""
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var serchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        serchBar.showsScopeBar = true
        serchBar.delegate = self
        searchMovies.backgroundColor = UIColor.orange        
        movieOrSeries = "movie"
        



    }
    func getMoviesOrSeries()  {
        let getMovie = "http://www.omdbapi.com/?s="+serchBar.text!+"&type="+movieOrSeries+"&apiKey=295e6386"
        
        Alamofire.request(getMovie, method: .get).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject> {
                if let innerDict = dict["Search"] {
                    self.viewNotFound.isHidden = true
                    print(innerDict)
                    self.movieArray = innerDict as! [AnyObject]
                    self.collectionview.reloadData()
                    
                }
                if let response = dict["Response"]{
                    if response as! String == "False" {
                        self.movieArray.removeAll()
                        self.collectionview.reloadData()
                        self.viewNotFound.isHidden = false
                    }
                }
                
                // Do any additional setup after loading the view.
            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil ||	 searchBar.text != ""{
           getMoviesOrSeries()
        }
        self.serchBar.endEditing(true)

        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellM", for: indexPath)  as! MovieCollectionViewCell
        
        
        //emissionImg?.af_setImage(withURL: downloadURL! as URL)
        let title = movieArray[indexPath.row]["Title"] as! String
        print(title)
        let img = movieArray[indexPath.row]["Poster"] as! String
        print(img)
        let downloadURL = NSURL(string: img)
        cell.movieImg.af_setImage(withURL: downloadURL! as URL)
        
        cell.nameMovie.text = title
        
        
        
        
        
        
        
        
        return cell
    }
    


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(movieArray[indexPath.row])
        idMovie = movieArray[indexPath.row]["imdbID"] as! String
        
        print("test"+idMovie)
        performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let myVC = segue.destination as? DetailViewController {
                myVC.idMovieOrSeries = idMovie
                print("second"+myVC.idMovieOrSeries)

            }
        }

    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func searchMovie(_ sender: Any) {
        if searchMovies.backgroundColor != UIColor.orange{
            movieOrSeries = "movie"
            getMoviesOrSeries()
            searchMovies.backgroundColor = UIColor.orange
            serchSeries.backgroundColor = UIColor.white
            searchMovies.titleLabel?.textColor = UIColor.white
            serchSeries.titleLabel?.textColor = UIColor.blue
        }

        
    }
    
    @IBAction func searchSerie(_ sender: Any) {
        if serchSeries.backgroundColor != UIColor.orange{
            movieOrSeries = "series"
            getMoviesOrSeries()
            searchMovies.backgroundColor = UIColor.white
            serchSeries.backgroundColor = UIColor.orange
            searchMovies.titleLabel?.textColor = UIColor.blue
            serchSeries.titleLabel?.textColor =  UIColor.clear
            serchSeries.setTitleColor(.white, for: .normal)

        }
      
    }
    
}

