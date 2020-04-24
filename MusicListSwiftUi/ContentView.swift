//
//  ContentView.swift
//  MusicListSwiftUi
//
//  Created by yas on 2020/04/18.
//  Copyright © 2020 yas. All rights reserved.
//

import Alamofire
import AlamofireImage
import MediaPlayer
import QGrid
import SwiftUI

struct ContentView: View {
    @State private var columns: CGFloat = 4.0

    var body: some View {
        NavigationView {
            MainView(columns: $columns)
                .navigationBarTitle(Text("Playlists"))
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct MainView: View {
    @Binding var columns: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Columns:")
                Text("\(Int(min(self.$columns.wrappedValue, 5)))")
                Slider(value: self.$columns, in: 1.0...5.0, step: 1.0)
            }
            .padding(.all, 10)
            .padding([.bottom], -10)

            QGrid(playlistData, columns: Int(self.columns)) { playList in
                GridCell(playlist: playList)
            }
            .animation(.easeIn)
        }
    }
}

struct GridCell: View {
    @State private var rImage = UIImage()
    var playlist: Playlist
    var player: MPMusicPlayerController? = MPMusicPlayerController.systemMusicPlayer

    var body: some View {
        return VStack {

            Image(uiImage: self.rImage)
                .resizable()
                .scaledToFit()
                .foregroundColor(.blue)
                .onAppear {
                    if let url = self.playlist.imageUrl {
                        let urlRequest = URLRequest(url: url)
                        imageDownloader.download(urlRequest) { response in
                            if case .success(let image) = response.result {
                                self.rImage = image
                            }
                        }
                    } else {
                        self.rImage = self.playlist.image
                    }
                }
            .onTapGesture {
                if let playlist = self.playlist.playlist {
                    self.player?.setQueue(with: playlist)
                    self.player?.play()
                }
            }
            Text(self.playlist.name)
                .lineLimit(1)
                .allowsTightening(true)
                .font(.system(size: 12))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
