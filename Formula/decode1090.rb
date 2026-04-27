class Decode1090 < Formula
  desc "Companion application to rs1090 to decode Mode S and ADS-B signals"
  homepage "https://github.com/xoolive/jet1090"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.2/decode1090-aarch64-apple-darwin.tar.xz"
      sha256 "f4b32a29de62e63190afb6d015cd5e0d80def4f6cbb45e9c4d4340187f5372af"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.2/decode1090-x86_64-apple-darwin.tar.xz"
      sha256 "b2b4921b836d16d43ec75de001f1a4463b7bfb4d3f5a20c98fb68ffd709edd7e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.2/decode1090-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "751d69d084559269706aac07432a8d1a364b53d0cb2658fe5cea665789eebc5d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.2/decode1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "437b37d1cff7fa179811544b3bafe4c66b5c6aeb1ba4515bd9e1558383ae6f68"
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
