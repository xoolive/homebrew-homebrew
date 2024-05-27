class Decode1090 < Formula
  desc "Companion application to rs1090 to decode Mode S and ADS-B signals"
  version "0.2.2"
  on_macos do
    on_arm do
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.2.2/decode1090-aarch64-apple-darwin.tar.xz"
      sha256 "d2ff7a985a1364dddcec7827bee41b0edeeffe2a64b55c7b333045b3bda52bda"
    end
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.2.2/decode1090-x86_64-apple-darwin.tar.xz"
      sha256 "bb103803ab02ad37759538ef491a28152d7e0cd5fd593454e073c2329d5bb08b"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.2.2/decode1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "935f0172345cc59133dbb9f48d9b794fd5022d9d6887e0bae5f9305d57180c98"
    end
  end
  license "MIT"
  
  depends_on "soapyrtlsdr"
  depends_on "soapysdr"
  depends_on "soapysdr"
  depends_on "soapysdr"

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
