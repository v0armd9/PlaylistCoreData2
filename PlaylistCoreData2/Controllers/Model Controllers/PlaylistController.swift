//
//  PlaylistController.swift
//  PlaylistCoreData2
//
//  Created by Darin Marcus Armstrong on 6/19/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import Foundation
import CoreData

class PlaylistController {
    
    static let sharedInstance = PlaylistController()
    
    var playlists: [Playlist] {
        //Create a fetch request that specifically references our Playlist Model Object
        let request: NSFetchRequest<Playlist> = Playlist.fetchRequest()
        //Use that fetch request to ask the managedobjectcontext for all playlist model objects that exist inside that moc
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    
    func createPlaylistWith(name: String) {
        Playlist(name: name)
        saveToPersistentStore()
    }
    
    func delete(playlist: Playlist){
        if let moc = playlist.managedObjectContext {
            moc.delete(playlist)
            saveToPersistentStore()
        }
    }
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch {
            print("Error saving to moc: \(error.localizedDescription)")
        }
    }
    
    
}
