//
//  MusicCell.swift
//  MinshellMusicApp
//
//  Created by DongMin Hwang on 2022/12/18.
//

import UIKit

class MusicCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNaemLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    
    //이미지 URL을 전달받는 속성
    //이미지 자체를 전달하는게 아닌 이미지 URL를 전달하게 구현해놓음
    var imageUrl: String? {
        didSet { //속성 감시자
            loadImage()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // URL ===> 이미지를 셋팅하는 메서드
    private func loadImage() {
        guard let urlString = self.imageUrl, let url = URL(string: urlString)  else { return }
        
        DispatchQueue.global().async {
        
            guard let data = try? Data(contentsOf: url) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
            guard self.imageUrl! == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
    
}
