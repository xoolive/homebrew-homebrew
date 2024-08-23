class Decode1090 < Formula
  desc "Companion application to rs1090 to decode Mode S and ADS-B signals"
  homepage "https://github.com/xoolive/rs1090"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.3.0/decode1090-aarch64-apple-darwin.tar.xz"
      sha256 "b59818c1683bc9de2693dfbf9f85acd7041a63ebd030113c4ae02d137e30c58b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.3.0/decode1090-x86_64-apple-darwin.tar.xz"
      sha256 "58aec83e9ea6290ce22c954b0dc5338d5357a383e534d0e9d2954ac59d066efb"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.3.0/decode1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "58cbd98897047b3e43f1fa04bdb144f3a755fe7c4f212a39af4e4dc519726897"
    end
  end
  license "MIT"
  
  depends_on "soapyrtlsdr"
  depends_on "soapysdr"
  depends_on "soapysdr"
  depends_on "soapysdr"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}}

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
      bin.install "decode1090"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "decode1090"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "decode1090"
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
