class Decode1090 < Formula
  desc "Companion application to rs1090 to decode Mode S and ADS-B signals"
  version "0.1.2"
  on_macos do
    on_arm do
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.1.2/decode1090-aarch64-apple-darwin.tar.xz"
      sha256 "1525a9089cb1f9e4149066295792801d760362dce819ab299c3720b4dfdecf82"
    end
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.1.2/decode1090-x86_64-apple-darwin.tar.xz"
      sha256 "22316f51892f1773f57564965bff8913e920f12672781ea3ac7639fce955da7a"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/xoolive/rs1090/releases/download/decode1090-v0.1.2/decode1090-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a858e385bcf72bcf8c8202e84744cd32ff2658420cfcba59a1fa70dbce6b43a7"
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
