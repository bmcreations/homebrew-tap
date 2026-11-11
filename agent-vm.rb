class AgentVm < Formula
  desc "Headless macOS guests that agents drive and record, and people watch in a browser"
  homepage "https://github.com/bmcreations/agent-vm"
  url "https://github.com/bmcreations/agent-vm/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f6f9f57afeb9f2d488a5ef881d7223dce340f7769f4945a592d20986e615560a"
  license "MIT"
  head "https://github.com/bmcreations/agent-vm.git", branch: "main"

  depends_on arch: :arm64
  depends_on macos: :sonoma
  depends_on "agent-desktop"
  depends_on "ffmpeg"

  def install
    cd "runner" do
      system "swift", "build", "-c", "release", "--disable-sandbox"
    end
    libexec.install "runner/.build/release/agent-vm-runner"
    # Virtualization.framework refuses a process without this entitlement.
    system "codesign", "--force", "--sign", "-",
           "--entitlements", "runner/agent-vm-runner.entitlements",
           libexec/"agent-vm-runner"
    libexec.install "vm", "provision", "fps", "guest"
    bin.install_symlink libexec/"vm" => "agent-vm"
    pkgshare.install "skills", "AGENTS.md", ".claude-plugin"
  end

  def caveats
    <<~EOS
      Guests, the restore image and the ssh key live in ~/.agent-vm.
      The first `agent-vm up` downloads about 25 GB and needs sudo for
      provisioning; run `sudo -v` first in an agent's shell.

      The agent skills are in #{opt_pkgshare}/skills. In Claude Code:
        /plugin marketplace add bmcreations/agent-vm
    EOS
  end

  test do
    assert_match "agent-desktop in the guest", shell_output("#{bin}/agent-vm help")
    assert_predicate libexec/"agent-vm-runner", :executable?
  end
end
