cask "intellij-idea19" do
  version "2019.3.5"
  sha256 "196b739562012f2bbab22362d6a3094a1806acf1e1d0279b536f5f0327796a0d"

  url "https://download.jetbrains.com/idea/ideaIU-#{version}.dmg"
  appcast "https://data.services.jetbrains.com/products/releases?code=IIU&latest=false&type=release"
  name "IntelliJ IDEA Ultimate"
  desc "IDE for JVM languages"
  homepage "https://www.jetbrains.com/idea/"

  auto_updates true

  app "IntelliJ IDEA.app"

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "idea") }.each do |path|
      if File.exist?(path) &&
         File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Preferences/com.jetbrains.intellij.plist",
    "~/Library/Caches/IntelliJIdea#{version.major_minor}",
    "~/Library/Logs/IntelliJIdea#{version.major_minor}",
    "~/Library/Application Support/IntelliJIdea#{version.major_minor}",
    "~/Library/Preferences/IntelliJIdea#{version.major_minor}",
    "~/Library/Saved Application State/com.jetbrains.intellij.savedState",
  ]
end
