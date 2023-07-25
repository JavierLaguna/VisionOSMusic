
import Foundation

extension Playlist {
    
    static let mockPlaylist = mockPlaylists.first!
    
    static let mockPlaylists = [
        Playlist(id: UUID().uuidString, name: "Rock", image: "playlist_rock", author: "Javier Laguna", likes: 666, description: nil,
                 songs: [
                    Song.mockSong,
                    Song(id: UUID().uuidString, name: "Bohemian Rhapsody", album: "A Night at the Opera", albumCover: "https://i.scdn.co/image/ab67616d0000b2732629480a9a5c9dcb61e518d6", author: "Queen", duration: "5:55"),
                    Song(id: UUID().uuidString, name: "Stairway to Heaven", album: "Led Zeppelin IV", albumCover: "https://i.scdn.co/image/ab67616d0000b273f3a856228c1b8a12d7e4a05c", author: "Led Zeppelin", duration: "8:02"),
                    Song(id: UUID().uuidString, name: "Hotel California", album: "Hotel California", albumCover: "https://i.scdn.co/image/ab67616d0000b27384c3b6ed75f6d8ddaa2f0fc1", author: "Eagles", duration: "6:30"),
                    Song(id: UUID().uuidString, name: "Paint It Black", album: "Aftermath", albumCover: "https://i.scdn.co/image/ab67616d0000b2738db6b2a9d114d08a550c72e1", author: "The Rolling Stones", duration: "3:22"),
                    Song(id: UUID().uuidString, name: "Back in Black", album: "Back in Black", albumCover: "https://i.scdn.co/image/ab67616d0000b273f9e2b239897d2464d62cb66d", author: "AC/DC", duration: "4:14"),
                    Song(id: UUID().uuidString, name: "Sweet Child O' Mine", album: "Appetite for Destruction", albumCover: "https://i.scdn.co/image/ab67616d0000b273fac5f47f35db9cb3e3b9e984", author: "Guns N' Roses", duration: "5:55"),
                    Song(id: UUID().uuidString, name: "Smells Like Teen Spirit", album: "Nevermind", albumCover: "https://i.scdn.co/image/ab67616d0000b27367e369e5d70b942c3e7d3e0a", author: "Nirvana", duration: "5:01"),
                    Song(id: UUID().uuidString, name: "Highway to Hell", album: "Highway to Hell", albumCover: "https://i.scdn.co/image/ab67616d0000b273ee6c9e8a2e1b5e09d7c26a4c", author: "AC/DC", duration: "3:28"),
                    Song(id: UUID().uuidString, name: "Livin' on a Prayer", album: "Slippery When Wet", albumCover: "https://i.scdn.co/image/ab67616d0000b2738dc4b50fb4118d0e683c2b8d", author: "Bon Jovi", duration: "4:09"),
                    Song(id: UUID().uuidString, name: "Paranoid", album: "Paranoid", albumCover: "https://i.scdn.co/image/ab67616d0000b273b90d3b18068e72e401ac5b48", author: "Black Sabbath", duration: "2:50")
                 ]),
        Playlist(id: UUID().uuidString, name: "Rock", image: "", author: "Javier Laguna", likes: 666, description: nil, songs: []),
        Playlist(id: UUID().uuidString, name: "Rock", image: "", author: "Javier Laguna", likes: 666, description: nil, songs: []),
        Playlist(id: UUID().uuidString, name: "Rock", image: "", author: "Javier Laguna", likes: 666, description: nil, songs: []),
        Playlist(id: UUID().uuidString, name: "Rock", image: "", author: "Javier Laguna", likes: 666, description: nil, songs: [])
    ]
}

extension Song {
    
    static let mockSong = Song(id: UUID().uuidString, name: "Battery", album: "Master Of Puppets", albumCover: "https://i.scdn.co/image/ab67616d0000b2736976009675621c80cafa1ff5", author: "Metallica", duration: "5:12")
}
