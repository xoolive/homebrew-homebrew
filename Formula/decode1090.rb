class Decode1090 < Formula
  desc "Companion application to rs1090 to decode Mode S and ADS-B signals"
  version "0.1.3"
  on_macos do
    on_arm do
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.1.3/decode1090-aarch64-apple-darwin.tar.xz"
      sha256 "858dd74c5fcb8238e89c1d50974b3b225cb78d15180c96ba9d43e6090f65de5d"
    end
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.1.3/decode1090-x86_64-apple-darwin.tar.xz"
      sha256 "3c3f29449f558a9b01bad99a7599d4f64628958c131b2d5ca9d3fa5be889ebf6"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.1.3/decode1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9e944598a2bc391955687dbe5fb717ddf394adb2794f7a84433f220f9942ed7b"
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
