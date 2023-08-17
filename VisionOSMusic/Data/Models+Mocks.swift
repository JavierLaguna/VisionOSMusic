
import Foundation

extension Playlist {
    
    static let mockRockPlaylist = Playlist(
        id: UUID().uuidString,
        name: "Rock",
        image: "playlist_rock",
        author: "Javier Laguna",
        likes: 666,
        description: "My favourite rock songs",
        songs: [
            Song.mockSong,
            Song(id: UUID().uuidString, name: "Bohemian Rhapsody", album: "A Night at the Opera", albumCover: "https://i.scdn.co/image/ab67616d0000b2732629480a9a5c9dcb61e518d6", author: "Queen", duration: "5:55", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Stairway to Heaven", album: "Led Zeppelin IV", albumCover: "https://i.scdn.co/image/ab67616d0000b273f3a856228c1b8a12d7e4a05c", author: "Led Zeppelin", duration: "8:02", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Hotel California", album: "Hotel California", albumCover: "https://i.scdn.co/image/ab67616d0000b27384c3b6ed75f6d8ddaa2f0fc1", author: "Eagles", duration: "6:30", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Paint It Black", album: "Aftermath", albumCover: "https://i.scdn.co/image/ab67616d0000b2738db6b2a9d114d08a550c72e1", author: "The Rolling Stones", duration: "3:22", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Back in Black", album: "Back in Black", albumCover: "https://i.scdn.co/image/ab67616d0000b273f9e2b239897d2464d62cb66d", author: "AC/DC", duration: "4:14", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Sweet Child O' Mine", album: "Appetite for Destruction", albumCover: "https://i.scdn.co/image/ab67616d0000b273fac5f47f35db9cb3e3b9e984", author: "Guns N' Roses", duration: "5:55", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Smells Like Teen Spirit", album: "Nevermind", albumCover: "https://i.scdn.co/image/ab67616d0000b27367e369e5d70b942c3e7d3e0a", author: "Nirvana", duration: "5:01", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Highway to Hell", album: "Highway to Hell", albumCover: "https://i.scdn.co/image/ab67616d0000b273ee6c9e8a2e1b5e09d7c26a4c", author: "AC/DC", duration: "3:28", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Livin' on a Prayer", album: "Slippery When Wet", albumCover: "https://i.scdn.co/image/ab67616d0000b2738dc4b50fb4118d0e683c2b8d", author: "Bon Jovi", duration: "4:09", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Paranoid", album: "Paranoid", albumCover: "https://i.scdn.co/image/ab67616d0000b273b90d3b18068e72e401ac5b48", author: "Black Sabbath", duration: "2:50", lyrics: Song.songLyricsMock)
        ])
    
    static let mockPopPlaylist = Playlist(
        id: UUID().uuidString,
        name: "Pop",
        image: "playlist_pop",
        author: "Sophia Martinez",
        likes: 68,
        description: "The best collection of pop hits!",
        songs: [
            Song(id: UUID().uuidString, name: "Shape of You", album: "÷", albumCover: "https://i.scdn.co/image/ab67616d0000b273b828b7c1069694559bf9f8e1", author: "Ed Sheeran", duration: "3:53", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Blinding Lights", album: "After Hours", albumCover: "https://i.scdn.co/image/ab67616d0000b2737b049dca4bca196f723f7919", author: "The Weeknd", duration: "3:20", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Uptown Funk", album: "Uptown Special", albumCover: "https://i.scdn.co/image/ab67616d0000b273f97e9c4c6b68a29e0d2372f6", author: "Mark Ronson ft. Bruno Mars", duration: "4:30", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Havana", album: "Camila", albumCover: "https://i.scdn.co/image/ab67616d0000b273b7ee60395a8a499d20163d45", author: "Camila Cabello", duration: "3:37", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Someone Like You", album: "21", albumCover: "https://i.scdn.co/image/ab67616d0000b2735b77ddc3c6e551135b4b8094", author: "Adele", duration: "4:45", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Thinking Out Loud", album: "x", albumCover: "https://i.scdn.co/image/ab67616d0000b273c9a2395d98c3f3f94472a190", author: "Ed Sheeran", duration: "4:41", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Love Me Like You Do", album: "Fifty Shades of Grey", albumCover: "https://i.scdn.co/image/ab67616d0000b273c9a2395d98c3f3f94472a190", author: "Ellie Goulding", duration: "4:10", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Roar", album: "Prism", albumCover: "https://i.scdn.co/image/ab67616d0000b2736d15e91b56fa44d6c8c910c7", author: "Katy Perry", duration: "3:42", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Can't Stop the Feeling!", album: "Trolls", albumCover: "https://i.scdn.co/image/ab67616d0000b273ac6a41a2ce8922df0f10e3a1", author: "Justin Timberlake", duration: "3:56", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Rolling in the Deep", album: "21", albumCover: "https://i.scdn.co/image/ab67616d0000b2735b77ddc3c6e551135b4b8094", author: "Adele", duration: "3:48", lyrics: Song.songLyricsMock)
        ]
    )
    
    static let mockBluesPlaylist = Playlist(
        id: UUID().uuidString,
        name: "Blues",
        image: "playlist_blues",
        author: "Robert Johnson",
        likes: 12,
        description: "Classic and soulful blues tunes.",
        songs: [
            Song(id: UUID().uuidString, name: "Cross Road Blues", album: "The Complete Recordings", albumCover: "https://i.scdn.co/image/ab67616d0000b273b3c7634916e000dd3094a28b", author: "Robert Johnson", duration: "2:41", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Stormy Monday", album: "The Best of T-Bone Walker", albumCover: "https://i.scdn.co/image/ab67616d0000b273260a0e2567f8c62aa6acdbc9", author: "T-Bone Walker", duration: "3:03", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Hoochie Coochie Man", album: "The Real Folk Blues", albumCover: "https://i.scdn.co/image/ab67616d0000b2737e17b6ff6142b3201df43db6", author: "Muddy Waters", duration: "2:50", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Sweet Little Angel", album: "Live at the Regal", albumCover: "https://i.scdn.co/image/ab67616d0000b2737683c05a90b437105d43803f", author: "B.B. King", duration: "3:54", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Born Under a Bad Sign", album: "Born Under a Bad Sign", albumCover: "https://i.scdn.co/image/ab67616d0000b273d43b38399c9c76c25a1311f9", author: "Albert King", duration: "2:45", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "I'm Tore Down", album: "Blues Breakers with Eric Clapton", albumCover: "https://i.scdn.co/image/ab67616d0000b273c7b0e075ae856a4245f309ef", author: "Freddie King", duration: "3:03", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Boom Boom", album: "Burnin'", albumCover: "https://i.scdn.co/image/ab67616d0000b273a8260b6030de5507ccf8f507", author: "John Lee Hooker", duration: "2:28", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "I Can't Quit You Baby", album: "The Real Folk Blues", albumCover: "https://i.scdn.co/image/ab67616d0000b2737e17b6ff6142b3201df43db6", author: "Willie Dixon", duration: "3:42", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Dust My Broom", album: "The Sky Is Crying", albumCover: "https://i.scdn.co/image/ab67616d0000b273cb0844f078df49199e7b83d7", author: "Elmore James", duration: "2:52", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "The Thrill Is Gone", album: "Completely Well", albumCover: "https://i.scdn.co/image/ab67616d0000b273da4e685e8881ef1b7e61c6ee", author: "B.B. King", duration: "5:24", lyrics: Song.songLyricsMock)
        ]
    )
    
    static let mockFunkPlaylist = Playlist(
        id: UUID().uuidString,
        name: "Funk",
        image: "playlist_funk",
        author: "Jamal Williams",
        likes: 82,
        description: "Groovy and energetic funk hits.",
        songs: [
            Song(id: UUID().uuidString, name: "Superstition", album: "Talking Book", albumCover: "https://i.scdn.co/image/ab67616d0000b273de8a8d95620f7eb6e0fca50b", author: "Stevie Wonder", duration: "4:26", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Uptown Funk", album: "Uptown Special", albumCover: "https://i.scdn.co/image/ab67616d0000b273f97e9c4c6b68a29e0d2372f6", author: "Mark Ronson ft. Bruno Mars", duration: "4:30", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Get Down On It", album: "Something Special", albumCover: "https://i.scdn.co/image/ab67616d0000b273aa5d08de9712a1289c8e2d87", author: "Kool & The Gang", duration: "4:54", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Le Freak", album: "C'est Chic", albumCover: "https://i.scdn.co/image/ab67616d0000b2733f4baf63e1d049f6f029a87b", author: "Chic", duration: "5:29", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Play That Funky Music", album: "Wild Cherry", albumCover: "https://i.scdn.co/image/ab67616d0000b273131a1cf397d638d87308db8a", author: "Wild Cherry", duration: "3:10", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Brick House", album: "Commodores", albumCover: "https://i.scdn.co/image/ab67616d0000b273a10187a01e01f0b294a1f1c1", author: "Commodores", duration: "3:26", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Give Up the Funk (Tear the Roof Off the Sucker)", album: "Mothership Connection", albumCover: "https://i.scdn.co/image/ab67616d0000b273a1c24a1594609fc48fde6150", author: "Parliament", duration: "5:43", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Jungle Boogie", album: "Wild and Peaceful", albumCover: "https://i.scdn.co/image/ab67616d0000b2735d5e381b14d5a2e2a8706eaf", author: "Kool & The Gang", duration: "3:06", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Get Up (I Feel Like Being a) Sex Machine", album: "Sex Machine", albumCover: "https://i.scdn.co/image/ab67616d0000b273a38987cc3e8c69946f0d84b6", author: "James Brown", duration: "5:17", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Dance to the Music", album: "Dance to the Music", albumCover: "https://i.scdn.co/image/ab67616d0000b27355cc0d4c1914b2d4cfd8d316", author: "Sly & The Family Stone", duration: "2:59", lyrics: Song.songLyricsMock)
        ]
    )
    
    static let mockRapPlaylist = Playlist(
        id: UUID().uuidString,
        name: "Hip Hop/Rap",
        image: "playlist_rap",
        author: "Alex Carter",
        likes: 0,
        description: "The hottest hip hop and rap tracks.",
        songs: [
            Song(id: UUID().uuidString, name: "Sicko Mode", album: "ASTROWORLD", albumCover: "https://i.scdn.co/image/ab67616d0000b273c818b8bf58c65fc2974c13d1", author: "Travis Scott", duration: "5:12", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "God's Plan", album: "Scorpion", albumCover: "https://i.scdn.co/image/ab67616d0000b2735c3192b5952c6ea6e5d8d33e", author: "Drake", duration: "3:18", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Lose Yourself", album: "8 Mile Soundtrack", albumCover: "https://i.scdn.co/image/ab67616d0000b273a2d46d7507a7336dd862f90a", author: "Eminem", duration: "5:20", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "HUMBLE.", album: "DAMN.", albumCover: "https://i.scdn.co/image/ab67616d0000b2737f60e1105acdc016a6c64b73", author: "Kendrick Lamar", duration: "2:57", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Sicko Mode", album: "ASTROWORLD", albumCover: "https://i.scdn.co/image/ab67616d0000b273c818b8bf58c65fc2974c13d1", author: "Travis Scott", duration: "5:12", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Old Town Road (Remix)", album: "Old Town Road", albumCover: "https://i.scdn.co/image/ab67616d0000b273e47dfb7884ee485d6f6b9d5f", author: "Lil Nas X ft. Billy Ray Cyrus", duration: "2:37", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Hotline Bling", album: "Views", albumCover: "https://i.scdn.co/image/ab67616d0000b273d8a2ff4f7695d0fb8f2b9947", author: "Drake", duration: "4:27", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Sicko Mode", album: "ASTROWORLD", albumCover: "https://i.scdn.co/image/ab67616d0000b273c818b8bf58c65fc2974c13d1", author: "Travis Scott", duration: "5:12", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "ROXANNE", album: "ROXANNE", albumCover: "https://i.scdn.co/image/ab67616d0000b27312aa0f3d09589c36390c7c48", author: "Arizona Zervas", duration: "2:44", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Bad and Boujee (feat. Lil Uzi Vert)", album: "Culture", albumCover: "https://i.scdn.co/image/ab67616d0000b2734cd30e27c7d9fb44a5d65be0", author: "Migos", duration: "5:43", lyrics: Song.songLyricsMock)
        ]
    )
    
    static let mockTechnoPlaylist = Playlist(
        id: UUID().uuidString,
        name: "Techno",
        image: "playlist_techno",
        author: "Elena Rodriguez",
        likes: 0,
        description: "Energetic and hypnotic techno beats.",
        songs: [
            Song(id: UUID().uuidString, name: "Windowlicker", album: "Windowlicker", albumCover: "https://i.scdn.co/image/ab67616d0000b273deedeb2d199e61e0c0026c3c", author: "Aphex Twin", duration: "6:07", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Born Slippy .NUXX", album: "Second Toughest in the Infants", albumCover: "https://i.scdn.co/image/ab67616d0000b27396345d49f5c176d74146e24b", author: "Underworld", duration: "9:43", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "No Good (Start the Dance)", album: "The Fat of the Land", albumCover: "https://i.scdn.co/image/ab67616d0000b27384039e2e1667f077444d256c", author: "The Prodigy", duration: "6:18", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Spastik", album: "Art of Technology", albumCover: "https://i.scdn.co/image/ab67616d0000b2734f6bf9c6e6a0e45e991f80cd", author: "Plastikman", duration: "9:00", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Breathe", album: "The Fat of the Land", albumCover: "https://i.scdn.co/image/ab67616d0000b27384039e2e1667f077444d256c", author: "The Prodigy", duration: "5:35", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Voodoo People", album: "Music for the Jilted Generation", albumCover: "https://i.scdn.co/image/ab67616d0000b273af1284c07821e91523e84ca7", author: "The Prodigy", duration: "4:06", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Strobe", album: "For Lack of a Better Name", albumCover: "https://i.scdn.co/image/ab67616d0000b273c8f032a68b6592df74ee5da7", author: "deadmau5", duration: "10:37", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Acid Trax", album: "Acid Trax - Single", albumCover: "https://i.scdn.co/image/ab67616d0000b27304876b7b5b5e9536b8a21d14", author: "Phuture", duration: "12:15", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Blue Monday", album: "Power, Corruption & Lies", albumCover: "https://i.scdn.co/image/ab67616d0000b2734dd609d6575e740b0774311c", author: "New Order", duration: "7:29", lyrics: Song.songLyricsMock),
            Song(id: UUID().uuidString, name: "Energy Flash", album: "Energy Flash", albumCover: "https://i.scdn.co/image/ab67616d0000b273d07f28e3280571cc4d43153f", author: "Joey Beltram", duration: "5:50", lyrics: Song.songLyricsMock)
        ]
    )
    
    static let mockPlaylists = [
        mockRockPlaylist,
        mockPopPlaylist,
        mockBluesPlaylist,
        mockFunkPlaylist,
        mockRapPlaylist,
        mockTechnoPlaylist
    ]
}

extension Song {
    
    static let mockSong = Song(
        id: UUID().uuidString,
        name: "Battery",
        album: "Master Of Puppets",
        albumCover: "https://i.scdn.co/image/ab67616d0000b2736976009675621c80cafa1ff5",
        author: "Metallica",
        duration: "5:12",
        lyrics: """
 Lashing out the action
 
 Returning a reaction
 
 Weak are ripped and torn away
 
 Hypnotizing power
 
 Crushing all that cower
 
 Battery is here to stay
 
 Smashing through the boundaries
 
 Lunacy has found me
 
 Cannot stop the battery
 
 ♪
 
 Pounding out aggression
 
 Turns into obsession
 
 Cannot kill the battery
 
 Cannot kill the family
 
 Battery is found in me
 
 Battery
 
 Battery
 
 Crushing all deceivers
 
 Mashing non-believers
 
 Never ending potency
 
 Hungry violence seeker
 
 Feeding off the weaker
 
 Breeding on insanity
 
 Smashing through the boundaries
 
 Lunacy has found me
 
 Cannot stop the battery
 
 ♪
 
 Pounding out aggression
 
 Turns into obsession
 
 Cannot kill the battery
 
 Cannot kill the family
 
 Battery is found in me
 
 Battery
 
 Battery
 
 ♪
 
 Circle of destruction
 
 Hammer comes crushing
 
 Powerhouse of energy
 
 Whipping up a fury
 
 Dominating flurry
 
 We create the battery
 
 Smashing through the boundaries
 
 Lunacy has found me
 
 Cannot stop the battery
 
 ♪
 
 Pounding out aggression
 
 Turns into obsession
 
 Cannot kill the battery
 
 Cannot kill the family
 
 Battery is found in me
 
 Battery
 
 Battery
 
 Battery
 
 Battery
 """,
        youtubeId: "_efOnc3onfQ"
    )
    
    static let songLyricsMock = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis quis luctus nisl, in sodales turpis. Aliquam id condimentum mauris, eu lacinia nisl. Praesent egestas lacus vitae auctor congue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec vel imperdiet magna, ut interdum mi. Quisque nec congue sem, nec cursus massa. Sed sapien est, dapibus ut neque id, feugiat bibendum massa. Duis auctor tortor a luctus tincidunt. Etiam eu ex sagittis, accumsan ipsum vitae, tempus lectus. Duis at lorem a nulla tristique fermentum ut vel nisi. Sed eu augue ultrices, vehicula leo a, maximus lorem. Nam efficitur consequat ex id fringilla. Nunc semper urna in vehicula condimentum. Nunc sed arcu placerat, ultricies nunc vel, congue risus. In tincidunt imperdiet libero, eleifend feugiat magna euismod sed.

Quisque auctor varius ultrices. Mauris auctor, ligula nec pharetra commodo, dolor turpis venenatis tellus, nec rhoncus turpis orci ac diam. Duis cursus arcu sed nisi pulvinar tempus. Curabitur eu hendrerit nisl. Aliquam ac sodales felis. Sed vitae nulla consequat, efficitur est ac, rutrum leo. Cras posuere venenatis leo a fermentum. Ut pulvinar scelerisque purus ac pellentesque. Ut maximus urna nunc. Maecenas laoreet massa eget nibh consequat tincidunt. Suspendisse non sapien nec dolor facilisis porttitor quis vel justo. Fusce eget elementum ligula. Pellentesque eget velit eu sapien dictum facilisis. Cras vel neque et velit fringilla luctus. Donec euismod et quam vitae tempus.

Morbi imperdiet, risus sollicitudin auctor tincidunt, mauris eros lobortis massa, tempus ullamcorper ipsum eros ut enim. Vestibulum bibendum ullamcorper orci, a feugiat orci. Curabitur sodales aliquam lobortis. Phasellus et leo in neque posuere aliquet. Suspendisse vel nunc condimentum, fringilla mauris ut, ultricies lacus. Donec eget tortor in ipsum mollis pellentesque. Nunc vitae iaculis quam. Donec bibendum arcu sit amet arcu consectetur, eu venenatis nisl fringilla. Proin fringilla malesuada consectetur. Nulla eu augue a urna luctus molestie quis tempus leo. Donec hendrerit ut dui at tempus. Sed sodales ligula eu nulla maximus consequat. Nunc hendrerit enim id metus tincidunt, ac consequat enim condimentum. Suspendisse hendrerit diam ac gravida porta. Donec ut justo non erat aliquam tristique eu ut massa. Mauris ac neque vel diam dignissim varius.
"""
}
