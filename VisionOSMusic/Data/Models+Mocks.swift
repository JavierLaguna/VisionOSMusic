
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
            Song(
                id: UUID().uuidString,
                name: "Bohemian Rhapsody",
                album: "A Night at the Opera",
                albumCover: "https://upload.wikimedia.org/wikipedia/en/4/4d/Queen_A_Night_At_The_Opera.png",
                author: "Queen",
                duration: "5:55",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Stairway to Heaven",
                album: "Led Zeppelin IV",
                albumCover: "https://m.media-amazon.com/images/I/81evsr3Oq0L._UF894,1000_QL80_.jpg",
                author: "Led Zeppelin",
                duration: "8:02",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Hotel California",
                album: "Hotel California",
                albumCover: "https://pure-music.co.uk/wp-content/uploads/2019/04/Hotel-California-Album-Cover.png",
                author: "Eagles",
                duration: "6:30",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Paint It Black",
                album: "Aftermath",
                albumCover: "https://m.media-amazon.com/images/I/61CrHNb6JWL._UF894,1000_QL80_.jpg",
                author: "The Rolling Stones",
                duration: "3:22",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Back in Black",
                album: "Back in Black",
                albumCover: "https://i1.wp.com/www.scienceofnoise.net/wp-content/uploads/2020/07/068660474366a63e1263e53ff370eb50.jpg",
                author: "AC/DC",
                duration: "4:14",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Sweet Child O' Mine",
                album: "Appetite for Destruction",
                albumCover: "https://m.media-amazon.com/images/I/71H9ZR6EGFL._UF894,1000_QL80_.jpg",
                author: "Guns N' Roses",
                duration: "5:55",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Smells Like Teen Spirit",
                album: "Nevermind",
                albumCover: "https://upload.wikimedia.org/wikipedia/en/b/b7/NirvanaNevermindalbumcover.jpg",
                author: "Nirvana",
                duration: "5:01",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Highway to Hell",
                album: "Highway to Hell",
                albumCover: "https://upload.wikimedia.org/wikipedia/en/a/ac/Acdc_Highway_to_Hell.JPG",
                author: "AC/DC",
                duration: "3:28",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Livin' on a Prayer",
                album: "Slippery When Wet",
                albumCover: "https://upload.wikimedia.org/wikipedia/en/a/ab/Bon_jovi_slippery_when_wet.jpg",
                author: "Bon Jovi",
                duration: "4:09",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Paranoid",
                album: "Paranoid",
                albumCover: "https://upload.wikimedia.org/wikipedia/en/6/64/Black_Sabbath_-_Paranoid.jpg",
                author: "Black Sabbath",
                duration: "2:50",
                lyrics: Song.songLyricsMock
            )
        ])
    
    static let mockPopPlaylist = Playlist(
        id: UUID().uuidString,
        name: "Pop",
        image: "playlist_pop",
        author: "Sophia Martinez",
        likes: 68,
        description: "The best collection of pop hits!",
        songs: [
            Song(
                id: UUID().uuidString,
                name: "Shape of You",
                album: "÷",
                albumCover: "https://cdns-images.dzcdn.net/images/cover/000a9228cecfcc7c2093d9cd7bb66447/500x500.jpg",
                author: "Ed Sheeran",
                duration: "3:53",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Blinding Lights",
                album: "After Hours",
                albumCover: "https://upload.wikimedia.org/wikipedia/en/c/c1/The_Weeknd_-_After_Hours.png",
                author: "The Weeknd",
                duration: "3:20",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Uptown Funk",
                album: "Uptown Special",
                albumCover: "",
                author: "Mark Ronson ft. Bruno Mars",
                duration: "4:30",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Havana",
                album: "Camila",
                albumCover: "",
                author: "Camila Cabello",
                duration: "3:37",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Someone Like You",
                album: "21",
                albumCover: "",
                author: "Adele",
                duration: "4:45",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Thinking Out Loud",
                album: "x",
                albumCover: "",
                author: "Ed Sheeran",
                duration: "4:41",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Love Me Like You Do",
                album: "Fifty Shades of Grey",
                albumCover: "",
                author: "Ellie Goulding",
                duration: "4:10",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Roar",
                album: "Prism",
                albumCover: "",
                author: "Katy Perry",
                duration: "3:42",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Can't Stop the Feeling!",
                album: "Trolls",
                albumCover: "",
                author: "Justin Timberlake",
                duration: "3:56",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Rolling in the Deep",
                album: "21",
                albumCover: "",
                author: "Adele",
                duration: "3:48",
                lyrics: Song.songLyricsMock
            )
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
            Song(
                id: UUID().uuidString,
                name: "Cross Road Blues",
                album: "The Complete Recordings",
                albumCover: "https://upload.wikimedia.org/wikipedia/en/9/9b/Robert_Johnson_-_The_Complete_Recordings.jpg",
                author: "Robert Johnson",
                duration: "2:41",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Stormy Monday",
                album: "The Best of T-Bone Walker",
                albumCover: "https://i.discogs.com/8bFU8fewZQ1pwtbA8Uh5qCZdBZv3GQNzik2ti8PCtr4/rs:fit/g:sm/q:40/h:300/w:300/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9SLTMzMjM3/ODgtMTMyNTc3NzQ0/Ny5qcGVn.jpeg",
                author: "T-Bone Walker",
                duration: "3:03",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Hoochie Coochie Man",
                album: "The Real Folk Blues",
                albumCover: "",
                author: "Muddy Waters",
                duration: "2:50",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Sweet Little Angel",
                album: "Live at the Regal",
                albumCover: "",
                author: "B.B. King",
                duration: "3:54",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Born Under a Bad Sign",
                album: "Born Under a Bad Sign",
                albumCover: "",
                author: "Albert King",
                duration: "2:47",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Red House",
                album: "Axis: Bold as Love",
                albumCover: "",
                author: "Jimi Hendrix",
                duration: "3:50",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "The Thrill Is Gone",
                album: "Completely Well",
                albumCover: "",
                author: "B.B. King",
                duration: "5:25",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "La Grange",
                album: "Tres Hombres",
                albumCover: "",
                author: "ZZ Top",
                duration: "3:51",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Statesboro Blues",
                album: "At Fillmore East",
                albumCover: "",
                author: "The Allman Brothers Band",
                duration: "4:18",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Good Morning Little Schoolgirl",
                album: "Good Morning Little Schoolgirl",
                albumCover: "",
                author: "Junior Wells' Chicago Blues Band",
                duration: "3:05",
                lyrics: Song.songLyricsMock
            )
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
            Song(
                id: UUID().uuidString,
                name: "Superstition",
                album: "Talking Book",
                albumCover: "https://upload.wikimedia.org/wikipedia/en/2/25/Talking_Book.jpg",
                author: "Stevie Wonder",
                duration: "4:26",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Uptown Funk",
                album: "Uptown Special",
                albumCover: "https://cdns-images.dzcdn.net/images/cover/3734366a73152d0367a83a4b09fd163f/500x500.jpg",
                author: "Mark Ronson ft. Bruno Mars",
                duration: "4:30",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Give Up the Funk (Tear the Roof off the Sucker)",
                album: "Mothership Connection",
                albumCover: "",
                author: "Parliament",
                duration: "5:46",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Play That Funky Music",
                album: "Wild Cherry",
                albumCover: "",
                author: "Wild Cherry",
                duration: "3:10",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Le Freak",
                album: "C'est Chic",
                albumCover: "",
                author: "Chic",
                duration: "3:32",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Super Freak",
                album: "Street Songs",
                albumCover: "",
                author: "Rick James",
                duration: "3:24",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Give It to Me Baby",
                album: "Street Songs",
                albumCover: "",
                author: "Rick James",
                duration: "4:08",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Brick House",
                album: "Hot on the Tracks",
                albumCover: "",
                author: "Commodores",
                duration: "3:29",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Flash Light",
                album: "Funkentelechy Vs. the Placebo Syndrome",
                albumCover: "",
                author: "Parliament",
                duration: "5:47",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Dance to the Music",
                album: "Dance to the Music",
                albumCover: "",
                author: "Sly & The Family Stone",
                duration: "2:58",
                lyrics: Song.songLyricsMock
            )
        ]
    )

    static let mockRapPlaylist = Playlist(
        id: UUID().uuidString,
        name: "Rap",
        image: "playlist_rap",
        author: "Marcus Johnson",
        likes: 95,
        description: "Hottest rap tracks in the game right now.",
        songs: [
            Song(
                id: UUID().uuidString,
                name: "Sicko Mode",
                album: "ASTROWORLD",
                albumCover: "https://upload.wikimedia.org/wikipedia/en/0/0b/Astroworld_by_Travis_Scott.jpg",
                author: "Travis Scott",
                duration: "5:12",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Lose Yourself",
                album: "8 Mile: Music from and Inspired by the Motion Picture",
                albumCover: "https://upload.wikimedia.org/wikipedia/en/3/39/8milecover.jpg",
                author: "Eminem",
                duration: "5:26",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Sick Mode",
                album: "Sick Mode",
                albumCover: "",
                author: "Sicko Mode",
                duration: "2:26",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "God's Plan",
                album: "Scorpion",
                albumCover: "",
                author: "Drake",
                duration: "3:19",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Hotline Bling",
                album: "Views",
                albumCover: "",
                author: "Drake",
                duration: "4:27",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Lucid Dreams",
                album: "Goodbye & Good Riddance",
                albumCover: "",
                author: "Juice WRLD",
                duration: "3:59",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Life Is Good",
                album: "Life Is Good",
                albumCover: "",
                author: "Future ft. Drake",
                duration: "3:58",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Savage Love",
                album: "Savage Love",
                albumCover: "",
                author: "Savage Love",
                duration: "2:51",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Sicko Mode (Remix)",
                album: "Sicko Mode (Remix)",
                albumCover: "",
                author: "Sicko Mode",
                duration: "3:16",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Life Is Good (Remix)",
                album: "Life Is Good (Remix)",
                albumCover: "",
                author: "Life Is Good (Remix)",
                duration: "4:58",
                lyrics: Song.songLyricsMock
            )
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
            Song(
                id: UUID().uuidString,
                name: "Windowlicker",
                album: "Windowlicker",
                albumCover: "",
                author: "Aphex Twin",
                duration: "6:07",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Born Slippy .NUXX",
                album: "Second Toughest in the Infants",
                albumCover: "https://cdns-images.dzcdn.net/images/cover/03db276eb48c35d2f19e59de5852c84d/264x264.jpg",
                author: "Underworld",
                duration: "9:43",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "No Good (Start the Dance)",
                album: "The Fat of the Land",
                albumCover: "https://upload.wikimedia.org/wikipedia/en/3/3b/TheProdigy-TheFatOfTheLand.jpg",
                author: "The Prodigy",
                duration: "6:18",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Spastik",
                album: "Art of Technology",
                albumCover: "",
                author: "Plastikman",
                duration: "9:00",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Breathe",
                album: "The Fat of the Land",
                albumCover: "",
                author: "The Prodigy",
                duration: "5:35",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Voodoo People",
                album: "Music for the Jilted Generation",
                albumCover: "",
                author: "The Prodigy",
                duration: "4:06",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Strobe",
                album: "For Lack of a Better Name",
                albumCover: "",
                author: "deadmau5",
                duration: "10:37",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Acid Trax",
                album: "Acid Trax - Single",
                albumCover: "",
                author: "Phuture",
                duration: "12:15",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Blue Monday",
                album: "Power, Corruption & Lies",
                albumCover: "",
                author: "New Order",
                duration: "7:29",
                lyrics: Song.songLyricsMock
            ),
            Song(
                id: UUID().uuidString,
                name: "Energy Flash",
                album: "Energy Flash",
                albumCover: "",
                author: "Joey Beltram",
                duration: "5:50",
                lyrics: Song.songLyricsMock
            )
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
