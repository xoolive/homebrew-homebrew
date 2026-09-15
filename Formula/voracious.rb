class Voracious < Formula
  desc "VOR signal decoder for aviation navigation"
  homepage "https://github.com/xoolive/desperado"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.0/voracious-aarch64-apple-darwin.tar.xz"
      sha256 "dbaefe0709448c02345e304a27cef03479e68b22fa578c16dc0702685c651eb0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.0/voracious-x86_64-apple-darwin.tar.xz"
      sha256 "4d76bc96b58c9f5349c9b4a740b4e0860ae8b39fbdab61bd77b1404f99127461"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.0/voracious-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f094b0104342d1b442f09a7c6492730deca9fc76669ca3272fe37897edcfcc0f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.0/voracious-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "51d1879d8900d9bfa9efe89a84a676f4f4b5ec42fb5788e24c817b62c7df6de6"
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
      bin.install "voracious"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "voracious"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "voracious"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "voracious"
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
