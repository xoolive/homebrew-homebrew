class Jet1090 < Formula
  desc "Real-time Mode S and ADS-B data with REST and ZMQ endpoints"
  version "0.2.2"
  on_macos do
    on_arm do
      url "https://github.com/xoolive/rs1090/releases/download/jet1090-v0.2.2/jet1090-aarch64-apple-darwin.tar.xz"
      sha256 "779c34e8059294b633ce6e0baea87a09a3a84eebfe2c1f528e75c1e1b6363dd9"
    end
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/jet1090-v0.2.2/jet1090-x86_64-apple-darwin.tar.xz"
      sha256 "9e9125d7f68fde57509bd20a271728e7d19b8789460bdc7f63f2725132e64dd2"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/jet1090-v0.2.2/jet1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "73002ac29c10b37400d0a750347c877ef7f6b3444c9c132f4882bb1bdded8d42"
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
