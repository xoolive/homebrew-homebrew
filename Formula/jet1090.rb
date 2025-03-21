class Jet1090 < Formula
  desc "A real-time comprehensive Mode S and ADS-B data decoder"
  homepage "https://github.com/xoolive/rs1090"
  version "0.4.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/rs1090/releases/download/v0.4.8/jet1090-aarch64-apple-darwin.tar.xz"
      sha256 "af9d5076ff5e6a14f14ccbda391b15df17b28de915c52accab85551ace505d1c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/rs1090/releases/download/v0.4.8/jet1090-x86_64-apple-darwin.tar.xz"
      sha256 "a1beb70e923841d28cb9d7650c5e7cfb1625e575271325d59ac16a149e56cdb1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/rs1090/releases/download/v0.4.8/jet1090-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f7e614fb0f1b80ff38a0122834e0b683b1b6c17165c23bc9d7c27153fb92e507"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/rs1090/releases/download/v0.4.8/jet1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "45c7f0f4a3ea974e933421a6aafc24aa9c20fe172339b8ec91e6612e8b7161c0"
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
