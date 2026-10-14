class Loomy < Formula
  desc "AI development team, orchestrated: Claude Code and Codex on your projects"
  homepage "https://github.com/Eydenn/loomy"
  url "https://github.com/Eydenn/loomy/archive/refs/tags/v0.17.1.tar.gz"
  sha256 "225787a66d34d99e0fe67d1b9c2e3431013550d32878e3bf97e64f152cd2a289"
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
