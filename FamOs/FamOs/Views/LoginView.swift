import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

    var onLogin: () -> Void = {}
    var onCreateAccount: () -> Void = {}

    var body: some View {
        VStack(spacing: 0) {
            // Header bar
            HStack {
                Text("FAMOS")
                    .font(.system(size: 14, weight: .bold))
                    .tracking(4)
                    .foregroundStyle(FamOsTheme.primaryIndigo)
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)

            Spacer()

            // Login Card
            VStack(alignment: .leading, spacing: 32) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome back")
                        .font(.system(size: 30, weight: .heavy))
                        .foregroundStyle(FamOsTheme.primary)
                        .tracking(-0.5)

                    Text("Manage your household with ease.")
                        .font(.system(size: 16))
                        .foregroundStyle(FamOsTheme.neutralGrey)
                }

                // Form
                VStack(spacing: 24) {
                    // Email
                    VStack(alignment: .leading, spacing: 8) {
                        Text("EMAIL ADDRESS")
                            .font(.system(size: 12, weight: .bold))
                            .tracking(2)
                            .foregroundStyle(FamOsTheme.primary)

                        TextField("name@family.com", text: $email)
                            .textFieldStyle(.plain)
                            .font(.system(size: 16))
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .autocapitalization(.none)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 18)
                            .background(FamOsTheme.surface)
                            .overlay(
                                RoundedRectangle(cornerRadius: FamOsTheme.radiusSmall)
                                    .stroke(FamOsTheme.outlineVariant.opacity(0.15), lineWidth: 1)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusSmall))
                    }

                    // Password
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("PASSWORD")
                                .font(.system(size: 12, weight: .bold))
                                .tracking(2)
                                .foregroundStyle(FamOsTheme.primary)
                            Spacer()
                            Button {} label: {
                                Text("FORGOT?")
                                    .font(.system(size: 12, weight: .bold))
                                    .tracking(2)
                                    .foregroundStyle(FamOsTheme.primary.opacity(0.6))
                            }
                        }

                        SecureField("••••••••", text: $password)
                            .textFieldStyle(.plain)
                            .font(.system(size: 16))
                            .textContentType(.password)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 18)
                            .background(FamOsTheme.surface)
                            .overlay(
                                RoundedRectangle(cornerRadius: FamOsTheme.radiusSmall)
                                    .stroke(FamOsTheme.outlineVariant.opacity(0.15), lineWidth: 1)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusSmall))
                    }

                    // Login Button
                    Button(action: onLogin) {
                        Text("Log in")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(FamOsTheme.primary)
                            .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusSmall))
                    }
                    .buttonStyle(.plain)
                }

                // Create Account Link
                HStack(spacing: 4) {
                    Spacer()
                    Text("Don't have an account?")
                        .font(.system(size: 16))
                        .foregroundStyle(FamOsTheme.neutralGrey)
                    Button(action: onCreateAccount) {
                        Text("Create one")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(FamOsTheme.primary)
                    }
                    Spacer()
                }
            }
            .padding(32)
            .background(FamOsTheme.surface)
            .clipShape(RoundedRectangle(cornerRadius: FamOsTheme.radiusLarge))
            .padding(.horizontal, 24)

            Spacer()
            Spacer()
        }
        .background(FamOsTheme.background)
    }
}

#Preview {
    LoginView()
}
