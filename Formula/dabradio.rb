class Dabradio < Formula
  desc "A DAB/DAB+ digital radio decoder"
  homepage "https://github.com/xoolive/desperado"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.2/dabradio-aarch64-apple-darwin.tar.xz"
      sha256 "8f76f5c29220e1e54c5c03800cfe49c014e5b3b4cc6fd0bbfb162b7f583e86f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.2/dabradio-x86_64-apple-darwin.tar.xz"
      sha256 "f1c6800ddbe81585339317b7aa48bbb158dbb43a7b0853f33d54537e81b169ab"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.2/dabradio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ccf5f93593a1aeabc1a268679da3ef81af8f264a9f42966b7eb9b572218c3b51"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.2/dabradio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "364896facf1d00d88120da96022ac2727396da288539bb0e7168cf85b7ee1636"
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
      bin.install "dabradio"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dabradio"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dabradio"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dabradio"
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
