class Decode1090 < Formula
  desc "A companion application to rs1090 to decode Mode S and ADS-B signals"
  version "0.1.1"
  on_macos do
    on_arm do
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.1.1/decode1090-aarch64-apple-darwin.tar.xz"
      sha256 "7f2ce89a6d1e5bc1e85a1252485dcf542924765330ae445d54c965559c1cd478"
    end
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.1.1/decode1090-x86_64-apple-darwin.tar.xz"
      sha256 "bb75d23c7f5c171b9030a4882eb9262ec7782cb09f7b1e2892eb0017cc6e30e3"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.1.1/decode1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cacadc628663e5e7f032f93599f15c4486b531c48a9ad6466a71784705218aea"
    end
  end
  license "MIT"

  def install
    on_macos do
      on_arm do
        bin.install "decode1090"
      end
    end
    on_macos do
      on_intel do
        bin.install "decode1090"
      end
    end
    on_linux do
      on_intel do
        bin.install "decode1090"
      end
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
