//
//  MovieDetailViewController.swift
//  TickledmediaAssignment
//
//  Created by Naveen Gundu on 29/02/20.
//  Copyright © 2020 NG. All rights reserved.
//

import UIKit
import Kingfisher
import XCDYouTubeKit
import AVKit

class MovieDetailViewController: UIViewController {
    
    //#MARK: Outlets
    
    @IBOutlet var collectionView: UICollectionView!
    
    //#MARK: Variables
    
    var vWidth = Double()
    
    var vHeight = Double()
    
    var movieService: MovieDBAPI = MovieDBStore.shared
    
    var movieId: Int!
    
    private var movieDetails: MovieData!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.vWidth = Double(self.view.frame.size.width)
        
        self.vHeight = Double(self.view.frame.size.height)
        
        self.InitDetailMovieMainLayout()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()

        backButton.title = "Back"

        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        self.getMovieDetails()
    }
    
    
    //#MARK: Get Movie Details
    private func getMovieDetails() {
        
        guard let movieId = movieId else {
            return
        }
        
        GenericHelper().uiActivityIndicatorShow(self.view)
        
        if ConnectivityHelper().isInternetAvailable() {
            
            movieService.fetchMovie(id: movieId, successHandler: {[weak self] (movie) in
                
                GenericHelper().uiActivityIndicatorHide(self!.view)
                
                self?.movieDetails = movie
                
                self?.title = movie.title
                
                DispatchQueue.main.async {
                    
                    self?.collectionView.reloadData()
                }
                
                })
            { [weak self] (error) in
                
                GenericHelper().uiActivityIndicatorHide(self!.view)
                GenericHelper().showVCAlert("Server Error", error.localizedDescription, self!)
                
            }
        }
    }
    
    //#MARK:Initial Layout Setup
    func InitDetailMovieMainLayout() {
        
        collectionView.frame = CGRect.init(x: 0, y: self.topbarHeight, width: self.vWidth, height: vHeight - self.topbarHeight)
        
        collectionView.register(UINib(nibName: "MovieDetailCVCell", bundle: nil), forCellWithReuseIdentifier: "MovieDetailCVCell")
        
        GenericHelper().removeAnimationfromCollectionview(self.collectionView)
        
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//#MARK: Collectionview Delegate and Datasource Methods
extension MovieDetailViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDetailCVCell", for: indexPath) as! MovieDetailCVCell
        
        if self.movieDetails != nil {
            
            cell.configure(self.movieDetails)
            
        }
        
        GenericHelper().applyLayerShadow(cell.viewBGM)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cWidth = collectionView.frame.size.width
        
        return CGSize.init(width: cWidth, height: 700.0)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        return UIEdgeInsets.init(top: 8.0, left: 4.0, bottom: 8.0, right: 4.0)
//    }
    
}

