class Bale < Formula
  desc "Keeps agent worktrees from filling your disk"
  homepage "https://github.com/bmcreations/bale"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/bmcreations/bale/releases/download/v0.1.0/bale-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "4f1410c3c3bf18d0274add020fec92e757ed8f74fc88e268def5eb91aa9a2cd7"
    end
    on_intel do
      url "https://github.com/bmcreations/bale/releases/download/v0.1.0/bale-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "b0f7611fbfed3e8c03857cdb4716bb5f43eb2ec85307cc642c08d3143f8ddc88"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bmcreations/bale/releases/download/v0.1.0/bale-v0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a93d8d91b7985f7d78e0524dff665e92ef5f7415eee88381769e4ccc64a1ae6c"
    end
    on_intel do
      url "https://github.com/bmcreations/bale/releases/download/v0.1.0/bale-v0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "627d2449cfea8a42a99c53207ea5f4f96ba9908fc21714c92bf77f15bc9fc698"
    end
  end

  def install
    bin.install "bale"
  end

  def caveats
    <<~EOS
      Start the sweep and hook your agent tools:
        bale install
        bale install --hooks claude
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bale --version")
  end
end
