class Dabradio < Formula
  desc "A DAB/DAB+ digital radio decoder"
  homepage "https://github.com/xoolive/desperado"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.1/dabradio-aarch64-apple-darwin.tar.xz"
      sha256 "94fda61f3d9d39d6444953e8af93738ed7a53bba2252f37bfc0fcfcc97ad52db"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.1/dabradio-x86_64-apple-darwin.tar.xz"
      sha256 "f02b40e5eedfe1f2018f6810fc290eb3a5c7c18b14be007bee0e97141ef6709d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.1/dabradio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4f57c2dfc69ae0aabad00b1acaeb362a8eb44d3e9406f9b0241b44777bc165c1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/desperado/releases/download/v0.5.1/dabradio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bfa81e97fcf7b9afd266f3f58b242d6d4a5cdc14edb193ae4eace3005af76b70"
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
      bin.install "dabradio"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dabradio"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dabradio"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dabradio"
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
