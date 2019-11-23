//
//  Paggination.swift
//  Reach_Network
//
//  Created by Sameh sayed on 1/3/19.
//  Copyright © 2019 Reach. All rights reserved.
//

import Foundation

struct PaginationN: Codable {
    var total: Int
    var totalPages: Int
    var currentPage: Int

    mutating func resetCounts() {
        total = 1
        currentPage = 0
        totalPages = 1
    }

    mutating func increaseCurrentPage() {
        currentPage += 1
    }

    mutating func setTotalPages(totalPages: Int) {
        self.totalPages = totalPages
    }
}
