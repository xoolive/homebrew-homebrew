class Decode1090 < Formula
  desc "Companion application to rs1090 to decode Mode S and ADS-B signals"
  homepage "https://github.com/xoolive/rs1090"
  version "0.3.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/rs1090/releases/download/v0.3.6/decode1090-aarch64-apple-darwin.tar.xz"
      sha256 "efb2b5808a0b58b971cdb1f34246e4707ddbd63212e8bf00de37e392dc0d3cb1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/rs1090/releases/download/v0.3.6/decode1090-x86_64-apple-darwin.tar.xz"
      sha256 "8a61264da9924e933d9342444e6e0261cf6b6f983ab13f9a54ab931012447261"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/rs1090/releases/download/v0.3.6/decode1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f8d7b395cc6294f0a0a86b11f63fb2e8817944048bb172b8d72ed949b9eb6398"
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
