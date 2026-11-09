class Voracious < Formula
  desc "VOR signal decoder for aviation navigation"
  homepage "https://github.com/xoolive/desperado"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.2/voracious-aarch64-apple-darwin.tar.xz"
      sha256 "532e1f6bb13b717cb67ee6fa8a48fcc2ddee1724f722152c6f6019560280d09f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.2/voracious-x86_64-apple-darwin.tar.xz"
      sha256 "2ffb6d68ea4307096042830f0303e6c197756aba17de1a5b26ed2f87a3911543"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.2/voracious-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8d92926b8ec880bb4b1451880e9c82ae39b94abb40ac1ec3b86189403f8751c4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.2/voracious-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1ae64881d0748f2c929e4dba1313ea987322a314e35bfc88b920cd4102d4fed3"
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
