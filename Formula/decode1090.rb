class Decode1090 < Formula
  desc "Companion application to rs1090 to decode Mode S and ADS-B signals"
  homepage "https://github.com/xoolive/jet1090"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.6.0/decode1090-aarch64-apple-darwin.tar.xz"
      sha256 "caea85caa150a7ef097e0cfce901881ea05fedff2aa9bb15b61c69b90d9b6ab7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.6.0/decode1090-x86_64-apple-darwin.tar.xz"
      sha256 "13fbaba1e1006b769d9aefd803393213925b6d9c99d4aa146e1469409ee93246"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.6.0/decode1090-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "07ac29aa93dbfdf33c5c1954f068c9d9544274c75d421d367cdcb7e3590384fb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.6.0/decode1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "077a62c901735fae7a703cdae57e2c2306d941d7e7687420b7ec8e56ac740cb5"
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
    bin.install "decode1090" if OS.mac? && Hardware::CPU.arm?
    bin.install "decode1090" if OS.mac? && Hardware::CPU.intel?
    bin.install "decode1090" if OS.linux? && Hardware::CPU.arm?
    bin.install "decode1090" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
