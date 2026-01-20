class Ship162 < Formula
  desc "A real-time AIS data decoder"
  homepage "https://github.com/xoolive/ship162"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.2/ship162-aarch64-apple-darwin.tar.xz"
      sha256 "7e7d3b1d760e42eaa5a8065d76336d14187ebf031b057eec5773ca286f5bbbac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.2/ship162-x86_64-apple-darwin.tar.xz"
      sha256 "12a26381ab0ee23b5468e200819d5146581de858aa11ea614d9abc7c325f6362"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.2/ship162-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dadeb9753af235217467e39b5445fc1be6822b7e3aade81531777d8a0d89afbd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/ship162/releases/download/v0.1.2/ship162-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "aa4ab712563aa702ae382a082faf3b6ce021c55c3fecab36c990a698e3cd55c3"
    end
  end
  license "MIT"
  depends_on "libusb"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
