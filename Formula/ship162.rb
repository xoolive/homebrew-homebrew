class Ship162 < Formula
  desc "A real-time AIS data decoder"
  homepage "https://github.com/xoolive/ship162"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/ship162/releases/download/v0.2.1/ship162-aarch64-apple-darwin.tar.xz"
      sha256 "6d612fa15dfa331b3381c06fc0b564e6e2098d11c7bae65a3912be5153493151"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/ship162/releases/download/v0.2.1/ship162-x86_64-apple-darwin.tar.xz"
      sha256 "d49d965661b6e302f85e6c260d95bacd9a80aad696094a3db991894a7fd6abc2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/ship162/releases/download/v0.2.1/ship162-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f315db89f1bf1bfbab4fe4b6588bf948c0d0f04a459dc2a9c0b68e72fb64c5b8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/ship162/releases/download/v0.2.1/ship162-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3ede10cc4edf8c281571a07130c34cc73050deabcc54b503e27dcb853b1ebde7"
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
