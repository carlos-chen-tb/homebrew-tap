class LinkingfitNotify < Formula
  desc "LinkingFit badminton court availability notifier with Slack/Discord/Telegram notifications"
  homepage "https://github.com/carlos-chen-tb/linkingfit_notify"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/carlos-chen-tb/linkingfit_notify/releases/download/v0.1.1/linkingfit_notify-aarch64-apple-darwin.tar.gz"
      sha256 "bde5d6c60806f988969da57f8b87b8cb3d9560ada530a82883bf445d9c5e4860"
    end
    if Hardware::CPU.intel?
      url "https://github.com/carlos-chen-tb/linkingfit_notify/releases/download/v0.1.1/linkingfit_notify-x86_64-apple-darwin.tar.gz"
      sha256 "5e64d400eacab07ce6e71b7e5bff5033bf8b00353bc43ede85834c8de256a298"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/carlos-chen-tb/linkingfit_notify/releases/download/v0.1.1/linkingfit_notify-aarch64-unknown-linux-musl.tar.gz"
      sha256 "667710cecb63342e832be2d640b03c83bcc827ad0f086ff00095854f478c5af8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/carlos-chen-tb/linkingfit_notify/releases/download/v0.1.1/linkingfit_notify-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2073c3b0bfb505feef8b96b2fde9bd7b2b137f0f6f164b46f28eab16f597fc80"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "linkingfit_notify" if OS.mac? && Hardware::CPU.arm?
    bin.install "linkingfit_notify" if OS.mac? && Hardware::CPU.intel?
    bin.install "linkingfit_notify" if OS.linux? && Hardware::CPU.arm?
    bin.install "linkingfit_notify" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
