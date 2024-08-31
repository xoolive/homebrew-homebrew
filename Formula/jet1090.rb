class Jet1090 < Formula
  desc "Real-time Mode S and ADS-B data with REST and ZMQ endpoints"
  homepage "https://github.com/xoolive/rs1090"
  version "0.3.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/rs1090/releases/download/v0.3.5/jet1090-aarch64-apple-darwin.tar.xz"
      sha256 "5b2872327a720a8edbb8e007b419137954d6eff9c7c6a0353d102f63b8cc1ae5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/rs1090/releases/download/v0.3.5/jet1090-x86_64-apple-darwin.tar.xz"
      sha256 "7f198b0c6c31e167ec3dd51d255208fd520c18db056714d99fc2248834815efc"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/rs1090/releases/download/v0.3.5/jet1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b2f7389c06bc13a3d2881c65b7cbd93577ad343689f458d8bfa449fa6cc79530"
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
