class Dabradio < Formula
  desc "A DAB/DAB+ digital radio decoder"
  homepage "https://github.com/xoolive/desperado"
  version "0.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.2/dabradio-aarch64-apple-darwin.tar.xz"
      sha256 "9a122f72d7dcf4df1c0c33a8a020fa62fe9184cf814d1d96377d6ae37afbd0f4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.2/dabradio-x86_64-apple-darwin.tar.xz"
      sha256 "a6d6ac7cf7d482984ce0607d8cec73a32e47ebf691e2ab47e24bf837e4ab96cc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.2/dabradio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "767e9d41adb218b7b807945b3a769b2322447aec4f1ee6d41c8fbf5ea669ac43"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.2/dabradio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ca224a2c762934a26555ad354ea83c8ec2163c45cb2adb65663da8f8d4a6f66c"
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
    bin.install "dabradio" if OS.mac? && Hardware::CPU.arm?
    bin.install "dabradio" if OS.mac? && Hardware::CPU.intel?
    bin.install "dabradio" if OS.linux? && Hardware::CPU.arm?
    bin.install "dabradio" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
