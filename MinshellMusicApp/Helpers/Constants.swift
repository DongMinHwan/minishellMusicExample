//
//  Constants.swift
//  MinshellMusicApp
//
//  Created by DongMin Hwang on 2022/12/18.
//

import UIKit

//MARK: - Name Space 만들기

//데이터 영역에 저장(열거형, 구조체 다 가능 / 전역 변수로도 선언 가능)

// 사용하게될 API 문자열 묶음
public enum MusicApi {
    static let requestUrl = "https://itunes.apple.com/search?" //type 저장속성
    static let mediaParam = "media=music"
    
    //case를 만들지 않고 type 저장속성으로 선언하면 타입저장속성에 접근할 수 있다.
    //열거형 같은경우는 저장 속성을 가질 수 없다.
//    var name = "안녕" //저장속성퓨
}

//사용하게 될 Cell 문자열 묶음
public struct Cell {
    static let musicCellIdentifier = "MusicCell"
    static let musicCollectionViewCellIdentifier = "MusicCollectionViewCell"
    private init() {} //생성자를 막아놓으면 언제든지 다른곳에서 다른곳에서 생성을 할 수 없다. 타입 저장속성에만 접근할 수있도록 구조체 인스턴스를 생성할수 없게.
}


//컬렉션뷰 구성을 위한 설정
public struct CVCell{
    static let spacingWitdh: CGFloat = 1 // 간격
    static let cellColumns: CGFloat = 3 // 칸
    private init() {}
}


//let REQUEST_URL = "https://itunes.apple.com/search?"
