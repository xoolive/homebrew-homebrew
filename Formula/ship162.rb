class Ship162 < Formula
  desc "A real-time AIS data decoder"
  homepage "https://github.com/xoolive/ship162"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.1/ship162-aarch64-apple-darwin.tar.xz"
      sha256 "98aa286f14b8133c40143b40698e16217e014582583ffb36e3b3d57523fb4396"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.1/ship162-x86_64-apple-darwin.tar.xz"
      sha256 "b13964e18b8eab0e7cd40d2bb7fa41568de0a4d73e8bc6a95c7329e6968a3c0c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.1/ship162-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "86ea78058dfe9417e4af0c250451159f2bbbd6566dbcc783a327079ec8389d3c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.1/ship162-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c6453850605e3cc85cec731b2ae6caa07139aeb7c54ee7462918be2459987340"
    end
  end
  license "MIT"

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
