# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
class Alacritty < Formula
  desc "A cross-platform, GPU-accelerated terminal emulator"
  homepage "https://github.com/jwilm/alacritty"
  head "git@github.com:jwilm/alacritty.git", using: :git
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
