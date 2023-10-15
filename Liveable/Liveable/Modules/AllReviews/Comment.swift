
import Foundation

typealias Comment = [String: CommnetValue]

struct CommnetValue: Codable {
    let advertOwnerID: Int
    let commentText : String
    var commnetData: String  
    let commneterUser: CommneterUser
    let id: Int

    enum CodingKeys: String, CodingKey {
        case advertOwnerID = "advertOwnerId"
        case commentText, commnetData, commneterUser, id
    }
  
    static let exampleCommentValue =  CommnetValue(advertOwnerID: 0, commentText: "", commnetData: "", commneterUser: CommneterUser.exampleCommneterUser, id: 0)
    
    static let comments = ["AdvertComment1", "AdvertComment2", "AdvertComment3", "AdvertComment4", "AdvertComment5", "AdvertComment6", "AdvertComment7", "AdvertComment8"]
}

// MARK: - CommneterUser
struct CommneterUser: Codable {
    let imageURL: String
    let nameSurname: String

    static let exampleCommneterUser = CommneterUser(imageURL: "", nameSurname: "")
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case nameSurname
    }
}







