class Jet1090 < Formula
  desc "A real-time comprehensive Mode S and ADS-B data decoder"
  homepage "https://github.com/xoolive/jet1090"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.1/jet1090-aarch64-apple-darwin.tar.xz"
      sha256 "9796130c1db06038c0de315a5461708a4ceae5e2af83c3807962859f77c385ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.1/jet1090-x86_64-apple-darwin.tar.xz"
      sha256 "036aa123149a02397118886b93a67ea4b94f57accc9ea4ea8f957c46941a936f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.1/jet1090-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e70d6c848b7d1cac8b8bacd175ea381090c93a711d9c27dbf46f94f8b33e7b64"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.5.1/jet1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "90bd03a0deaa2d0dc084a09fbe2efc44e0f5885eca61165041032467188c83b1"
    end
  end
  license "MIT"
  depends_on "libusb"

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
    bin.install "jet1090" if OS.mac? && Hardware::CPU.arm?
    bin.install "jet1090" if OS.mac? && Hardware::CPU.intel?
    bin.install "jet1090" if OS.linux? && Hardware::CPU.arm?
    bin.install "jet1090" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
