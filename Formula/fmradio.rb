class Fmradio < Formula
  desc "An FM radio demodulator and RDS decoder in pure Rust"
  homepage "https://github.com/xoolive/desperado"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.1/fmradio-aarch64-apple-darwin.tar.xz"
      sha256 "b94009db7c45dab2e27587994329e15bacdc4e159cd1c75a3fd4964f046bd6ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.1/fmradio-x86_64-apple-darwin.tar.xz"
      sha256 "63c4c6a75f946aed9f3325c4b48dbcaa0af686239db20d3b397871003331a2cd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.1/fmradio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8042b6f03c235da099702829d88f4151a90fc81b3c314c8e7d2ba735ed9ebb3d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.1/fmradio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "285034c8c03d0095fb9343937348b90151ca00c012375808926c9884fc485b9a"
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
    bin.install "fmradio" if OS.mac? && Hardware::CPU.arm?
    bin.install "fmradio" if OS.mac? && Hardware::CPU.intel?
    bin.install "fmradio" if OS.linux? && Hardware::CPU.arm?
    bin.install "fmradio" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
