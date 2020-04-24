//
//  Data.swift
//  MusicListSwiftUi
//
//  Created by yas on 2020/04/18.
//  Copyright © 2020 yas. All rights reserved.
//

import AlamofireImage
import MediaPlayer

let playlistData: [Playlist] = load()
let imageDownloader = ImageDownloader()

func load() -> [Playlist] {
    var musicPlaylists: [Playlist] = []
    // プレイリスト取得
    let myPlaylistQuery = MPMediaQuery.playlists()
    if let playlists = myPlaylistQuery.collections {
        for playlist in playlists.reversed() {
            var tmpPlaylist = Playlist()

            // プレイリスト名取得
            if let name = playlist.value(forProperty: MPMediaPlaylistPropertyName) as? String {
                tmpPlaylist.name = name
            }

            // AppleMusicのアルバムアートワーク取得
            if let artworkCatalog = playlist.value(forKey: "artworkCatalog") as? NSObject,
                let token = artworkCatalog.value(forKey: "token") as? NSObject,
                let availableArtworkToken = token.value(forKey: "availableArtworkToken") as? String {

                tmpPlaylist.imageUrl = URL(string: availableArtworkToken)
            }

            // プレイリストのアルバムアートワーク取得
            if let image = playlist.representativeItem?.artwork?.image(at: CGSize(width: 80, height: 80)) {
                tmpPlaylist.image = image
            }

            tmpPlaylist.playlist = playlist
            musicPlaylists.append(tmpPlaylist)
        }
    }
    return musicPlaylists
}
