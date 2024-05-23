class Jet1090 < Formula
  desc "Real-time Mode S and ADS-B data with REST and ZMQ endpoints"
  version "0.2.1"
  on_macos do
    on_arm do
      url "https://github.com/xoolive/rs1090/releases/download/jet1090-v0.2.1/jet1090-aarch64-apple-darwin.tar.xz"
      sha256 "4b8c2aba76ae77fd1764897cb148fd59adf39b01fdf44e17243117f720bdc581"
    end
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/jet1090-v0.2.1/jet1090-x86_64-apple-darwin.tar.xz"
      sha256 "badcdec177a804606569377cc47faae6d01c0a3b60c934b4492997c68c1499d7"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/jet1090-v0.2.1/jet1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f7787ed25b5a4e890fd661f9fafdebc9f8d96e6f72a1ab55b2b42bdad1b8e4a9"
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
