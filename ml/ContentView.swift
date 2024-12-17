//
//  ContentView.swift
//  ml
//
//  Created by Simarjeet Kaur on 23/11/24.
//
/*
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}
*/
/*
import SwiftUI
import CoreML

struct ContentView: View {
    // Input fields for all model parameters
    @State private var gender: String = ""
    @State private var married: String = ""
    @State private var dependents: String = ""
    @State private var education: String = ""
    @State private var selfEmployed: String = ""
    @State private var applicantIncome: String = ""
    @State private var coapplicantIncome: String = ""
    @State private var loanAmount: String = "" // New field for loan amount
    @State private var loanAmountTerm: String = ""
    @State private var creditHistory: String = ""
    @State private var propertyArea: String = ""
    
    // Output field
    @State private var loanApprovalResult: String = "Enter details to predict approval."
    /*
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Input Fields
                    Group {
                        InputField(title: "Gender (Male/Female)", placeholder: "e.g., Male", value: $gender)
                        InputField(title: "Married (Yes/No)", placeholder: "e.g., Yes", value: $married)
                        InputField(title: "Dependents", placeholder: "e.g., 0, 1, 2", value: $dependents)
                        InputField(title: "Education (Graduate/Not Graduate)", placeholder: "e.g., Graduate", value: $education)
                        InputField(title: "Self Employed (Yes/No)", placeholder: "e.g., No", value: $selfEmployed)
                        InputField(title: "Applicant Income", placeholder: "e.g., 5000", value: $applicantIncome)
                        InputField(title: "Coapplicant Income", placeholder: "e.g., 2000", value: $coapplicantIncome)
                        InputField(title: "Loan Amount", placeholder: "e.g., 200000", value: $loanAmount) // Added input field
                        InputField(title: "Loan Amount Term", placeholder: "e.g., 360", value: $loanAmountTerm)
                        InputField(title: "Credit History (1/0)", placeholder: "e.g., 1", value: $creditHistory)
                        InputField(title: "Property Area (Urban/Semiurban/Rural)", placeholder: "e.g., Urban", value: $propertyArea)
                    }
                    
                    // Predict Button
                    Button(action: predictLoanApproval) {
                        Text("Predict Loan Approval")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    // Prediction Result
                    Text(loanApprovalResult)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Loan Approval Predictor")
            }
        }
    }
    
    // Function to predict loan approval
    func predictLoanApproval() {
        // Validate and convert inputs
        guard let applicantIncomeValue = Int64(applicantIncome),
              let coapplicantIncomeValue = Int64(coapplicantIncome),
              let loanAmountValue = Int64(loanAmount), // Validate loan amount
              let loanAmountTermValue = Int64(loanAmountTerm),
              let creditHistoryValue = Int64(creditHistory) else {
            loanApprovalResult = "Please enter valid numeric values."
            return
        }
        
        do {
            // Initialize the ML model
            let model = try newmlmodel(configuration: .init())
            
            // Create the input for the model
            let input = newmlmodelInput(
                Gender: gender,
                Married: married,
                Dependents: Int64(dependents) ?? 0,
                Education: education,
                Self_Employed: selfEmployed,
                ApplicantIncome: applicantIncomeValue,
                CoapplicantIncome: coapplicantIncomeValue,
                LoanAmount: loanAmountValue, // Updated value
                Loan_Amount_Term: loanAmountTermValue,
                Credit_History: creditHistoryValue,
                Property_Area: propertyArea
            )
            
            // Get the prediction
            let prediction = try model.prediction(input: input)
            
            // Update result based on prediction
            let approvalResult = prediction.Loan_Status  // Assume this is a String like "Y" or "N"

            if approvalResult == "Y" {
                loanApprovalResult = "Loan Approved ✅"
            } else if approvalResult == "N" {
                loanApprovalResult = "Loan Denied ❌"
            } else {
                loanApprovalResult = "Unexpected result: \(approvalResult)"
            }

        } catch {
            loanApprovalResult = "Error in prediction: \(error.localizedDescription)"
        }
    }
}

struct InputField: View {
    var title: String
    var placeholder: String
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            TextField(placeholder, text: $value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

#Preview {
    ContentView()
}


#Preview {
    ContentView()
}
*/
// Function to predict loan approval
func predictLoanApproval() {
    // Map inputs to processed values
    let genderValue = (gender.lowercased() == "male") ? 1 : 0
    let marriedValue = (married.lowercased() == "yes") ? 1 : 0
    let educationValue = (education.lowercased() == "graduate") ? 1 : 0
    let selfEmployedValue = (selfEmployed.lowercased() == "yes") ? 1 : 0
    let propertyAreaValue: Int
    switch propertyArea.lowercased() {
    case "urban": propertyAreaValue = 2
    case "semiurban": propertyAreaValue = 1
    case "rural": propertyAreaValue = 0
    default:
        loanApprovalResult = "Invalid Property Area. Use Urban, Semiurban, or Rural."
        return
    }
    
    // Validate and convert numeric inputs
    guard let applicantIncomeValue = Int64(applicantIncome),
          let coapplicantIncomeValue = Int64(coapplicantIncome),
          let loanAmountValue = Int64(loanAmount),
          let loanAmountTermValue = Int64(loanAmountTerm),
          let creditHistoryValue = Int64(creditHistory) else {
        loanApprovalResult = "Please enter valid numeric values."
        return
    }
    
    do {
        // Initialize the ML model
        let model = try newmlmodel(configuration: .init())
        
        // Create the input for the model
        let input = newmlmodelInput(
            Gender: Double(genderValue),
            Married: Double(marriedValue),
            Dependents: Double(Int64(dependents) ?? 0),
            Education: Double(educationValue),
            Self_Employed: Double(selfEmployedValue),
            ApplicantIncome: applicantIncomeValue,
            CoapplicantIncome: coapplicantIncomeValue,
            LoanAmount: loanAmountValue,
            Loan_Amount_Term: loanAmountTermValue,
            Credit_History: creditHistoryValue,
            Property_Area: Double(propertyAreaValue)
        )
        
        // Get the prediction
        let prediction = try model.prediction(input: input)
        
        // Update result based on prediction
        if prediction.Loan_Status == "1" {
            loanApprovalResult = "Loan Approved ✅"
        } else {
            loanApprovalResult = "Loan Denied ❌"
        }

    } catch {
        loanApprovalResult = "Error in prediction: \(error.localizedDescription)"
    }
}

