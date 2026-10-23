class Voracious < Formula
  desc "VOR signal decoder for aviation navigation"
  homepage "https://github.com/xoolive/desperado"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.1/voracious-aarch64-apple-darwin.tar.xz"
      sha256 "9e5056204b98f3b475ee7afb74b5a006ba4d3c5a8054c33f3bf632e5b595c8d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.1/voracious-x86_64-apple-darwin.tar.xz"
      sha256 "18a1195de2f05930b5fa495d3b788754018883fd89964e7f8b0bf16fd6e4395f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.1/voracious-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c4ba59ebefcf45559b111accd01a4da8d47ec6c0cc9f0fc1d3375419d0b49f51"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.1/voracious-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f03bf7739d96a49d56d2777c2c8390ba9f7bf22c9b5b27c0712ec3c8a41474c0"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "voracious"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "voracious"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "voracious"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "voracious"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
