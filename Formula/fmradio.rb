class Fmradio < Formula
  desc "An FM radio demodulator and RDS decoder in pure Rust"
  homepage "https://github.com/xoolive/desperado"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.2/fmradio-aarch64-apple-darwin.tar.xz"
      sha256 "b6a717ee3cfdcdf11748c7d1f54b7c77e66ad65ef2d9967dce0ab2ee4ab07849"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.2/fmradio-x86_64-apple-darwin.tar.xz"
      sha256 "e3c7110e5b92bfc258c677c16da04876d60d537dc3c00eb204358d20b815b590"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.2/fmradio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8982173607589a1731ba04fe36ec55a2c0da36024334dde4fa0d6f022fa54f52"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.2/fmradio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "605698a1b54138e0c1af4379a4cc63da988298ffbbbdc4a89313be5cb0d9b6b8"
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
