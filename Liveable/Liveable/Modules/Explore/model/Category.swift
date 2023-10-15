
import Foundation

struct Category: Codable {
    let id: Int
    let imageURL: String
    let name: String

    static let categoryExample : [Category] = [  Category(id: 0, imageURL: "https://firebasestorage.googleapis.com/v0/b/liveable-c0c2d.appspot.com/o/category%2Fflame.png?alt=media&token=ccc734c4-cfac-4dd4-935e-422c78b02373&_gl=1*p9b6jl*_ga*MTM0OTAxODY1Mi4xNjc4NzIyNDQ3*_ga_CW55HF8NVT*MTY5NjI1MjU2MC42My4xLjE2OTYyNTQ2MjEuNTguMC4w", name: "Populer"),Category(id: 1, imageURL: "https://firebasestorage.googleapis.com/v0/b/liveable-c0c2d.appspot.com/o/category%2Fboat.png?alt=media&token=35c48068-ce7d-46e1-9499-e071e0ba3e24&_gl=1*u94pvm*_ga*MTM0OTAxODY1Mi4xNjc4NzIyNDQ3*_ga_CW55HF8NVT*MTY5NjI1MjU2MC42My4xLjE2OTYyNTQ2NzIuNy4wLjA", name: "Boats")
    ]
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
        case name
    }
}
