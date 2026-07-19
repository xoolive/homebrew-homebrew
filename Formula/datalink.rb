class Datalink < Formula
  desc "Decode aviation datalink traffic from payloads, SDR, files, and Airframes.io"
  homepage "https://github.com/xoolive/datalink"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/datalink/releases/download/datalink-v0.3.0/datalink-aarch64-apple-darwin.tar.xz"
      sha256 "606775f2e6d6456ecae1fa343f85b91ef3eaabe5bd71770d891b0a97e7dfbabf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/datalink/releases/download/datalink-v0.3.0/datalink-x86_64-apple-darwin.tar.xz"
      sha256 "3b4d699153991399645cc0dfa0d23f1ce98389bee3d308074a2898f94d8b568f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/datalink/releases/download/datalink-v0.3.0/datalink-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "28f70479331396606796be5ffa439e916ddff7a45bbad92660ff445f47f75c19"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/datalink/releases/download/datalink-v0.3.0/datalink-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "745796cc1bf32f539e4baea266a78666d761a786b75d763af51ec3d4cbf00be5"
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
    bin.install "datalink" if OS.mac? && Hardware::CPU.arm?
    bin.install "datalink" if OS.mac? && Hardware::CPU.intel?
    bin.install "datalink" if OS.linux? && Hardware::CPU.arm?
    bin.install "datalink" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
