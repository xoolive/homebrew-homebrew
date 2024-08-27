class Jet1090 < Formula
  desc "Real-time Mode S and ADS-B data with REST and ZMQ endpoints"
  homepage "https://github.com/xoolive/rs1090"
  version "0.3.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/rs1090/releases/download/v0.3.4/jet1090-aarch64-apple-darwin.tar.xz"
      sha256 "9651a4485e3a335e41dc0356043da1f29fa20549dd5616ceec9d8d247e070d50"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/rs1090/releases/download/v0.3.4/jet1090-x86_64-apple-darwin.tar.xz"
      sha256 "1b24f3eef7984b2ca1ef101353cd0a043e2958bee28160789ed51ae1e5b2bef6"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/rs1090/releases/download/v0.3.4/jet1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5823e37ca63fa9c3a7befbfed532558291a7d0d9403c210e7e4ca25d0148ddf5"
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
      bin.install "jet1090"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "jet1090"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "jet1090"
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
