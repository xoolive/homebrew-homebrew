class Voracious < Formula
  desc "VOR signal decoder for aviation navigation"
  homepage "https://github.com/xoolive/desperado"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.1/voracious-aarch64-apple-darwin.tar.xz"
      sha256 "3b9128b85c8797a3962a970c5f1177f823f2a6e5e901411db2b6be207d551cf9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.1/voracious-x86_64-apple-darwin.tar.xz"
      sha256 "a4e762eedda951d47171a32799ccab68389a48d06f497efa3649d102955a6ac7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.1/voracious-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f0f2fdbeddbe1db440f717e65ae621902eb5d7fc2b676e1f25e9a0fec790459e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.1/voracious-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "85e135ab42ec5a9cef435aed3133ba321ac95af0e79fc3f6e1eb6eca7c228ccb"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
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
    bin.install "voracious" if OS.mac? && Hardware::CPU.arm?
    bin.install "voracious" if OS.mac? && Hardware::CPU.intel?
    bin.install "voracious" if OS.linux? && Hardware::CPU.arm?
    bin.install "voracious" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
