//
//  DetailViewController.swift
//  BestMovie
//
//  Created by Khemissi Houssem Eddin on 07/01/2019.
//  Copyright © 2019 Nizar Elhraiech. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class DetailViewController: UIViewController {
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var Genre: UILabel!
    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var Language: UILabel!
    @IBOutlet weak var Released: UILabel!
    @IBOutlet weak var imdbRating: UILabel!
    
    @IBOutlet weak var Plot: UILabel!
    @IBOutlet weak var Director: UILabel!
    @IBOutlet weak var Actors: UILabel!
    @IBOutlet weak var Writer: UILabel!
    var idMovieOrSeries = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(idMovieOrSeries)
        let getDetailMovie = "http://www.omdbapi.com/?i="+idMovieOrSeries+"&apiKey=295e6386"
        
        Alamofire.request(getDetailMovie, method: .get).responseJSON { response in
            switch response.result {
            case .success:
                
                let res = response.result.value as! NSDictionary
                //example if there is an id
                
                print(res)
                let Response = res.object(forKey: "Response") as! String
                print(Response)
                
                if  Response == "True" {
                    self.Genre.text = res.object(forKey: "Genre")! as? String
                    self.Language.text = res.object(forKey: "Language")! as? String
                    self.Released.text = res.object(forKey: "Released")! as? String
                    self.imdbRating.text = res.object(forKey: "imdbRating")! as? String
                    self.Plot.text = res.object(forKey: "Plot")! as? String
                    self.Director.text = res.object(forKey: "Director")! as? String
                    self.Plot.text = res.object(forKey: "Plot")! as? String
                    self.Actors.text = res.object(forKey: "Actors")! as? String
                    self.Writer.text = res.object(forKey: "Writer")! as? String
                    self.titre.text = res.object(forKey: "Title")! as? String

                    let img = res.object(forKey: "Poster")! as? String
                    let downloadURL = NSURL(string: img!)
                    self.imgMovie.af_setImage(withURL: downloadURL! as URL)


                }

            case .failure(let error):
                print(error)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
