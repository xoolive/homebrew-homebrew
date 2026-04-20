class Dabradio < Formula
  desc "A DAB/DAB+ digital radio decoder"
  homepage "https://github.com/xoolive/desperado"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.1/dabradio-aarch64-apple-darwin.tar.xz"
      sha256 "388cf66535b023cb58266d6fa8d4d4dfebfae908f4a0cf1e1dad13b3c6625eb1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.1/dabradio-x86_64-apple-darwin.tar.xz"
      sha256 "f4a83e7dbc64204bbd2f0ae8c016c8cb806a86d1c85ba2274a16df275ed71cf9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.1/dabradio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "aec0c0d69ef193d225c0676fff19db1a5633de96072fc1886de536c2d46210a6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.1/dabradio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "87e1cb28d82b3acaf704b50096ca2ba65cbc56a1b878a00190bb919d93bc6505"
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
