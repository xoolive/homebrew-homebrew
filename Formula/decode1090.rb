class Decode1090 < Formula
  desc "Companion application to rs1090 to decode Mode S and ADS-B signals"
  homepage "https://github.com/xoolive/jet1090"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.1/decode1090-aarch64-apple-darwin.tar.xz"
      sha256 "e697be4a503de6db2c26d3cbad8a5faeab3297d158afda36a992f7029d9425a9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.1/decode1090-x86_64-apple-darwin.tar.xz"
      sha256 "9fc82a99be3b94fe063d30978aa111aa0cc625cb3086d80b721738c3ba477443"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.1/decode1090-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f0af78f6391ca9ec340e78459e7ff4a21d0b525601eb612613305e3b3b72e79b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.1/decode1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b87acc98e28e72fee7af823882fe00654334a838844df30a75ad31d013ec2652"
    end
  end
  license "MIT"
  depends_on "libusb"

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
