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
  version "0.1.4"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://commission.sh/download/v0.1.4/commission-darwin-arm64"
      sha256 "bf838662a8a6e0a736b8bd193503a37083bc230adea9fdff15230212a5c550a0"
    end
    on_intel do
      url "https://commission.sh/download/v0.1.4/commission-darwin-x64"
      sha256 "2ec980a307f0f300f08bec28cce222c031915e8190652a9ebe8491ed5a9d8123"
    end
  end

  on_linux do
    on_arm do
      url "https://commission.sh/download/v0.1.4/commission-linux-arm64"
      sha256 "a5cabd85b081d26dd1205e9457165fc7aac52f80b50574d6fbf22816ce860016"
    end
    on_intel do
      url "https://commission.sh/download/v0.1.4/commission-linux-x64"
      sha256 "98650e79a4a9b0b185e570f9705eb16686f00686d5b5c691d079f63bbe910bc2"
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
