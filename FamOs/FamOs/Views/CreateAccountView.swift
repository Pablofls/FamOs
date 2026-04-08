import SwiftUI

struct CreateAccountView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var dateOfBirth = Date()
    @State private var email = ""
    @State private var password = ""
    @State private var agreedToTerms = false
    @State private var showDatePicker = false

    var onContinue: () -> Void = {}
    var onLogin: () -> Void = {}

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Create your\naccount")
                            .font(.system(size: 32, weight: .heavy))
                            .foregroundStyle(FamOsTheme.brandDark)
                            .tracking(-0.5)

                        Text("Step into a more structured family life.")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(FamOsTheme.neutralGrey)
                    }
                    .padding(.bottom, 40)

                    // Form Fields
                    VStack(spacing: 24) {
                        FamOsTextField(label: "First Name", placeholder: "Jane", text: $firstName)
                        FamOsTextField(label: "Last Name", placeholder: "Doe", text: $lastName)

                        // Date of Birth
                        VStack(alignment: .leading, spacing: 6) {
                            SectionLabel(text: "Date of Birth")
                                .padding(.leading, 4)
                            Button {
                                showDatePicker.toggle()
                            } label: {
                                HStack {
                                    Text(dateOfBirth.formatted(date: .numeric, time: .omitted))
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundStyle(FamOsTheme.brandDark)
                                    Spacer()
                                    Image(systemName: "calendar")
                                        .foregroundStyle(FamOsTheme.neutralGrey.opacity(0.6))
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 16)
                                .background(FamOsTheme.background)
                                .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusSmall))
                            }

                            if showDatePicker {
                                DatePicker("", selection: $dateOfBirth, displayedComponents: .date)
                                    .datePickerStyle(.graphical)
                                    .tint(FamOsTheme.primaryIndigo)
                            }
                        }

                        FamOsTextField(label: "Email Address", placeholder: "jane@example.com", text: $email)
                        FamOsTextField(label: "Password", placeholder: "••••••••", text: $password, isSecure: true)

                        // Terms
                        HStack(alignment: .top, spacing: 12) {
                            Button {
                                agreedToTerms.toggle()
                            } label: {
                                Image(systemName: agreedToTerms ? "checkmark.square.fill" : "square")
                                    .foregroundStyle(agreedToTerms ? FamOsTheme.primaryIndigo : FamOsTheme.neutralGrey.opacity(0.3))
                                    .font(.system(size: 18))
                            }
                            .padding(.top, 2)

                            VStack(alignment: .leading, spacing: 0) {
                                HStack(spacing: 0) {
                                    Text("I agree to the ")
                                        .font(.system(size: 12))
                                        .foregroundStyle(FamOsTheme.neutralGrey)
                                    Text("Terms of Service")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundStyle(FamOsTheme.primaryIndigo)
                                    Text(" and ")
                                        .font(.system(size: 12))
                                        .foregroundStyle(FamOsTheme.neutralGrey)
                                }
                                HStack(spacing: 0) {
                                    Text("Privacy Policy")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundStyle(FamOsTheme.primaryIndigo)
                                    Text(".")
                                        .font(.system(size: 12))
                                        .foregroundStyle(FamOsTheme.neutralGrey)
                                }
                            }
                        }

                        // Continue Button
                        PrimaryButton("Continue", action: onContinue)
                            .padding(.top, 8)

                        // Login Link
                        HStack(spacing: 4) {
                            Spacer()
                            Text("Already have an account?")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(FamOsTheme.neutralGrey)
                            Button(action: onLogin) {
                                Text("Log in")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundStyle(FamOsTheme.primaryIndigo)
                            }
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 48)
                .padding(.bottom, 40)
            }

            // Footer
            VStack(spacing: 16) {
                Text("\u{00A9} 2024 FAMOS SYSTEM. ALL RIGHTS RESERVED.")
                    .font(.system(size: 10, weight: .black))
                    .tracking(3)
                    .foregroundStyle(FamOsTheme.neutralGrey.opacity(0.8))

                HStack(spacing: 32) {
                    Text("HELP")
                        .font(.system(size: 10, weight: .black))
                        .tracking(2)
                        .foregroundStyle(FamOsTheme.neutralGrey)
                    Text("SUPPORT")
                        .font(.system(size: 10, weight: .black))
                        .tracking(2)
                        .foregroundStyle(FamOsTheme.neutralGrey)
                }
            }
            .padding(.vertical, 20)
        }
        .background(FamOsTheme.background)
    }
}

#Preview {
    CreateAccountView()
}
