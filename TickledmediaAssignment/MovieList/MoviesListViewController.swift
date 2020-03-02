//
//  MoviesListViewController.swift
//  TickledmediaAssignment
//
//  Created by Naveen Gundu on 29/02/20.
//  Copyright © 2020 NG. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    //#MARK: Outlets
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var barbtnRefresh: UIBarButtonItem!
    
    @IBOutlet var barbtnFilter: UIBarButtonItem!
    
    @IBOutlet var searchBar: UISearchBar!
    
    //#MARK: Variables
    private let refreshControl = UIRefreshControl()
    
    var vWidth = Double()
    
    var vHeight = Double()
    
    var endpoint: Endpoint?
    
    var movieService: MovieDBAPI = MovieDBStore.shared
    
    var pagenumber:Int = 1
    
    var movies = [MovieData]() {
        
        didSet {
            
            collectionView.reloadData()
        }
    }
    
    var searchActive = Bool()
    
    var searchMoviesData = [MovieData]()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.vWidth = Double(self.view.frame.size.width)
        
        self.vHeight = Double(self.view.frame.size.height)
        
        self.InitMainLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        self.endpoint = .popular
        
        getMoviesList()
        
    }
    
    //#MARK:Initial Layout Setup
    func InitMainLayout() {
        
        GenericHelper().removeAnimationfromCollectionview(self.collectionView)
        
        searchBar.frame = CGRect.init(x: 0, y: self.topbarHeight, width: self.vWidth, height: 44)
        
        let cvY = Double(searchBar.frame.size.height + searchBar.frame.origin.y)
        
        collectionView.frame = CGRect.init(x: 0, y: cvY, width: self.vWidth, height: vHeight - cvY)
        
        collectionView.register(UINib(nibName: "MovieCVCell", bundle: nil), forCellWithReuseIdentifier: "MovieCVCell")
        
        self.refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        
        collectionView.refreshControl = refreshControl
        
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        
        self.getMoviesList()
    }
    
    //#MARK: Fetch Movies List Data from WebAPI
    private func getMoviesList() {
        
        GenericHelper().uiActivityIndicatorShow(self.view)
        
        if ConnectivityHelper().isInternetAvailable() {
            
            movieService.fetchMovies(from: self.endpoint!, params: nil, successHandler: {
                
                [unowned self] (response) in
                
                GenericHelper().uiActivityIndicatorHide(self.view)
                
                self.movies = response.results
                
                self.refreshControl.endRefreshing()
                
                })
            {
                [unowned self] (error) in
                
                self.refreshControl.endRefreshing()
                
                GenericHelper().uiActivityIndicatorHide(self.view)
                GenericHelper().showVCAlert("Server Error", error.localizedDescription, self)
                
            }
            
        }else{
            
            GenericHelper().showVCAlert("Internet Not Available !", "", self)
            
        }
    }
    
    
    //MARK:Next page
    func getNextPagemoviesList() {
        
        movieService.fetchnextpageMovies(from: self.endpoint!, pageNum: self.pagenumber, params: nil, successHandler: {
            
            [unowned self] (response) in
            
            GenericHelper().uiActivityIndicatorHide(self.view)
            
            for G in 0..<response.results.count{
                
                let movieD = response.results[G]
                self.movies.append(movieD)
                
            }
            
            })
        {
            [unowned self] (error) in
            
            GenericHelper().uiActivityIndicatorHide(self.view)
            GenericHelper().showVCAlert("Server Error", error.localizedDescription, self)
            
        }
        
    }
    
    //#MARK: Action Events
    @IBAction func refreshTapped(sender: UIBarButtonItem) {
        
        getMoviesList()
    }
    
    @IBAction func filterButtontaped(sender: UIBarButtonItem) {
        
        self.showFilterOptions()
    }
    
    //MARK: Show Filter Slection Popup
    
    func showFilterOptions() {
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let upcomingAction: UIAlertAction = UIAlertAction(title: "Upcoming", style: .default) { action -> Void in
            
            self.endpoint = .upcoming
            
            self.getMoviesList()
            
        }
        
        let popularAction: UIAlertAction = UIAlertAction(title: "Popular", style: .default) { action -> Void in
            
            self.endpoint = .popular
            
            self.getMoviesList()
            
        }
        
        let topratedAction: UIAlertAction = UIAlertAction(title: "Top Rated", style: .default) { action -> Void in
            
            self.endpoint = .topRated
            
            self.getMoviesList()
            
        }
        
        let nowplayingAction: UIAlertAction = UIAlertAction(title: "Now Playing", style: .default) { action -> Void in
            
            self.endpoint = .nowPlaying
            
            self.getMoviesList()
            
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Close", style: .cancel) { action -> Void in }
        
        actionSheetController.addAction(upcomingAction)
        actionSheetController.addAction(popularAction)
        actionSheetController.addAction(topratedAction)
        actionSheetController.addAction(nowplayingAction)
        actionSheetController.addAction(cancelAction)
        
        present(actionSheetController, animated: true, completion: nil)
        
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
extension MoviesListViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var final = Int()
        
        if self.searchActive{
            
            final = self.searchMoviesData.count
            
        }else{
            final = self.movies.count
            
        }
        
        return final
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVCell", for: indexPath) as! MovieCVCell
        
        if self.searchActive{
            
            let movie = searchMoviesData[indexPath.item]
            
            cell.configure(movie)
            
        }else{
            
            let movie = movies[indexPath.item]
            
            cell.configure(movie)
            
        }
        
        GenericHelper().applyLayerShadow(cell.viewBGM)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieDetailVC = storyboard!.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        
        movieDetailVC.movieId = movies[indexPath.item].id
        
        GenericHelper().customPush(self, viewControler: movieDetailVC, animation: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if self.searchActive == false{
            
            if indexPath.item == movies.count - 1{
                
                self.pagenumber += 1
                
                self.getNextPagemoviesList()
                
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cWidth = (collectionView.frame.size.width / 2) - 6
        
        return CGSize.init(width: cWidth, height: 200.0)
    }
    
    
}
//#MARK: Search Bar Delegate Methods
extension MoviesListViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count > 0 {
            
            self.searchActive = true
            
            let text = searchBar.text!.lowercased()
            
            GenericHelper().uiActivityIndicatorShow(self.view)
            
            if ConnectivityHelper().isInternetAvailable() {
                
                movieService.searchMovie(query: text, params: nil, successHandler: {[unowned self] (response) in
                    
                    if searchBar.text == text {
                        
                        GenericHelper().uiActivityIndicatorHide(self.view)
                        
                        self.searchMoviesData = response.results
                        
                        self.collectionView.reloadData()
                        
                    }
                }) { [unowned self] (error) in
                    
                    GenericHelper().uiActivityIndicatorHide(self.view)
                    
                    GenericHelper().showVCAlert("Server Error", error.localizedDescription, self)
                }
            }
            else{
                
                GenericHelper().showVCAlert("Internet Not Available !", "", self)
                
            }
            
        }else{
            
            self.searchActive = false
            
            self.collectionView?.reloadData()
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchActive = false
        
        self.collectionView?.reloadData()
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchMoviesData.removeAll()
        
        let stext = searchBar.text!.lowercased()
        
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        GenericHelper().uiActivityIndicatorShow(self.view)
        
        if ConnectivityHelper().isInternetAvailable() {
            
            movieService.searchMovie(query: text, params: nil, successHandler: {[unowned self] (response) in
                //self.activityIndicator.stopAnimating()
                
                if searchBar.text == text {
                    
                    print("Done Saerch Data", response.results)
                    
                    GenericHelper().uiActivityIndicatorHide(self.view)
                    
                    self.searchMoviesData = response.results
                    
                    self.collectionView.reloadData()
                    
                }
            }) { [unowned self] (error) in
                
                GenericHelper().uiActivityIndicatorHide(self.view)
                
                GenericHelper().showVCAlert("Server Error", error.localizedDescription, self)
            }
        }
        else{
            
            GenericHelper().showVCAlert("Internet Not Available !", "", self)
            
        }
        
        self.view.endEditing(true)
        
    }
    
    
}
//#MARK: Search Methods

extension MoviesListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        movies = []
        
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            return
        }
        
        GenericHelper().uiActivityIndicatorShow(self.view)
        
        if ConnectivityHelper().isInternetAvailable() {
            
            movieService.searchMovie(query: text, params: nil, successHandler: {[unowned self] (response) in
                
                GenericHelper().uiActivityIndicatorHide(self.view)
                
                if searchController.searchBar.text == text {
                    self.movies = response.results
                }
                })
            { [unowned self] (error) in
                
                GenericHelper().uiActivityIndicatorHide(self.view)
                GenericHelper().showVCAlert("Server Error", error.localizedDescription, self)
                
            }
        }
        else{
            
            GenericHelper().showVCAlert("Internet Not Available !", "", self)
            
        }
        
    }
    
}

extension UIViewController {
    
    var topbarHeight: Double {
        return Double(UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0))
    }
}
