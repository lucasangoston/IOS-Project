//
//  RatpDatasetMockService.swift
//  Ratp
//
//  Created by Benoit Briatte on 01/06/2022.
//

import Foundation

class RatpDatasetMockService: RatpDatasetService {
    
    func fetchDatasets(completion: @escaping ([RatpDataset]) -> Void) -> Void {
        var datasets: [RatpDataset] = []
        datasets.append(RatpDataset(id: "bonjour1",
                                    uid: "1",
                                    hasRecords: false,
                                    features: [],
                                    visibility: "domain",
                                    attachments: [],
                                    dataVisible: true,
                                    meta: RatpMeta(title: "Titre1",
                                                   desc: "Desc1",
                                                   themes: [
                                                    "Theme1"
                                                   ],
                                                   keywords: [
                                                    "Keyword1"
                                                   ]
                                                  )
                                   )
        )
        datasets.append(RatpDataset(id: "bonjour2",
                                    uid: "2",
                                    hasRecords: true,
                                    features: [
                                        "analyze"
                                    ],
                                    visibility: "domain",
                                    attachments: [],
                                    dataVisible: false,
                                    meta: RatpMeta(title: "Titre2",
                                                   desc: "Desc2",
                                                   themes: [
                                                    "Theme2_1",
                                                    "Theme2_2"
                                                   ],
                                                   keywords: [
                                                    "Keyword2_1",
                                                    "Keyword2_2"
                                                   ]
                                                  )
                                   )
        )
        datasets.append(RatpDataset(id: "bonjour3",
                                    uid: "3",
                                    hasRecords: true,
                                    features: [],
                                    visibility: "domain",
                                    attachments: [
                                        RatpAttachment(id: "image1",
                                                       mimetype: "image/png",
                                                       title: "ratp4ever",
                                                       url: "https://www.ce.ratp.fr/bundles/ratpcommon/images/logo_ceratp.png")
                                    ],
                                    dataVisible: false,
                                    meta: RatpMeta(title: "Titre3",
                                                   desc: "Desc3",
                                                   themes: [],
                                                   keywords: []
                                                  )
                                   )
        )
        
        // code pour déclencher une fonction après un délai
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            completion(datasets) // permet de déclencher le callback
        }
    }
}
