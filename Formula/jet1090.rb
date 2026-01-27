class Jet1090 < Formula
  desc "A real-time comprehensive Mode S and ADS-B data decoder"
  homepage "https://github.com/xoolive/jet1090"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.0/jet1090-aarch64-apple-darwin.tar.xz"
      sha256 "fc538a3cf10adbc869b03589044861f1f9270836ea36825d23fad9de1bd88bce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.0/jet1090-x86_64-apple-darwin.tar.xz"
      sha256 "6346392144d653ee82775af3b5f064196ab91165549badbfadf8fb4956cc5697"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.0/jet1090-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "067015fe722baf2ad1e99d0cf495f7c152a4217e8fb075e51a9b39b88ee731f7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.0/jet1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "24ee11faee3fbe11021cb78c968fd1bd764dcf778fcd61811bec6c6b9058f3c1"
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
    bin.install "jet1090" if OS.mac? && Hardware::CPU.arm?
    bin.install "jet1090" if OS.mac? && Hardware::CPU.intel?
    bin.install "jet1090" if OS.linux? && Hardware::CPU.arm?
    bin.install "jet1090" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
