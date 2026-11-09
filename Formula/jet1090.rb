class Jet1090 < Formula
  desc "A real-time comprehensive Mode S and ADS-B data decoder"
  homepage "https://github.com/xoolive/jet1090"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.8.0/jet1090-aarch64-apple-darwin.tar.xz"
      sha256 "3af1817e3f504f8d1f218e7845900a1ec71eb8bf57aaa63155e81cba38097111"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.8.0/jet1090-x86_64-apple-darwin.tar.xz"
      sha256 "e613663cdf6d3d5349395633777e5b05ff25f962f1bfdccc4accc04a00a50b4d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.8.0/jet1090-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1e3af5cb4af4606e969968941787abfc4adff9d175d6fdbfb1f9c4f6aa1e102d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.8.0/jet1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0fca6224f138e34716dee03028f630771d8e17c9d63670c64a0e0fd5ac2d7429"
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
      bin.install "jet1090"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "jet1090"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "jet1090"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "jet1090"
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
