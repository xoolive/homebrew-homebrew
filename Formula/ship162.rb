class Ship162 < Formula
  desc "A real-time AIS data decoder"
  homepage "https://github.com/xoolive/ship162"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/ship162/releases/download/v0.3.0/ship162-aarch64-apple-darwin.tar.xz"
      sha256 "a1f0d8049a4776a6f9c848266109a2c448f36a72b98be4eac4a530d65af742d2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/ship162/releases/download/v0.3.0/ship162-x86_64-apple-darwin.tar.xz"
      sha256 "9058f925b4ce5db50e1af9b313f495feb027955f36c9656c3c9c8021cb913320"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/ship162/releases/download/v0.3.0/ship162-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "48d62c7912d4116af9606d01150d875e5b5b6d9d710dfe42a9947e011b3b7bcb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/ship162/releases/download/v0.3.0/ship162-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2aabe982a58d387b25c8a49edbeaee6a53d79a9178967c84618c98127dde7a8f"
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
