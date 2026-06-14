class Datalink < Formula
  desc "Decode aviation datalink traffic from payloads, SDR, files, and Airframes.io"
  homepage "https://github.com/xoolive/datalink"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/datalink/releases/download/datalink-v0.2.0/datalink-aarch64-apple-darwin.tar.xz"
      sha256 "0e033afcd11c80f1abfbc760a23fd43eac31a96d3ec5820a200d41b4794cff57"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/datalink/releases/download/datalink-v0.2.0/datalink-x86_64-apple-darwin.tar.xz"
      sha256 "eb62b5df87d10d21bf1dece2c80a1a5cb618ce24ec3b53950797fcd75efea20a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/datalink/releases/download/datalink-v0.2.0/datalink-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9b8164e72800de4611fa0e41ef02cc207d23adf82456cd3b57f3f1c7c609cc3e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/datalink/releases/download/datalink-v0.2.0/datalink-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "815f6f58748c5a2f0d6dc18b982bd4577de258104a1ebd537019329480bced37"
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
