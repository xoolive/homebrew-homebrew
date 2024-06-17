class Decode1090 < Formula
  desc "Companion application to rs1090 to decode Mode S and ADS-B signals"
  version "0.2.4"
  on_macos do
    on_arm do
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.2.4/decode1090-aarch64-apple-darwin.tar.xz"
      sha256 "327c974985da3563eacedc29228f2f7c0e9d9e7cabc2a58b2d7c3735a463b1d7"
    end
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.2.4/decode1090-x86_64-apple-darwin.tar.xz"
      sha256 "3f20d81f3ec0a9561d4e282fd2942b8e27487afc55119009eb109c9983bbeae3"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.2.4/decode1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5c526fea455eda38136af416b86fd608fb38ce300bb8289cbac3a69c2ad3ba0b"
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
