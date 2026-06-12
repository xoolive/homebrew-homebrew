class Voracious < Formula
  desc "VOR signal decoder for aviation navigation"
  homepage "https://github.com/xoolive/desperado"
  version "0.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.2/voracious-aarch64-apple-darwin.tar.xz"
      sha256 "5cd073957207161faa0138ecb26744889b9244fcce38b82b2157ab3d050c7ebe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.2/voracious-x86_64-apple-darwin.tar.xz"
      sha256 "5e151c2766dd0e846e28a288c220b60971f1c331fefa48fcb8d4614db29a6f52"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.2/voracious-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "10c1618a549bc585d2f9ed2f1a9deade4d98a16450455f6f30484cc5f9deea6b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.2/voracious-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "768367069f2161df0acd874c2b620eb44fc3fee1cbf4c9110f3fab79f5dc874f"
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
