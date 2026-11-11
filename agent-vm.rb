class AgentVm < Formula
  desc "Headless macOS guests that agents drive and record, and people watch in a browser"
  homepage "https://github.com/bmcreations/agent-vm"
  url "https://github.com/bmcreations/agent-vm/releases/download/v0.2.0/agent-vm-0.2.0-arm64-apple-darwin.tar.gz"
  sha256 "38f766f178326d7c5a23d7101f2c2b1de36a4aaadd435345a5fd140ab7e317eb"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :sonoma
  depends_on "agent-desktop"
  depends_on "ffmpeg"

  def install
    # The release ships the runner built and signed with the virtualization
    # entitlement, and the guest's rec and vsync built, so nothing compiles.
    libexec.install "vm", "provision", "fps", "guest", "guest-bin", "agent-vm-runner"
    bin.install_symlink libexec/"vm" => "agent-vm"
    pkgshare.install "skills", "AGENTS.md", ".claude-plugin"
  end

  def caveats
    <<~EOS
      Guests, the restore image and the ssh key live in ~/.agent-vm.
      The first `agent-vm up` downloads about 25 GB, needs sudo for
      provisioning (run `sudo -v` first in an agent's shell), and builds the
      prepared guest new guests copy, about 10 minutes once.

      The agent skills are in #{opt_pkgshare}/skills. In Claude Code:
        /plugin marketplace add bmcreations/agent-vm
    EOS
  end

  test do
    assert_match "agent-desktop in the guest", shell_output("#{bin}/agent-vm help")
    assert_predicate libexec/"agent-vm-runner", :executable?
  end
end
