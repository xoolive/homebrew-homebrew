class Ship162 < Formula
  desc "A real-time AIS data decoder"
  homepage "https://github.com/xoolive/ship162"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.3/ship162-aarch64-apple-darwin.tar.xz"
      sha256 "ae2434be7708a0f3f965881e8c4ac335436f0302198e8ce07b9db87c454adaca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.3/ship162-x86_64-apple-darwin.tar.xz"
      sha256 "6cab7f706854a9906d7cabc683b83e572216c5ff409ae6e2aa518bde36f10902"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.3/ship162-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "03a24a3ac71bb31ef317a02ba0c5acfe3f6b2e4333293bc8f6b3e1982bab4d0e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.3/ship162-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2e08b587daa40aed36ba742446fab41b3fe8c1230c17c6eeba36ef43aaf5d805"
    end
  end
  license "MIT"
  depends_on "libusb"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
