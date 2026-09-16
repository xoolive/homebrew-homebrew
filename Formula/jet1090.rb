class Jet1090 < Formula
  desc "A real-time comprehensive Mode S and ADS-B data decoder"
  homepage "https://github.com/xoolive/jet1090"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.7.0/jet1090-aarch64-apple-darwin.tar.xz"
      sha256 "87bb760e6e4f0d6596ca98f04b26e03e56e43f9de94453e2dfd819ec02a6bb23"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.7.0/jet1090-x86_64-apple-darwin.tar.xz"
      sha256 "a70726425c50ea67d669a6a46da6f9fd6ed13f75ebae991cdd75dad9e0d81079"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xoolive/jet1090/releases/download/v0.7.0/jet1090-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "75b6652ddae3abbe2bcb5dd96c5f13c7fae14339aa17d021239c39fe4df6bf3e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xoolive/jet1090/releases/download/v0.7.0/jet1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "98d175f458807848c4f9959e408f46efacfe573b1dd8c02130519534afb53e9d"
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
