//
//  DatePickerInputView.swift
//  MisCasosRx
//
//  Created by NamTrinh on 17/07/2024.
//

import Foundation
import SwiftUI

struct DatePickerInputView: UIViewRepresentable {
    @Binding var date: Date?
    let placeholder: String
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    init(date: Binding<Date?>, placeholder: String) {
        self._date = date
        self.placeholder = placeholder
    }
    
    func updateUIView(_ uiView: DatePickerTextField, context: Context) {
        if let date = date {
            uiView.text = dateFormatter.string(from: date)
        } else {
            uiView.text = ""
        }
    }
    
    func makeUIView(context: Context) -> DatePickerTextField {
        let dptf = DatePickerTextField(date: $date, frame: .zero)
        dptf.placeholder = placeholder
        if let date = date {
            dptf.text = dateFormatter.string(from: date)
        } else {
            dptf.text = ""
        }
        
        return dptf
    }
    
}

final class DatePickerTextField: UITextField {
    @Binding var date: Date?
    private let datePicker = UIDatePicker()
    
    init(date: Binding<Date?>, frame: CGRect) {
        self._date = date
        super.init(frame: frame)
        self.font = .systemFont(ofSize: 16)
        datePicker.addTarget(self, action: #selector(datePickerDidSelect(_:)), for: .valueChanged)
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissTextField))
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        inputAccessoryView = toolBar
        inputView = datePicker
        
        
        // Customize appearance
        self.backgroundColor = UIColor.systemGray6 // Set background color
        self.layer.cornerRadius = 8 // Set corner radius
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0)) // Add left padding
        self.leftViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func datePickerDidSelect(_ sender: UIDatePicker) {
        date = sender.date
    }

    @objc private func dismissTextField() {
        resignFirstResponder()
    }
    
}
