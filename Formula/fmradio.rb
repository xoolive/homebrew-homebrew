class Fmradio < Formula
  desc "An FM radio demodulator and RDS decoder in pure Rust"
  homepage "https://github.com/xoolive/desperado"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.1/fmradio-aarch64-apple-darwin.tar.xz"
      sha256 "abc6e3b44d701fed794f355d1a52ddf564ae97c22a7f4de02e918e0dc5f853a0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.1/fmradio-x86_64-apple-darwin.tar.xz"
      sha256 "a0149bc512efa10100825c431e74def1d8a529b7fd124b906a8c3ab979cb5942"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.1/fmradio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "889163adad15040d78d5cf4a433d7a99c6822b46560b2111780a459eda33d2f5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.1/fmradio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "70ac5e0d65e7c370dc41916c5435b2d73e5b86ebbb5b5e463e21f69ae483caa6"
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
      bin.install "fmradio"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "fmradio"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "fmradio"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "fmradio"
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
