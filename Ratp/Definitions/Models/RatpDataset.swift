//
//  RatpDataset.swift
//  Ratp
//
//  Created by Benoit Briatte on 01/06/2022.
//

import Foundation

class RatpDataset {
    var id: String
    var uid: String
    var hasRecords: Bool
    var features: [String]
    var visibility: String
    var attachments: [RatpAttachment]
    var dataVisible: Bool
    var meta: RatpMeta
    
    init(id: String, uid: String, hasRecords: Bool, features: [String], visibility: String, attachments: [RatpAttachment], dataVisible: Bool, meta: RatpMeta) {
        self.id = id
        self.uid = uid
        self.hasRecords = hasRecords
        self.features = features
        self.visibility = visibility
        self.attachments = attachments
        self.dataVisible = dataVisible
        self.meta = meta
    }
    
    convenience init?(dict: [String: Any]) {
        guard let dataset = dict["dataset"] as? [String: Any],
              let id = dataset["dataset_id"] as? String,
              let uid = dataset["dataset_uid"] as? String,
              let hasRecords = dataset["has_records"] as? Bool,
              let features = dataset["features"] as? [String],
              let visibility = dataset["visibility"] as? String,
              let attachments = dataset["attachments"] as? [ [String: Any] ],
              let dataVisible = dataset["data_visible"] as? Bool,
              let metas = dataset["metas"] as? [String: Any],
              let metaObject = RatpMeta(dict: metas) else {
            return nil
        }
        let attachmentObjects = attachments.compactMap { obj in
            return RatpAttachment(dict: obj)
        }
        self.init(id: id, uid: uid, hasRecords: hasRecords, features: features, visibility: visibility, attachments: attachmentObjects, dataVisible: dataVisible, meta: metaObject)
    }
    
}
