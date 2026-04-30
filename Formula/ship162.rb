class Ship162 < Formula
  desc "A real-time AIS data decoder"
  homepage "https://github.com/xoolive/ship162"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.4/ship162-aarch64-apple-darwin.tar.xz"
      sha256 "e7c134130503a45ea7d0fc2283ca958068fc430427e51eb9d7b034633b38f63b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.4/ship162-x86_64-apple-darwin.tar.xz"
      sha256 "73efe14d60b19c3ed62541f0e9a9e69115785615e6eb18a48e0089e5e708518c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.4/ship162-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8562e0abd612ef5728dcb2d1601bcc34ece322d3ec61b917d998e59d4288f195"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.4/ship162-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "da9d09719b949a9dc629a4c3f5a6e83296c585ed384e99173036791fbad59759"
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
    bin.install "ship162" if OS.mac? && Hardware::CPU.arm?
    bin.install "ship162" if OS.mac? && Hardware::CPU.intel?
    bin.install "ship162" if OS.linux? && Hardware::CPU.arm?
    bin.install "ship162" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
