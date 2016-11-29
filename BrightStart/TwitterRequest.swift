import Foundation
import Accounts
import Social
import CoreLocation

private var twitterAccount: ACAccount?

open class TwitterRequest
{
    struct TwitterKey {
        static let Count = "count"
        static let Query = "q"
        static let Tweets = "statuses"
        static let ResultType = "result_type"
        static let ResultTypeRecent = "recent"
        static let ResultTypePopular = "popular"
        static let Geocode = "geocode"
        static let SearchForTweets = "search/tweets"
        static let MaxID = "max_id"
        static let SinceID = "since_id"
        struct SearchMetadata {
            static let MaxID = "search_metadata.max_id_str"
            static let NextResults = "search_metadata.next_results"
            static let Separator = "&"
        }
    }
}
