class Decode1090 < Formula
  desc "Companion application to rs1090 to decode Mode S and ADS-B signals"
  homepage "https://github.com/xoolive/jet1090"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.0/decode1090-aarch64-apple-darwin.tar.xz"
      sha256 "05b182497336f75d9dbd32d6c94eb75733741b6224d05f6fd7b0b09ace73506a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.0/decode1090-x86_64-apple-darwin.tar.xz"
      sha256 "54c36896321bde32e47f2c882c3c0bda8165ebda6805756df6da4e0bf7b03447"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.0/decode1090-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d7a6425b014e7528ea0e7ab35f1ab749ceab756cf666c9531f578bf2629f864c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.0/decode1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fd583732eb182829a8ed484ce54d54cb02656cb271031b2a470d7ae03305c861"
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
