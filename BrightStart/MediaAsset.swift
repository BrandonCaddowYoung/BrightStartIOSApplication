

import Foundation

public struct MediaAsset
{
    public var url: URL!
    public var aspectRatio: Double = 0
    
    public var description: String { return (url.absoluteString ?? "no url") + " (aspect ratio = \(aspectRatio))" }
    
    // MARK: - Private Implementation

    init?(data: NSDictionary?) {
        var valid = false
        if let urlString = data?.value(forKeyPath: TwitterKey.MediaURL) as? NSString {
            if let url = URL(string: urlString as String) {
                self.url = url
                let h = data?.value(forKeyPath: TwitterKey.Height) as? NSNumber
                let w = data?.value(forKeyPath: TwitterKey.Width) as? NSNumber
                if h != nil && w != nil && h?.doubleValue != 0 {
                    aspectRatio = w!.doubleValue / h!.doubleValue
                    valid = true
                }
            }
        }
        if !valid {
            return nil
        }
    }
    
    struct TwitterKey {
        static let MediaURL = "media_url_https"
        static let Width = "sizes.small.w"
        static let Height = "sizes.small.h"
    }
}
