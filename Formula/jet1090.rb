class Jet1090 < Formula
  desc "Real-time Mode S and ADS-B data with REST and ZMQ endpoints"
  version "0.2.5"
  on_macos do
    on_arm do
      url "https://github.com/xoolive/rs1090/releases/download/jet1090-v0.2.5/jet1090-aarch64-apple-darwin.tar.xz"
      sha256 "4fa406687eec258554447405811e46a5a95f24753a5457fb501ba180a1abec5e"
    end
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/jet1090-v0.2.5/jet1090-x86_64-apple-darwin.tar.xz"
      sha256 "7d57a3ed2ec0d9632f163d83f4da50adb0a5b6197dff73e7f03118fbe578ed36"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/jet1090-v0.2.5/jet1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ffe59461c0f9ef8928c3314e9fa997e47c0c4166d98426ee1bc01d64ba51a546"
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
        bin.install "jet1090"
      end
    end
    on_macos do
      on_intel do
        bin.install "jet1090"
      end
    end
    on_linux do
      on_intel do
        bin.install "jet1090"
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
