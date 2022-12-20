//
//  ViewController.swift
//  MinshellMusicApp
//
//  Created by DongMin Hwang on 2022/12/18.
//

import UIKit

class ViewController: UIViewController   {

 
//    let searchController = UISearchController()
    
    let searchController = UISearchController(searchResultsController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController)
    
    
    @IBOutlet weak var musicTableView: UITableView!
    
    var networkManager = NetworkManager.shared
    
    //(음악 데이터를 다루기 위함) 빈배열로 시작
    var musicArray: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        setupDatas()
        // Do any additional setup after loading the view.
    }
    
    //테이블뷰 셋팅
    func setupTableView() {
        musicTableView.dataSource = self
        musicTableView.delegate = self
        
        //Nib파일을 사용ㅇ한다면 등록의 과정이 필요
        musicTableView.register(UINib(nibName: Cell.musicCellIdentifier, bundle: nil), forCellReuseIdentifier: Cell.musicCellIdentifier)
    }
    
    func setupSearchBar() {
        self.title = "Music Search"
        navigationItem.searchController = searchController
        // 1) (단순)서치바의 사용
//        searchController.searchBar.delegate = self
        // 서치(결과) 컨트럴로의 사용(복잡한 구현 가능)
        // ==> 글자마다 검색 기능 + 새로운 화면을 보여주는 것도 가능
        searchController.searchResultsUpdater = self
        
        //첫글다 대문자 설정 없애기
        searchController.searchBar.autocapitalizationType = .none
    }
    
    func setupDatas() {
        networkManager.fetchMusic(searchTerm: "jazz") { result in
            
            switch result {
            
                
            case .success(let musicData):
                print("데이터를 제대로 받았음")
                self.musicArray = musicData 
                DispatchQueue.main.async { //메인쓰레드에서 실행해야됨
                    self.musicTableView.reloadData()
                }
                //
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
extension ViewController : UITableViewDataSource  {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.musicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicTableView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath) as! MusicCell
        cell.imageUrl = musicArray[indexPath.row].imageUrl
        cell.songNameLabel.text = musicArray[indexPath.row].songName
        cell.artistNameLabel.text = musicArray[indexPath.row].artistName
        cell.albumNaemLabel.text = musicArray[indexPath.row].albumName
        cell.releaseDateLabel.text = musicArray[indexPath.row].releaseDateString
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    // 테이블뷰 셀의 높이를 유동적으로 조절하고 싶다면 구현할 수 있는 메서드
    // (musicTableView.rowHeight = 120 대신에 사용가능)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }

}

//MARK: -  🍎 검색하는 동안 (새로운 화면을 보여주는) 복잡한 내용 구현 가능

extension ViewController: UISearchResultsUpdating {
    // 유저가 글자를 입력하는 순간마다 호출되는 메서드 ===> 일반적으로 다른 화면을 보여줄때 구현
    func updateSearchResults(for searchController: UISearchController) {
        print("서치바에 입력되는 단어", searchController.searchBar.text ?? "")
        // 글자를 치는 순간에 다른 화면을 보여주고 싶다면 (컬렉션뷰를 보여줌)
        let vc = searchController.searchResultsController as! SearchResultViewController
        // 컬렉션뷰에 찾으려는 단어 전달
        vc.searchTerm = searchController.searchBar.text ?? ""
        //테스트테스트
    }
}

//extension ViewController : UISearchBarDelegate {
//        //유저가 글자를 입력하는 순간마다 호출되는 메서드
////        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
////
////            print(searchText)
////            // 다시 빈 배열로 만들기 ⭐️
////            self.musicArray = []
////
////            // 네트워킹 시작
////            networkManager.fetchMusic(searchTerm: searchText) { result in
////                switch result {
////                case .success(let musicDatas):
////                    self.musicArray = musicDatas
////                    DispatchQueue.main.async {
////                        self.musicTableView.reloadData()
////                    }
////                case .failure(let error):
////                    print(error.localizedDescription)
////                }
////            }
////        }
//    //    // 검색(Search) 버튼을 눌렀을때 호출되는 메서드
////        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
////            guard let text = searchController.searchBar.text else {
////                return
////            }
////            print(text)
////            // 다시 빈 배열로 만들기 ⭐️
////            self.musicArray = []
////
////            // 네트워킹 시작
////            networkManager.fetchMusic(searchTerm: text) { result in
////                switch result {
////                case .success(let musicDatas):
////                    self.musicArray = musicDatas
////                    DispatchQueue.main.async {
////                        self.musicTableView.reloadData()
////                    }
////                case .failure(let error):
////                    print(error.localizedDescription)
////                }
////            }
////            self.view.endEditing(true)
////        }
//
//}


