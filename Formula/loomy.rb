# Formule Homebrew de Loomy. Le dépôt source est privé.
#
# Homebrew clone les sources dans un bac à sable qui n'a pas accès au trousseau macOS : le jeton
# GitHub lui est transmis par HOMEBREW_GITHUB_API_TOKEN, le temps du téléchargement seulement.
#   HOMEBREW_GITHUB_API_TOKEN="$(gh auth token)" brew install eydenn/tap/loomy
# « loomy update » le fait automatiquement.
class LoomyPrivateGitDownloadStrategy < GitDownloadStrategy
  def fetch(timeout: nil)
    token = ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", "")
    return super if token.empty?

    # Équivaut à « git -c http.https://github.com/.extraheader=… » : rien n'est écrit dans le dépôt cloné.
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
  desc "Démarre et structure des projets avec Codex et Claude Code"
  homepage "https://github.com/Eydenn/loomy"
  url "https://github.com/Eydenn/loomy.git",
      tag:      "v0.1.25",
      revision: "024e1be7b0b9b92c8615a5a8a14580a3e27105b2",
      using:    LoomyPrivateGitDownloadStrategy
  version "0.1.25"
  head "https://github.com/Eydenn/loomy.git", branch: "main", using: LoomyPrivateGitDownloadStrategy

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/loomy"
  end

  def caveats
    <<~EOS
      Vérifiez la machine avec :
        loomy doctor --fix --live
      Suivi en direct d'un projet :
        loomy watch
    EOS
  end

  test do
    assert_match "loomy #{version}", shell_output("#{bin}/loomy version")
  end
end
