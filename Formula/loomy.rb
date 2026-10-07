class Loomy < Formula
  desc "AI development team, orchestrated: Claude Code and Codex on your projects"
  homepage "https://github.com/Eydenn/loomy"
  url "https://github.com/Eydenn/loomy/archive/refs/tags/v0.13.0.tar.gz"
  sha256 "fff5ddd19c8d4f91c0fd36bef5fee3bb313da336868764674222958334915343"
  license "Apache-2.0"
  head "https://github.com/Eydenn/loomy.git", branch: "main"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/loomy"
  end

  def caveats
    <<~EOS
      Check the machine with:
        loomy doctor --fix --live
      Then create a project:
        loomy init
    EOS
  end

  test do
    assert_match "loomy #{version}", shell_output("#{bin}/loomy version")
  end
end
