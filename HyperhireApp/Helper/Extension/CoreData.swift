//
//  CoreData.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 08/12/24.
//

import UIKit
import CoreData

class CoreDataLibrary {
    
    static func createPlaylist(name: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let playlist = PlaylistData(context: context)
        playlist.id = UUID()
        playlist.name = name
        
        do {
            try context.save()
        } catch {
            print("Failed to create playlist: \(error.localizedDescription)")
        }
    }
    
    static func addTrack(to playlist: PlaylistData, track: Track) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let song = SongData(context: context)
        song.artworkUrl60 = track.artworkUrl60
        song.artistName = track.artistName
        song.collectionName = track.collectionName
        song.trackName = track.trackName
        song.playlist = playlist
        
        do {
            try context.save()
        } catch {
            print("Failed to add song: \(error.localizedDescription)")
        }
    }
    
    static func fetchPlaylist() -> [PlaylistData] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<PlaylistData> = PlaylistData.fetchRequest()

        do {
            return try context.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    static func fetchPlaylist(byName name: String) -> PlaylistData? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<PlaylistData> = PlaylistData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let playlists = try context.fetch(fetchRequest)
            return playlists.first
        } catch {
            return nil
        }
    }
    
    static func fetchSongs(from playlist: PlaylistData) -> [SongData] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SongData> = SongData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "playlist == %@", playlist)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return []
        }
    }
}
