class Decode1090 < Formula
  desc "Companion application to rs1090 to decode Mode S and ADS-B signals"
  homepage "https://github.com/xoolive/rs1090"
  version "0.4.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/rs1090/releases/download/v0.4.7/decode1090-aarch64-apple-darwin.tar.xz"
      sha256 "d595682cdea63a8c3b1f2aa4dcade558bc67bddd9196df30e3e200aeee44acb2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/rs1090/releases/download/v0.4.7/decode1090-x86_64-apple-darwin.tar.xz"
      sha256 "ac4556810153e0130db885c632dfcb91c44858444e5825db72ffaf0ea6d98add"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/rs1090/releases/download/v0.4.7/decode1090-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7a2254780b07742d0a5a460fe085e07a6e3a3e0f97608864a2338313757a125b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/rs1090/releases/download/v0.4.7/decode1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7acaadf9e6c9b7820f8ea5f2f852c3f197508d728d8e877a874fa2e6847c818d"
    end
  end
  license "MIT"
  depends_on "soapyrtlsdr"
  depends_on "soapysdr"

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
