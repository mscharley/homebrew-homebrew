# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
class Alacritty < Formula
  desc "A cross-platform, GPU-accelerated terminal emulator"
  homepage "https://github.com/jwilm/alacritty"
  head "https://github.com/jwilm/alacritty.git", using: :git
  # version "0.1.0"
  # revision 0
  # sha256 ""

  depends_on "cmake" => :build
  depends_on "rust" => :build
  depends_on "fontconfig"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    system "make", "app"

    bin.install "target/release/osx/Alacritty.app"
    (share / "alacritty").install *Dir["alacritty*.yml"]
  end

  def caveats
    <<-EOS.undent
      Although it is possible that the default configuration will work on your
      system, you will probably end up wanting to customize it anyhow. You can
      find a copy of the default configuration at:

        /usr/local/share/alacritty/alacritty_macos.yml

      You can copy this file to ~/.alacritty.yml and edit as you please.
    EOS
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test alacritty`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
