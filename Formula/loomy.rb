# Loomy's Homebrew formula. The source repository is private.
#
# Homebrew clones the sources in a sandbox without access to the macOS keychain: the GitHub
# token is passed through HOMEBREW_GITHUB_API_TOKEN, only for the download.
#   HOMEBREW_GITHUB_API_TOKEN="$(gh auth token)" brew install eydenn/tap/loomy
# "loomy update" does it automatically.
class LoomyPrivateGitDownloadStrategy < GitDownloadStrategy
  def fetch(timeout: nil)
    token = ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", "")
    return super if token.empty?

    # Same as "git -c http.https://github.com/.extraheader=…": nothing is written into the cloned repository.
    header = "Authorization: Basic #{["x-access-token:#{token}"].pack("m0")}"
    saved = ENV.fetch("GIT_CONFIG_PARAMETERS", nil)
    begin
      ENV["GIT_CONFIG_PARAMETERS"] = "'http.https://github.com/.extraheader=#{header}'"
      super
    ensure
      ENV["GIT_CONFIG_PARAMETERS"] = saved
    end
  end
end

class Loomy < Formula
  desc "Starts and structures projects with Codex and Claude Code"
  homepage "https://github.com/Eydenn/loomy"
  url "https://github.com/Eydenn/loomy.git",
      tag:      "v0.7.0",
      revision: "f3f7c604771e2db2c331b2748df2bd5c3b4b9f77",
      using:    LoomyPrivateGitDownloadStrategy
  version "0.7.0"
  head "https://github.com/Eydenn/loomy.git", branch: "main", using: LoomyPrivateGitDownloadStrategy

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/loomy"
  end

  def caveats
    <<~EOS
      Check the machine with:
        loomy doctor --fix --live
      Live tracking of a project:
        loomy watch
    EOS
  end

  test do
    assert_match "loomy #{version}", shell_output("#{bin}/loomy version")
  end
end
