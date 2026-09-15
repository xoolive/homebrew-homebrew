class Dabradio < Formula
  desc "A DAB/DAB+ digital radio decoder"
  homepage "https://github.com/xoolive/desperado"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.0/dabradio-aarch64-apple-darwin.tar.xz"
      sha256 "25a8149bda1e00fc7510da4e65c2776498f22e272e9e6990fff36cda467c2732"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.0/dabradio-x86_64-apple-darwin.tar.xz"
      sha256 "9aedd52433924d3ce0e83604df0e098ee75837e990dc3b817a90bf0ae3cf132d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.0/dabradio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1aad1ea02670fcdc9a4249f08cb7a6c261397e84c2885ea7faad05fb6341984d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.0/dabradio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fbad5149025fc24afbdede242ed75701388596e9c4cfa24afe0fe9f2d5ff61ca"
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
      bin.install "dabradio"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dabradio"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dabradio"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dabradio"
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
