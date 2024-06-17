class Jet1090 < Formula
  desc "Real-time Mode S and ADS-B data with REST and ZMQ endpoints"
  version "0.2.4"
  on_macos do
    on_arm do
      url "https://github.com/xoolive/rs1090/releases/download/jet1090-v0.2.4/jet1090-aarch64-apple-darwin.tar.xz"
      sha256 "ea48a2af62af35d0042e3d31815ddc3eba11e3c8404b99412b57edf604f4560d"
    end
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/jet1090-v0.2.4/jet1090-x86_64-apple-darwin.tar.xz"
      sha256 "dac12af12c0de4a6cd0ab3c90bdf0a4c90373b029393f918fb0f868276a43b73"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/jet1090-v0.2.4/jet1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e64d360d0d5376eab5ba0516ce5383aafd9c841116045b6ac2f7b9febceb0578"
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
