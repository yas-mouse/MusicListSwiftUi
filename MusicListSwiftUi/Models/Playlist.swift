//
//  Playlist.swift
//  MusicListSwiftUi
//
//  Created by yas on 2020/04/18.
//  Copyright © 2020 yas. All rights reserved.
//

// swiftlint:disable identifier_name

import MediaPlayer

struct Playlist: Identifiable {
    let id = UUID()
    var name: String = ""
    var image: UIImage = UIImage(systemName: "headphones")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    var imageUrl: URL?
    var playlist: MPMediaItemCollection?
}
