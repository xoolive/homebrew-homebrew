class Jet1090 < Formula
  desc "A real-time comprehensive Mode S and ADS-B data decoder"
  homepage "https://github.com/xoolive/rs1090"
  version "0.4.13"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/rs1090/releases/download/v0.4.13/jet1090-aarch64-apple-darwin.tar.xz"
      sha256 "b2a3cd2082fa4106e14515c215509bcb3a91cc61351c759a955539911996529a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/rs1090/releases/download/v0.4.13/jet1090-x86_64-apple-darwin.tar.xz"
      sha256 "8aa46030a3588620c1820fbfddb073a9bf07a5645763540f14d148a4cb2b7c24"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/rs1090/releases/download/v0.4.13/jet1090-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5ca3456e29a730a5ecd1b12a3687c110ad4869cef95099227380101d5b42de24"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/rs1090/releases/download/v0.4.13/jet1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "34d9d31137cf5c38777938905c4393644edcabc47605a628754153752474323e"
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
