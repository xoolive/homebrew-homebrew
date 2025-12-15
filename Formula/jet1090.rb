class Jet1090 < Formula
  desc "A real-time comprehensive Mode S and ADS-B data decoder"
  homepage "https://github.com/xoolive/jet1090"
  version "0.4.15"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.4.15/jet1090-aarch64-apple-darwin.tar.xz"
      sha256 "8878e78ecf1ff8ba0a615821fb0756c95c5099d0fa6f4ca4578413ae8bee3a37"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.4.15/jet1090-x86_64-apple-darwin.tar.xz"
      sha256 "91eb4d58ea0df6bf5ec2daa51d46ba72b1aac00dffef8232157e2292352763e1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.4.15/jet1090-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8b81b84cd452f130ccde3c5329ffedee7a4fbccbd4f49c14615f53c01d7918b4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.4.15/jet1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "219ee028b9a63e4d62cd522f5bf6208e56aea37c1d4ec19e7d23458dd62b4159"
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
