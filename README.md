# LastFMAlbums
App has 4 screens. Start (Main) screen. It shows all locally stored albums presented in a UICollectionView. From here the user can navigate to album detail-page. The navigation bar contains a search button, which opens the search screen.

Search screen. It provides functionality for artists' search and presents the search results in a list. A selection of one list-item opens the albums screen.

Albums screen. It represented with a list of albums released by the selected artist. The user can store and delete stored albums locally. By tapping on an album the user opens the album detail page.

Album detail page: It is an overview with information details (like name, artist, tracks) about the album. The user can store and delete the stored album.

Used Cocoa pods: Alamofire AlamofireImage

Used the Codable protocol to serialize the JSON For storing/saving: CoreData
