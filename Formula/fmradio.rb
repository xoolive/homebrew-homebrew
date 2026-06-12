class Fmradio < Formula
  desc "An FM radio demodulator and RDS decoder in pure Rust"
  homepage "https://github.com/xoolive/desperado"
  version "0.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.2/fmradio-aarch64-apple-darwin.tar.xz"
      sha256 "1a61527481858370c4359cba8953d5ac868d4b52067850cba55024d1d7d05202"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.2/fmradio-x86_64-apple-darwin.tar.xz"
      sha256 "9e2982fe1099517bca735031bf62ccabe50ba8787c1d3d4fff63867bd2c56048"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.2/fmradio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cc3247b48746ac4ed73642cfee49176f51d90c304c8be55c369ace75a2d32fa8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.4.2/fmradio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2b8ba2ab63779a7e450a64e1d087c8e95f4d534966f6e6d92ea02539d6e1e6a3"
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
