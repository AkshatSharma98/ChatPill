//
//  ResponseModel.swift
//  ChatPill
//
//  Created by Akshat Sharma on 17/01/22.
//

import Foundation

protocol ResponseModel: AnyObject {
    var statusCode: Int? { get }
    var message: String? { get }
}
