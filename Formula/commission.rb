# Homebrew formula for Commission. Generated on release by
# scripts/release-notes.ts — do not hand-edit the copy in the tap.
#
# A cask would be wrong here: this is a CLI, not an app bundle. A
# build-from-source formula would also be wrong — the source is private, and
# homebrew-core will not take a proprietary formula, which is why this lives in
# a tap of its own.
class Commission < Formula
  desc "The execution layer for software delivery"
  homepage "https://commission.sh"
  version "0.1.7"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://commission.sh/download/v0.1.7/commission-darwin-arm64"
      sha256 "a26ae2c3cb7c6b984035297f1b933a0c23f4cf99c998427686c3f9b24ef8c45d"
    end
    on_intel do
      url "https://commission.sh/download/v0.1.7/commission-darwin-x64"
      sha256 "fd7b3952406469916ec6d2805767f4fca71bd416733d443723e39916fb3d1e0c"
    end
  end

  on_linux do
    on_arm do
      url "https://commission.sh/download/v0.1.7/commission-linux-arm64"
      sha256 "f4cac3ed2dfa764c4cb214757b0ea3402fd60f925f0af24607c8652f11f4d7fb"
    end
    on_intel do
      url "https://commission.sh/download/v0.1.7/commission-linux-x64"
      sha256 "7f15b0145e9c5f26ce1e46f1b61cef370c573c13504ff0f93ea58ad64376a3e4"
    end
  end

  def install
    bin.install Dir["commission-*"].first => "commission"
  end

  def caveats
    <<~EOS
      Commission is licensed. A person signs in once on this machine and every
      agent on it inherits the licence:

        commission login
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/commission --version")
    # An unlicensed binary must refuse cleanly rather than crash: exit 2, in
    # Commission's refusal shape. `brew test` runs with no licence, which makes
    # this the honest thing to assert here.
    output = shell_output("COMMISSION_STRICT_AUTH=1 #{bin}/commission board 2>&1", 2)
    assert_match "licensed", output
  end
end
