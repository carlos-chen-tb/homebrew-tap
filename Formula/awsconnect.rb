class CargoLambda < Formula
  desc "TOTP tool for AWS MFA authentication"
  homepage "https://github.com/carlos-chen-tb/awsconnect"
  head "https://github.com/carlos-chen-tb/awsconnect.git", branch: "main"
  version "0.0.3"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/carlos-chen-tb/awsconnect/releases/download/v0.0.3/awsconnect-linux-aarch64"
      sha256 "ce1b76fa4cc9466c46b764a049233fd4d175dbe58d797efeb9687484249e4ef9"
    else
      url "https://github.com/carlos-chen-tb/awsconnect/releases/download/v0.0.3/awsconnect-macos-x86_64"
      sha256 "56e8a3c2d8b13a3dec82624eb222b04c56ac5b2e7c131be9b0781ba9c0a5abd2"
    end
  else
    if Hardware::CPU.arm?
      url "https://github.com/carlos-chen-tb/awsconnect/releases/download/v0.0.3/awsconnect-linux-aarch64"
      sha256 "b08c6102e1dd0b78e7a38cb55edeab8f9f0b201d000a06a1a492566c4562843c"
    else
      url "https://github.com/carlos-chen-tb/awsconnect/releases/download/v0.0.3/awsconnect-linux-x86_64"
      sha256 "2a9996f9aeada83e0d4eaff59fde90d9bbc8d9d5e09b78fe206a04bfe493eda9"
    end
  end

  def install
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "awsconnect-macos-aarch64" : "awsconnect-macos-x86_64"
    else
      Hardware::CPU.arm? ? "awsconnect-linux-aarch64" : "awsconnect-linux-x86_64"
    end

    bin.install binary_name => "awsconnect"
  end

  test do
    assert_match "A TOTP tool for AWS MFA authentication", shell_output("#{bin}/awsconnect --help")
  end
end
