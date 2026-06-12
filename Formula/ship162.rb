class Ship162 < Formula
  desc "A real-time AIS data decoder"
  homepage "https://github.com/xoolive/ship162"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.5/ship162-aarch64-apple-darwin.tar.xz"
      sha256 "9d928f510f9685157c14cd6fd0403041c9e73ad1e17ce8b54c35fa7d54ec90f7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.5/ship162-x86_64-apple-darwin.tar.xz"
      sha256 "a4eabf44536d0015ef0c85ca5a915acac2c8f39ba85bc9ec17e8fb44aaa85a26"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.5/ship162-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "870ce7184848b441b4dcb08a056a3e2a22c40061bbf59e4ca158dc6b50d870d6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.5/ship162-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "40691937754c84e61fa76fef45c5468276baf1cae25dfb5b295dad0bbd22ab2c"
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
