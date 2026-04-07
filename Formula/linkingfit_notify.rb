class LinkingfitNotify < Formula
  desc "LinkingFit badminton court notifier with multi-platform alerts"
  homepage "https://github.com/carlos-chen-tb/linkingfit_notify"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/carlos-chen-tb/linkingfit_notify/releases/download/v0.1.0/linkingfit_notify-aarch64-apple-darwin.tar.gz"
      sha256 "59c33c534df2998feba615f4c4c6537fa04f99add50064f8d9cd815d53acf185"
    end
    if Hardware::CPU.intel?
      url "https://github.com/carlos-chen-tb/linkingfit_notify/releases/download/v0.1.0/linkingfit_notify-x86_64-apple-darwin.tar.gz"
      sha256 "3e2a8b68f416cd7e4129ab99ebe58e4cc123143b16d0aa3617b77f7edeed00ee"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/carlos-chen-tb/linkingfit_notify/releases/download/v0.1.0/linkingfit_notify-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9131e3ea59354567a223e05b7a630cb14c216c2f62885062aaa98d5d89df84bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/carlos-chen-tb/linkingfit_notify/releases/download/v0.1.0/linkingfit_notify-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b17347625fe41b0d1225242c0b2846d6811167b37c847e4e73e1c654c1970e3a"
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
