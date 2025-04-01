class Decode1090 < Formula
  desc "Companion application to rs1090 to decode Mode S and ADS-B signals"
  homepage "https://github.com/xoolive/rs1090"
  version "0.4.13"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/rs1090/releases/download/v0.4.13/decode1090-aarch64-apple-darwin.tar.xz"
      sha256 "742acc2e2ee328431efc631655c99b12db17a39932aad98868c9735577d507ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/rs1090/releases/download/v0.4.13/decode1090-x86_64-apple-darwin.tar.xz"
      sha256 "1b0019edd576f08dbfff6dc22b89ee02ba42ebc1383f2d00867f786e14594ce0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/rs1090/releases/download/v0.4.13/decode1090-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "665a331d6256daf0e5ee695e5f6782e69c97bc05520b5334c312e6946bde1a67"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/rs1090/releases/download/v0.4.13/decode1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2215d7b94e0d0efac996ffd859014e08d3ec6abb894768523d84e24b523431a3"
    end
  end
  license "MIT"
  depends_on "soapyrtlsdr"
  depends_on "soapysdr"

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
    bin.install "decode1090" if OS.mac? && Hardware::CPU.arm?
    bin.install "decode1090" if OS.mac? && Hardware::CPU.intel?
    bin.install "decode1090" if OS.linux? && Hardware::CPU.arm?
    bin.install "decode1090" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
