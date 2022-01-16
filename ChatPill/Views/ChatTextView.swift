////
////  ChatTextView.swift
////  ChatPill
////
////  Created by Akshat Sharma on 16/01/22.
////
//
//import Foundation
//import UIKit
//
//class ChatTextView: UIView {
//
//    private let maxHeight: CGFloat = 100
//    private let minHeight: CGFloat = 50
//
//    private let textView: UITextView = {
//        let view = UITextView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    private let placeHolderLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//}
//
//extension ChatTextView: UITextViewDelegate {
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        placeHolderLabel.isHidden = !textView.text.isEmpty
//    }
//
//    func textViewDidChange(_ textView: UITextView) {
//        var height = self.minHeight
//
//        if textView.contentSize.height <= self.minHeight {
//            height = self.minHeight
//        } else if textView.contentSize.height >= self.maxHeight {
//            height = self.maxHeight
//        } else {
//            height = textView.contentSize.height
//        }
//
//        self.placeHolderLabel.isHidden = !textView.text.isEmpty
//
//        self.commentConstraint.constant = height
//        UIView.animate(withDuration: 0.1) {
//            self.view.layoutIfNeeded()
//        }
//    }
//}
