class Decode1090 < Formula
  desc "Companion application to rs1090 to decode Mode S and ADS-B signals"
  version "0.2.5"
  on_macos do
    on_arm do
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.2.5/decode1090-aarch64-apple-darwin.tar.xz"
      sha256 "4d814ba7a37fe4c310a100e64d661b9f89852911ac669d9f6b8dd8564b0c9324"
    end
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.2.5/decode1090-x86_64-apple-darwin.tar.xz"
      sha256 "64002c898291bb0c26d13a1240e3a2373702fedce27fab651952216da93c52aa"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.2.5/decode1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "84ad292eef040b7f8f64b59873d3447e5aa4754e7a6762ae806c99de4f934461"
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
