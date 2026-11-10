class Decode1090 < Formula
  desc "Companion application to rs1090 to decode Mode S and ADS-B signals"
  homepage "https://github.com/xoolive/jet1090"
  version "0.8.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.8.1/decode1090-aarch64-apple-darwin.tar.xz"
      sha256 "12ff6acfb25caabcb4f9060559fa64a6077266883814a98727e1336b81bc7684"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.8.1/decode1090-x86_64-apple-darwin.tar.xz"
      sha256 "fa0b0b9bf1db2e0e34ce95f17a4009a8bd97b7cce3c1fcdfb61f2bd7be92113f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.8.1/decode1090-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "40e634de12a1b22ff0472be4548728a397d65bcfb2b64b3d8ea12d96516369d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.8.1/decode1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "94fc7411b6898b0c0940fb71713eb7ab9a67109f134450b25f0b58cc5047333c"
    end
  end
  license "MIT"

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "decode1090"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "decode1090"
    end
    if OS.linux? && Hardware::CPU.arm?
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
