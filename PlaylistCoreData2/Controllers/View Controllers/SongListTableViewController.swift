//
//  SongListTableViewController.swift
//  PlaylistCoreData2
//
//  Created by Darin Marcus Armstrong on 6/19/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import UIKit

class SongListTableViewController: UITableViewController {
    
    @IBOutlet weak var songNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    
    var playlistLandingPad: Playlist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = playlistLandingPad?.name
    }

    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = songNameTextField.text, title != "",
            let artist = artistNameTextField.text, artist != "",
            let playlist = playlistLandingPad
            else {return}
        SongController.shared.createNewSong(with: title, artist: artist, playlist: playlist)
        
        songNameTextField.text = ""
        artistNameTextField.text = ""
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return playlistLandingPad?.songs?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        
        guard let song = playlistLandingPad?.songs?[indexPath.row] as? Song else {return UITableViewCell()}
        
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artist
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let song = playlistLandingPad?.songs?[indexPath.row] as? Song else {return}
            SongController.shared.delete(song: song)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
