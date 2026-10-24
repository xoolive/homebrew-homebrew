class Ship162 < Formula
  desc "A real-time AIS data decoder"
  homepage "https://github.com/xoolive/ship162"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/ship162/releases/download/v0.2.0/ship162-aarch64-apple-darwin.tar.xz"
      sha256 "4f7b3c55981034341c042fd3905278ed203f140a38914eb36c78ed6c8ce42ed4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/ship162/releases/download/v0.2.0/ship162-x86_64-apple-darwin.tar.xz"
      sha256 "dcc452c2a76ca0be4eaff2373c28cb9def48fd84bc7c0383e707ce94411e14f1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/ship162/releases/download/v0.2.0/ship162-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cf88acc2418c04721007ad35abfa510cbcfb0cccab082c3f1dc289e9bc6d177f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/ship162/releases/download/v0.2.0/ship162-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "75e36d01de124c1d2ad0c9bcdd0a6d8095255716558cea315a91d36ce7d2cfeb"
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
      bin.install "ship162"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ship162"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ship162"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ship162"
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
