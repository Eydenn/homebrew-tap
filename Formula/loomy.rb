class Loomy < Formula
  desc "AI development team, orchestrated: Claude Code and Codex on your projects"
  homepage "https://github.com/Eydenn/loomy"
  url "https://github.com/Eydenn/loomy/archive/refs/tags/v0.16.0.tar.gz"
  sha256 "1d6fd6f678fe072b48bde5bae9058e9947a5706a7ed7168fe46e19367af4c00e"
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