*/
import SwiftUI
import CoreML

struct ContentView: View {
    // Input fields for all model parameters
    @State private var gender: String = ""
    @State private var married: String = ""
    @State private var dependents: String = ""
    @State private var education: String = ""
    @State private var selfEmployed: String = ""
    @State private var applicantIncome: String = ""
    @State private var coapplicantIncome: String = ""
    @State private var loanAmount: String = "" // New field for loan amount
    @State private var loanAmountTerm: String = ""
    @State private var creditHistory: String = ""
    @State private var propertyArea: String = ""
    
    // Output field
    @State private var loanApprovalResult: String = "Enter details to predict approval."
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Input Fields
                    Group {
                        InputField(title: "Gender (Male/Female)", placeholder: "e.g., Male", value: $gender)
                        InputField(title: "Married (Yes/No)", placeholder: "e.g., Yes", value: $married)
                        InputField(title: "Dependents", placeholder: "e.g., 0, 1, 2", value: $dependents)
                        InputField(title: "Education (Graduate/Not Graduate)", placeholder: "e.g., Graduate", value: $education)
                        InputField(title: "Self Employed (Yes/No)", placeholder: "e.g., No", value: $selfEmployed)
                        InputField(title: "Applicant Income", placeholder: "e.g., 5000", value: $applicantIncome)
                        InputField(title: "Coapplicant Income", placeholder: "e.g., 2000", value: $coapplicantIncome)
                        InputField(title: "Loan Amount", placeholder: "e.g., 200000", value: $loanAmount)
                        InputField(title: "Loan Amount Term", placeholder: "e.g., 360", value: $loanAmountTerm)
                        InputField(title: "Credit History (1/0)", placeholder: "e.g., 1", value: $creditHistory)
                        InputField(title: "Property Area (Urban/Semiurban/Rural)", placeholder: "e.g., Urban", value: $propertyArea)
                    }
                    
                    // Predict Button
                    Button(action: predictLoanApproval) {
                        Text("Predict Loan Approval")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    // Prediction Result
                    Text(loanApprovalResult)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Loan Approval Predictor")
            }
        }
    }
    
    // Function to predict loan approval
    func predictLoanApproval() {
        // Validate and convert inputs
        guard let applicantIncomeValue = Int64(applicantIncome),
              let coapplicantIncomeValue = Int64(coapplicantIncome),
              let loanAmountValue = Int64(loanAmount),
              let loanAmountTermValue = Int64(loanAmountTerm),
              let creditHistoryValue = Int64(creditHistory) else {
            loanApprovalResult = "Please enter valid numeric values."
            return
        }
        
        // Encode categorical variables
        let genderValue = (gender.lowercased() == "male") ? 1.0 : 0.0
        let marriedValue = (married.lowercased() == "yes") ? 1.0 : 0.0
        let educationValue = (education.lowercased() == "graduate") ? 1.0 : 0.0
        let selfEmployedValue = (selfEmployed.lowercased() == "yes") ? 1.0 : 0.0
        
        let propertyAreaValue: Double
        switch propertyArea.lowercased() {
        case "urban":
            propertyAreaValue = 2.0
        case "semiurban":
            propertyAreaValue = 1.0
        case "rural":
            propertyAreaValue = 0.0
        default:
            loanApprovalResult = "Invalid Property Area. Use Urban, Semiurban, or Rural."
            return
        }
        
        do {
            // Initialize the ML model
            let model = try newmlmodel(configuration: .init())
            
            // Create the input for the model
            let input = newmlmodelInput(
                Gender: Int64(genderValue),
                Married: Int64(marriedValue),
                Dependents: Double(Int64(dependents) ?? 0),
                Education: Int64(educationValue),
                Self_Employed: Int64(selfEmployedValue),
                ApplicantIncome: applicantIncomeValue,
                CoapplicantIncome: Double(coapplicantIncomeValue),
                LoanAmount: Double(loanAmountValue),
                Loan_Amount_Term: Double(loanAmountTermValue),
                Credit_History: Double(creditHistoryValue),
                Property_Area: Int64(Double(propertyAreaValue))
            )
            
            // Get the prediction
            let prediction = try model.prediction(input: input)
            
            // Update result based on prediction
            if prediction.Loan_Status == 1 {
                loanApprovalResult = "Loan Approved ✅"
            } else if prediction.Loan_Status == 0 {
                loanApprovalResult = "Loan Denied ❌"
            } else {
                loanApprovalResult = "Unexpected result: \(prediction.Loan_Status)"
            }
        } catch {
            loanApprovalResult = "Error in prediction: \(error.localizedDescription)"
        }
    }
}

struct InputField: View {
    var title: String
    var placeholder: String
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            TextField(placeholder, text: $value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

#Preview {
    ContentView()
}
